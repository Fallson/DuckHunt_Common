//
//  DHPlaneObj.m
//  XDuckHunt
//
//  Created by Fallson on 8/18/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import "DHPlaneObj.h"
#import "DHZDepth.h"
#import "DHConstons.h"
#import "DHGameData.h"
#import "SimpleAudioEngine.h"

#define PLANE_SPRITE_NUM 3
#define PLANE_MV_STEP    4

#pragma mark - DHPlaneObj
static NSString* plane_files[]={
    @"planeA",
    @"planeB"};

static CGFloat plane_height[]={0.8, 0.8};

@interface DHPlaneObj()
{
    int _plane_idx;
    ccTime _accDT;
    CGRect _winRect;
}
@property(nonatomic, retain) CCSpriteBatchNode* plane_spriteSheet;
@property(nonatomic, retain) CCSprite* plane;
@end

@implementation DHPlaneObj

@synthesize plane_type = _plane_type;
@synthesize plane_size = _plane_size;

@synthesize plane_spriteSheet = _plane_spriteSheet;
@synthesize plane = _plane;

-(id)initWithWinRect:(CGRect)rect andType:(enum PLANE_TYPE) type
{
    if( (self=[super init]) )
    {
        _winRect = rect;
        //        NSLog(@"plane rect is: (%f,%f), (%f,%f)", rect.origin.x, rect.origin.y,
        //              rect.size.width, rect.size.height);
        self.plane_type = type;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"%@.plist", plane_files[self.plane_type]]];
        self.plane_spriteSheet = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"%@.png", plane_files[self.plane_type]]];
        self.plane = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"%@_0.png", plane_files[self.plane_type]]];
        self.plane.scale = 0.3*CC_CONTENT_SCALE_FACTOR()*[[DHGameData sharedDHGameData] getScale];
        _plane_size.width = self.plane.contentSize.width * self.plane.scaleX;
        _plane_size.height = self.plane.contentSize.height * self.plane.scaleY;
        
        self.plane.position = ccp(_winRect.size.width ,_winRect.size.height*plane_height[self.plane_type]);
        //self.plane.anchorPoint
        self.plane.zOrder = PLANE_Z;
        [self.plane_spriteSheet addChild:self.plane];
        self.plane_spriteSheet.zOrder = PLANE_Z;
        
        _plane_idx = 0;
        _accDT = 0;
    }
    return self;
}

-(void)addtoScene: (CCLayer*)layer
{
    [layer addChild: self.plane_spriteSheet];
}

-(void)removeFromScene: (CCLayer*)layer
{
    [layer removeChild:self.plane_spriteSheet];
}

-(void)update:(ccTime)dt
{
    _accDT += dt;
    if( _accDT < PLANE_UPDATE_TIME )
        return;
    _accDT = 0;
    
    _plane_idx = (++_plane_idx)%PLANE_SPRITE_NUM;
    
    NSString* frame_name = [NSString stringWithFormat:@"%@_%d.png",plane_files[self.plane_type],_plane_idx];
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                            spriteFrameByName:frame_name];
    [self.plane setDisplayFrame:frame];
    
    CGPoint cur = self.plane.position;
    cur.x -= PLANE_MV_STEP;
    if( cur.x < 0 )
    {
        cur.x = _winRect.size.width;
    }
    self.plane.position = cur;
}

- (void) dealloc
{
    // don't forget to call "super dealloc"
    [super dealloc];
}
@end
