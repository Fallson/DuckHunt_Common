//
//  DHBackGroundObj.m
//  XDuckHunt
//
//  Created by Fallson on 7/28/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import "DHBackGroundObj.h"
#import "DHConstons.h"
#import "DHZDepth.h"
#import "DHGameData.h"
#import "SimpleAudioEngine.h"
#import "DHDuckObj.h"
#import "DHGameChapter.h"

#define CLOUD_MV_STEP    2
#define CLOUD_Y_POS      0.8
#define SMOKE_SPRITE_NUM 5
#define SMOKE_X_POS (22.2/26.0)
#define SMOKE_Y_POS (7.8/14.5)

@interface DHBackGroundObj()
{
    int _smoke_idx;
    ccTime _accDT;
    CGRect _winRect;
    
    bool _needDuck;
    CGRect _duckRect;
}

@property(nonatomic, retain)CCSprite* bg_sky;
@property(nonatomic, retain)CCSprite* bg_grass;
@property(nonatomic, retain)CCSprite* bg_tree;
@property(nonatomic, retain)CCSprite* bg_cloud;
@property(nonatomic, retain)CCSpriteBatchNode* smoke_spriteSheet;
@property(nonatomic, retain)CCSprite* smoke;
@property(nonatomic, retain)NSMutableArray* ducks;

@end
@implementation DHBackGroundObj

@synthesize bg_sky=_bg_sky;
@synthesize bg_grass=_bg_grass;
@synthesize bg_tree=_bg_tree;
@synthesize bg_cloud=_bg_cloud;
@synthesize smoke_spriteSheet=_smoke_spriteSheet;
@synthesize smoke=_smoke;
@synthesize ducks=_ducks;

-(id) initWithWinRect: (CGRect)rect andDucks:(bool)needDuck
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) )
    {
        _winRect = rect;
        CGSize sz = rect.size;
        CGPoint ori = rect.origin;
        
        self.bg_sky = [CCSprite spriteWithFile: @"bg_sky.png"];
        float scale_r = 1.0 / [DHGameData sharedDHGameData].cur_game_ori_offset.bg_scale;
        //        NSLog(@"sz(%f,%f) and sky(%f,%f), scale_r is: %f", sz.width, sz.height,
        //              self.bg_sky.contentSize.width, self.bg_sky.contentSize.height ,scale_r);
        self.bg_sky.scale = scale_r;
        self.bg_sky.position = ccp( ori.x + sz.width/2, ori.y + sz.height/2 );
        self.bg_sky.zOrder = BG_SKY_Z;
        
        self.bg_grass = [CCSprite spriteWithFile: @"bg_grass.png"];
        self.bg_grass.scaleX = sz.width/self.bg_grass.contentSize.width;
        self.bg_grass.scaleY = sz.height/self.bg_grass.contentSize.height;
        self.bg_grass.position = ccp( ori.x + sz.width/2, ori.y + sz.height/2 );
        self.bg_grass.zOrder = BG_GRASS_Z;
        
        self.bg_tree = [CCSprite spriteWithFile: @"bg_tree.png"];
        self.bg_tree.scaleX = sz.width/self.bg_tree.contentSize.width;
        self.bg_tree.scaleY = sz.height/self.bg_tree.contentSize.height;
        self.bg_tree.position = ccp( ori.x + sz.width/2, ori.y + sz.height/2 );
        self.bg_tree.zOrder = BG_TREE_Z;
        
        self.bg_cloud = [CCSprite spriteWithFile: @"Cloud.png"];
        self.bg_cloud.scale = 0.25*CC_CONTENT_SCALE_FACTOR()*[[DHGameData sharedDHGameData] getScale];
        self.bg_cloud.position = ccp( ori.x, ori.y + [[DHGameData sharedDHGameData] getPos:0 and:CLOUD_Y_POS].y );
        self.bg_cloud.zOrder = BG_CLOUD_Z;
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"sky_smoke.plist"];
        self.smoke_spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"sky_smoke.png"];
        self.smoke = [CCSprite spriteWithSpriteFrameName:@"sky_smoke_1.png"];
        CGPoint smoke_pos = [[DHGameData sharedDHGameData] getPos:SMOKE_X_POS and:SMOKE_Y_POS];
        self.smoke.scale = 0.5*CC_CONTENT_SCALE_FACTOR()*[[DHGameData sharedDHGameData] getScale];
        self.smoke.position = ccp(ori.x + smoke_pos.x,
                                  ori.y + smoke_pos.y + self.smoke.scale*self.smoke.contentSize.height/2);
        self.smoke.zOrder = BG_SMOKE_Z;
        _smoke_idx = 0;
        [self.smoke_spriteSheet addChild:self.smoke];
        self.smoke_spriteSheet.zOrder = BG_SMOKE_Z;
        
        //add ducks
        //_needDuck = needDuck;
        _needDuck = false;
        if( _needDuck )
        {
            _duckRect = _winRect;
            _duckRect.origin.y += 0.25*_duckRect.size.height;
            _duckRect.size.height *= 0.75;
            self.ducks = [[NSMutableArray alloc] initWithArray:[[DHGameChapter sharedDHGameChapter] getBGDucks:_duckRect]];
        }
        
        if( [DHGameData sharedDHGameData].bgMusic==1 )
        {
            if( [SimpleAudioEngine sharedEngine].isBackgroundMusicPlaying )
            {}
            else
            {
                [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"gameMusic.mp3"];
            }
        }
	}
	return self;
}

-(id) initWithWinRect: (CGRect)rect
{
    return [self initWithWinRect:rect andDucks:false];
}

-(void)addtoScene: (CCLayer*)layer
{
    [layer addChild:self.bg_sky];
    [layer addChild:self.bg_grass];
    [layer addChild:self.bg_tree];
    [layer addChild:self.bg_cloud];
    
    [layer addChild:self.smoke_spriteSheet];
    
    if( _needDuck )
    {
        for( DHDuckObj* duckObj in self.ducks )
        {
            [duckObj addtoScene:layer];
        }
    }
}

-(void)update:(ccTime)dt
{
    if( _needDuck )
    {
        //ducks animation first, because there is internal accDT control in duckObj
        for( DHDuckObj* duckObj in self.ducks )
        {
            [duckObj update:dt];
        }
    }
    
    _accDT += dt;
    if( _accDT < BG_UPDATE_TIME )
        return;
    _accDT = 0;
    
    //smoke animation
    _smoke_idx = (++_smoke_idx)%SMOKE_SPRITE_NUM;
    
    NSString* frame_name = [NSString stringWithFormat:@"sky_smoke_%i.png",_smoke_idx+1];
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache]
                            spriteFrameByName:frame_name];
    [self.smoke setDisplayFrame:frame];
    
    //cloud animation
    CGPoint cur = self.bg_cloud.position;
    cur.x += CLOUD_MV_STEP;
    if( cur.x > _winRect.size.width + self.bg_cloud.scale*self.bg_cloud.contentSize.width/2 )
    {
        cur.x = -(self.bg_cloud.scale * self.bg_cloud.contentSize.width/2);
    }
    self.bg_cloud.position = cur;
}

- (void) dealloc
{
    if( _needDuck )
    {
        [_ducks release];
    }
    
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
