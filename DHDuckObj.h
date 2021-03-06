//
//  DHDuckObj.h
//  XDuckHunt
//
//  Created by Fallson on 7/28/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class DHDuckPilot;

enum DUCK_STATE{FLYING=0, START_DEAD, DEAD, START_FLYAWAY, FLYAWAY, DISAPPEAR};
enum DUCK_TYPE{BLACK_DUCK=0, BLUE_DUCK, RED_DUCK, BIRD_DUCK, PARROT_DUCK, FALLSON_DUCK, MAX_DUCK};


@interface DHDuckObj : NSObject

@property(nonatomic, retain) DHDuckPilot* duck_pilot;
@property(nonatomic, assign) enum DUCK_STATE duck_state;
@property(nonatomic, assign) enum DUCK_TYPE duck_type;
@property(nonatomic, assign) CGSize duck_size;
@property(nonatomic, assign) ccTime duck_living_time;

-(id)initWithWinRect: (CGRect)rect;
-(id)initWithWinRect:(CGRect)rect andType:(enum DUCK_TYPE) type;
-(void)addtoScene: (CCLayer*)layer;
-(void)removeFromScene: (CCLayer*)layer;
-(void)updatePos:(CGPoint)pos;
-(void)update:(ccTime)dt;
-(bool)hit:(CGPoint)pnt;

@end
