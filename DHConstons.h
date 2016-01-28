//
//  DHConstons.h
//  XDuckHunt
//
//  Created by Fallson on 8/2/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#ifndef XDuckHunt_DHConstons_h
#define XDuckHunt_DHConstons_h

enum GAME_MODE{FREE_MODE=0, TIME_MODE};
enum DEVICE_TYPE{IPHONE=0, IPAD};
enum GAME_BONUS_TYPE{NONE_BONUS=0,
                     FALLSON_BONUS, //it accompanies with the NONE_BONUS
                     NORMAL_BONUS,
                     ILOVEU_BONUS,
                     MO7_BONUS};

#define HIT_RADIUS     22
#define HIT_RADIUS_POW (HIT_RADIUS*HIT_RADIUS)
#define TIMEMODE_TOTAL_TIME 180
#define FREEMODE_TOTAL_DUCK 3
#define FREEMODE_CHAPTER_STEP 10
#define DUCK_FLYAWAY_TIME 13

#define BG_UPDATE_TIME    0.1
#define PLANE_UPDATE_TIME 0.2
#define HINT_UPDATE_TIME  0.4
#define DUCK_UPDATE_TIME  0.1
#define DOG_UPDATE_TIME   0.1

#define PI  3.14159
#define EPS 0.00001
#define CURVE_RATIO 2

#define Groupfactor   5
#define MaxLineSteps  40
#define MaxCurveSteps 100

#define LAST_CHP_MAX_DUCK_NUM 20
#define FUNNY_CHP_DUCK_NUM 20
#define ILOVEU_I_DUCK_NUM 5  //must be less or equal than FUNNY_CHP_DUCK_NUM
#define ILOVEU_L_DUCK_NUM 20 //must be less or equal than FUNNY_CHP_DUCK_NUM
#define ILOVEU_U_DUCK_NUM 11 //must be less or equal than FUNNY_CHP_DUCK_NUM
#define MO7_M_DUCK_NUM 19 //must be less or equal than FUNNY_CHP_DUCK_NUM
#define MO7_O_DUCK_NUM 20 //must be less or equal than FUNNY_CHP_DUCK_NUM
#define MO7_7_DUCK_NUM 9  //must be less or equal than FUNNY_CHP_DUCK_NUM

#pragma mark - ios version
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#endif
