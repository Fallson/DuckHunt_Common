//
//  DHHintObj.m
//  XDuckHunt
//
//  Created by Fallson on 8/15/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import "DHHintObj.h"
#import "DHZDepth.h"
#import "DHLabel.h"
#import "ccTypes.h"
#import "DHScore.h"
#import "DHGameData.h"

static NSString* hint_files[]={
    @"turtle"};

@interface DHHintObj()
{
    ccTime _accDT;
    CGRect _winRect;
    
    bool _scale_factor;
}

@property (nonatomic, retain) CCSprite* hint;
@end

@implementation DHHintObj
@synthesize hint_type = _hint_type;
@synthesize hint_size = _hint_size;
@synthesize visible = _visible;
@synthesize hint = _hint;

-(id)initWithWinRect:(CGRect)rect andType:(enum HINT_TYPE) type
{
    if( (self=[super init]) )
    {
        _winRect = rect;
        self.hint_type = type;
        
        self.hint = [CCSprite spriteWithFile: [NSString stringWithFormat:@"%@.png", hint_files[self.hint_type]]];
        self.hint.scale = 0.5*CC_CONTENT_SCALE_FACTOR()*[[DHGameData sharedDHGameData] getScale];
        _hint_size.width = self.hint.contentSize.width * self.hint.scaleX;
        _hint_size.height = self.hint.contentSize.height * self.hint.scaleY;
        self.hint.position = ccp(_winRect.size.width - 55, 80);
        self.hint.zOrder = HINT_Z;
        
        _accDT = 0;
        _scale_factor = true;
        self.visible = false;
    }
    return self;
}

-(void)addtoScene: (CCLayer*)layer
{
    [layer addChild: self.hint];
    self.visible = true;
}

-(void)removeFromScene: (CCLayer*)layer
{
    [layer removeChild:self.hint];
    self.visible = false;
}

-(void)update:(ccTime)dt
{
    _accDT += dt;
    if( _accDT < HINT_UPDATE_TIME )
        return;
    _accDT = 0;
    
    if( _scale_factor )
    {
        self.hint.scale *= 0.8;
        _scale_factor = false;
    }
    else
    {
        self.hint.scale *= 1.25;
        _scale_factor = true;
    }
}

-(bool)hit:(CGPoint)pnt
{
    CGPoint cur = self.hint.position;
    double dist = (cur.x - pnt.x)*(cur.x-pnt.x) + (cur.y-pnt.y)*(cur.y-pnt.y);
    if (  dist < HIT_RADIUS_POW )
    {
        // NSLog(@"hit: cur(%f,%f) vs pnt(%f,%f) = dist(%f)", cur.x, cur.y, pnt.x, pnt.y, dist);
        return true;
    }
    else
    {
        // NSLog(@"not-hit: cur(%f,%f) vs pnt(%f,%f) = dist(%f)", cur.x, cur.y, pnt.x, pnt.y, dist);
        return false;
    }
}

- (void) dealloc
{
    // don't forget to call "super dealloc"
    [super dealloc];
}

@end
