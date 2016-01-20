//
//  DHGameSplashLayer.m
//  XDuckHunt
//
//  Created by Fallson on 7/27/13.
//  Copyright Fallson 2013. All rights reserved.
//


// Import the interfaces
#import "DHGameSplashLayer.h"
#import "DHGameMenuLayer.h"
#import "SimpleAudioEngine.h"
#import "DHGameData.h"

#pragma mark - DHGameSplashLayer

// HelloWorldLayer implementation
@implementation DHGameSplashLayer

// Helper class method that creates a Scene with the DHGameSplashLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	DHGameSplashLayer *layer = [DHGameSplashLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// 
-(id) init
{
	if( (self=[super init])) {

		// ask director for the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

        // store the relationship of background size vs window size
		CCSprite *background = [CCSprite spriteWithFile: @"bg_sky.png"];
		double width_ratio = background.contentSize.width / size.width;
        double height_ratio = background.contentSize.height / size.height;
        
        GameOriOffset off;
        if( height_ratio < width_ratio )
        {
            off.bg_scale = height_ratio;
        }
        else
        {
            off.bg_scale = width_ratio;
        }
        off.dw = (background.contentSize.width/off.bg_scale - size.width)/2;
        off.dh = (background.contentSize.height/off.bg_scale - size.height)/2;
        off.height = background.contentSize.height/off.bg_scale;
        off.width = background.contentSize.width/off.bg_scale;
        [DHGameData sharedDHGameData].cur_game_ori_offset = off;
        
		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone )
        {
            [DHGameData sharedDHGameData].cur_game_device = IPHONE;
		} else
        {
            [DHGameData sharedDHGameData].cur_game_device = IPAD;
		}
        
        //preload sound
        [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"gameMusic.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"dog.mp3"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"duck_live.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"duck_dead.wav"];
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"shoot.wav"];
	}
	
	return self;
}

-(void) onEnter
{
	[super onEnter];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.1 scene:[DHGameMenuLayer scene] ]];
}
@end
