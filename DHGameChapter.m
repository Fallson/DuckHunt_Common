//
//  DHGameChapter.m
//  XDuckHunt
//
//  Created by Fallson on 8/5/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//
#import "DHConstons.h"
#import "DHGameChapter.h"
#import "DHDuckObj.h"
#import "DHPilotManager.h"
#import "DHPilot.h"
#import "DHGameData.h"

//Create Ducks2 can set the duck type
#define CREATE_DUCKS_IN_LOOP2 DHDuckObj* duck1 = [[DHDuckObj alloc] initWithWinRect:rect andType:dtypes[i]];\
                              duck1.duck_pilot = [[DHPilotManager sharedDHPilotManager] createPilot:ptypes[i] andWinRect:rect andObjSz:duck1.duck_size andGroupID:i];\
                              [duck1.duck_pilot setSpeedRatio:speeds[i]];\
                              [duck1 updatePos: [duck1.duck_pilot getPosition]];\
                              [ducks addObject:duck1];\

#define CREATE_DUCKS2 for( int i = 0; i < sizeof(ptypes)/sizeof(enum PILOT_TYPE); i++ ){\
                      CREATE_DUCKS_IN_LOOP2}\

#define CREATE_DUCKS_IN_LOOP DHDuckObj* duck1 = [[DHDuckObj alloc] initWithWinRect:rect];\
                             duck1.duck_pilot = [[DHPilotManager sharedDHPilotManager] createPilot:ptypes[i] andWinRect:rect andObjSz:duck1.duck_size andGroupID:i];\
                             [duck1.duck_pilot setSpeedRatio:speeds[i]];\
                             [duck1 updatePos: [duck1.duck_pilot getPosition]];\
                             [ducks addObject:duck1];\

#define CREATE_DUCKS for( int i = 0; i < sizeof(ptypes)/sizeof(enum PILOT_TYPE); i++ ){\
                     CREATE_DUCKS_IN_LOOP}\
//
//#define CREATE_DUCKS for( int i = 0; i < sizeof(ptypes)/sizeof(enum PILOT_TYPE); i++ ){\
//    DHDuckObj* duck1 = [[DHDuckObj alloc] initWithWinRect:rect];\
//    duck1.duck_pilot = [[DHPilotManager sharedDHPilotManager] createPilot:ptypes[i] andWinRect:rect andObjSz:duck1.duck_size andGroupID:i];\
//    [duck1.duck_pilot setSpeedRatio:speeds[i]];\
//    [duck1 updatePos: [duck1.duck_pilot getPosition]];\
//    [ducks addObject:duck1];}\


@implementation DHGameChapter

static DHGameChapter *_sharedDHGameChapter=nil;

+(DHGameChapter *)sharedDHGameChapter
{
	if (!_sharedDHGameChapter)
		_sharedDHGameChapter = [[DHGameChapter alloc] init];
    
	return _sharedDHGameChapter;
}

+(id)alloc
{
	NSAssert(_sharedDHGameChapter == nil, @"Attempted to allocate a second instance of a singleton.");
	return [super alloc];
}

-(id)init
{
	if( (self=[super init]) )
    {
	}
    
	return self;
}

-(void)setDucks_Chapter1:(NSMutableArray*)ducks andWinRect:(NSValue*)rectValue
{
    CGRect rect = [rectValue CGRectValue];
    
    enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_NORMAL, DUCK_NORMAL};
    float speeds[] = {1.0, 1.0, 1.0};
    
    CREATE_DUCKS
}

-(void)setDucks_Chapter2:(NSMutableArray*)ducks andWinRect:(NSValue*)rectValue
{
    CGRect rect = [rectValue CGRectValue];
    

    enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_NORMAL, DUCK_SIN,
        DUCK_ELLIPSE};
    float speeds[] = {1.0, 1.0, 1.2, 1.0};
    
    CREATE_DUCKS
}

-(void)setDucks_Chapter3:(NSMutableArray*)ducks andWinRect:(NSValue*)rectValue
{
    CGRect rect = [rectValue CGRectValue];
    
    enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_SIN,
        DUCK_NORMAL, DUCK_EIGHT};
    float speeds[] = {1.0, 1.0, 1.2, 1.2, 1.0};
    
    CREATE_DUCKS
}

-(void)setDucks_Chapter4:(NSMutableArray*)ducks andWinRect:(NSValue*)rectValue
{
    CGRect rect = [rectValue CGRectValue];
    
    enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN,
        DUCK_NORMAL, DUCK_EIGHT};
    float speeds[] = {1.0, 1.2, 1.5, 1.5, 1.2, 1.0};
    CREATE_DUCKS
}

-(void)setDucks_Chapter5:(NSMutableArray*)ducks andWinRect:(NSValue*)rectValue
{
    CGRect rect = [rectValue CGRectValue];
    
    enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN,
        DUCK_NORMAL, DUCK_EIGHT};
    float speeds[] = {1.2, 1.5, 1.8, 1.8, 1.5, 1.2};
    CREATE_DUCKS
}

-(void)setDucks_Chapter6:(NSMutableArray*)ducks andWinRect:(NSValue*)rectValue
{
    CGRect rect = [rectValue CGRectValue];
    
    enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN,
        DUCK_NORMAL, DUCK_NORMAL, DUCK_EIGHT};
    float speeds[] = {1.5, 1.8, 1.8, 1.5, 1.5, 1.8, 1.5};
    
    CREATE_DUCKS
}

-(void)setDucks_Chapter7:(NSMutableArray*)ducks andWinRect:(NSValue*)rectValue
{
    CGRect rect = [rectValue CGRectValue];

    enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN,
        DUCK_NORMAL, DUCK_NORMAL, DUCK_EIGHT, DUCK_SIN};
    float speeds[] = {1.5, 1.8, 2.0, 1.8, 2.0, 1.8, 1.5, 1.8};
    CREATE_DUCKS
}

-(void)setDucks_Chapter8:(NSMutableArray*)ducks andWinRect:(NSValue*)rectValue
{
    CGRect rect = [rectValue CGRectValue];
    
    enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN,
        DUCK_NORMAL, DUCK_NORMAL, DUCK_EIGHT, DUCK_SIN};
    float speeds[] = {1.8, 2.0, 1.8, 2.0, 2.0, 2.0, 2.0, 2.0};
    CREATE_DUCKS
}

-(void)setDucks_Chapter9:(NSMutableArray*)ducks andWinRect:(NSValue*)rectValue
{
    CGRect rect = [rectValue CGRectValue];
    

    enum PILOT_TYPE ptypes[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN,
        DUCK_NORMAL, DUCK_NORMAL, DUCK_EIGHT, DUCK_SIN,
        DUCK_ELLIPSE};
    float speeds[] = {2.0, 2.0, 2.2, 2.5, 2.2, 2.0, 2.2, 2.2, 2.0};
    
    CREATE_DUCKS
}

-(void)setDucks_Chapter10:(NSMutableArray*)ducks andWinRect:(NSValue*)rectValue
{
    CGRect rect = [rectValue CGRectValue];
    
    enum PILOT_TYPE ptypes[LAST_CHP_MAX_DUCK_NUM];
    float speeds[LAST_CHP_MAX_DUCK_NUM];
    int duck_num = (arc4random()%11 + 10);
    for( int i = 0; i < duck_num; i++ )
    {
        ptypes[i] = DUCK_NORMAL;
        speeds[i] = 2.5 + (float)(arc4random()%10)/(float)10.0;
        if( speeds[i] > 4.0 )
            speeds[i] = 4.0;
    }
    
    for( int i = 0; i < duck_num; i++ )
    {
        CREATE_DUCKS_IN_LOOP
    }
}

-(NSMutableArray*)getChapterDucks:(enum CHAPTER_LVL) lvl andWinRect:(CGRect)rect
{
    static enum PILOT_TYPE ptypes_candidates[] = {DUCK_EIGHT, DUCK_CIRCLE, DUCK_ELLIPSE, DUCK_SIN,
        DUCK_NORMAL};
    
    if( lvl < CHAPTER1 || lvl >= CHAPTER_MAX )
        return nil;
    
    NSMutableArray* ducks = [NSMutableArray array];
    
    enum PILOT_TYPE ptypes[LAST_CHP_MAX_DUCK_NUM];
    float speeds[LAST_CHP_MAX_DUCK_NUM];
    int duck_num = (arc4random()%(2+lvl*2) + 3);
    if( duck_num > LAST_CHP_MAX_DUCK_NUM )
        duck_num = LAST_CHP_MAX_DUCK_NUM;
    for( int i = 0; i < duck_num; i++ )
    {
        ptypes[i] = ptypes_candidates[arc4random()%(sizeof(ptypes_candidates)/sizeof(enum PILOT_TYPE))];
        speeds[i] = 1.0 + (float)(arc4random()%(2+lvl))/(float)4.0;
    }
    
    for( int i = 0; i < duck_num; i++ )
    {
        CREATE_DUCKS_IN_LOOP
    }
    
    return ducks;
    
#if 0
    SEL funs[] = {
        @selector(setDucks_Chapter1:andWinRect:),
        @selector(setDucks_Chapter2:andWinRect:),
        @selector(setDucks_Chapter3:andWinRect:),
        @selector(setDucks_Chapter4:andWinRect:),
        @selector(setDucks_Chapter5:andWinRect:),
        @selector(setDucks_Chapter6:andWinRect:),
        @selector(setDucks_Chapter7:andWinRect:),
        @selector(setDucks_Chapter8:andWinRect:),
        @selector(setDucks_Chapter9:andWinRect:),
        @selector(setDucks_Chapter10:andWinRect:)};
    
    NSMutableArray* ducks = [NSMutableArray array];
    NSValue* rectValue = [NSValue valueWithCGRect:rect];
    [self performSelector:funs[(int)lvl] withObject:ducks withObject:rectValue];
    
    return ducks;
#endif
    
}

-(NSMutableArray*)getBonusDucks:(CGRect)rect
{
    NSMutableArray* ducks = [NSMutableArray array];
    
    enum PILOT_TYPE ptypes_candidates[] = {DUCK_EIGHT_GROUP,
        DUCK_CIRCLE_GROUP,
        DUCK_ELLIPSE_GROUP,
        DUCK_SIN_GROUP,
        DUCK_ILOVEU_I};
    enum PILOT_TYPE type = ptypes_candidates[arc4random()%(sizeof(ptypes_candidates)/sizeof(enum PILOT_TYPE))];
    
    switch(type)
    {
        case DUCK_EIGHT_GROUP:
        case DUCK_CIRCLE_GROUP:
        case DUCK_ELLIPSE_GROUP:
        case DUCK_SIN_GROUP:
        {
            enum DUCK_TYPE dtypes[FUNNY_CHP_DUCK_NUM];
            enum PILOT_TYPE ptypes[FUNNY_CHP_DUCK_NUM];
            float speeds[FUNNY_CHP_DUCK_NUM];
            for( int i = 0; i < FUNNY_CHP_DUCK_NUM; i++ )
            {
                dtypes[i] = BLACK_DUCK;
                ptypes[i] = type;
                speeds[i] = 1.0;
            }
            
            CREATE_DUCKS2
        }
            break;
        case DUCK_ILOVEU_I:
        {
            ducks = [self getILoveUBonusDucks:rect];
        }
            break;
        default:
            break;
    }
    
    return ducks;
}

-(NSMutableArray*)getILoveUBonusDucks:(CGRect)rect
{
    NSMutableArray* ducks = [NSMutableArray array];
    
    //I
    enum DUCK_TYPE dtypes[FUNNY_CHP_DUCK_NUM];
    enum PILOT_TYPE ptypes[FUNNY_CHP_DUCK_NUM];
    float speeds[FUNNY_CHP_DUCK_NUM];
    for( int i = 0; i < ILOVEU_I_DUCK_NUM; i++ )
    {
        dtypes[i] = BLACK_DUCK;
        ptypes[i] = DUCK_ILOVEU_I;
        speeds[i] = 1.0;
    }
    for( int i = 0; i < ILOVEU_I_DUCK_NUM; i++ )
    {
        CREATE_DUCKS_IN_LOOP2
    }
    
    //Love
    for( int i = 0; i < ILOVEU_L_DUCK_NUM; i++ )
    {
        dtypes[i] = BLACK_DUCK;
        ptypes[i] = DUCK_ILOVEU_L;
        speeds[i] = 1.0;
    }
    for( int i = 0; i < ILOVEU_L_DUCK_NUM; i++ )
    {
        CREATE_DUCKS_IN_LOOP2
    }
    
    //U
    for( int i = 0; i < ILOVEU_U_DUCK_NUM; i++ )
    {
        dtypes[i] = BLACK_DUCK;
        ptypes[i] = DUCK_ILOVEU_U;
        speeds[i] = 1.0;
    }
    for( int i = 0; i < ILOVEU_U_DUCK_NUM; i++ )
    {
        CREATE_DUCKS_IN_LOOP2
    }
    
    return ducks;
}

-(NSMutableArray*)getFallsonBonusDucks:(CGRect)rect
{
    NSMutableArray* ducks = [NSMutableArray array];
    
    enum DUCK_TYPE dtypes[1]={FALLSON_DUCK};
    enum PILOT_TYPE ptypes[1]={DUCK_NORMAL};
    float speeds[1]={6.0};
    
    CREATE_DUCKS2
    
    return ducks;
}

-(NSMutableArray*)getMO7BonusDucks:(CGRect)rect
{
    NSMutableArray* ducks = [NSMutableArray array];
    
    //M
    enum DUCK_TYPE dtypes[FUNNY_CHP_DUCK_NUM];
    enum PILOT_TYPE ptypes[FUNNY_CHP_DUCK_NUM];
    float speeds[FUNNY_CHP_DUCK_NUM];
    for( int i = 0; i < MO7_M_DUCK_NUM; i++ )
    {
        dtypes[i] = BLACK_DUCK;
        ptypes[i] = DUCK_MO7_M;
        speeds[i] = 1.0;
    }
    for( int i = 0; i < MO7_M_DUCK_NUM; i++ )
    {
        CREATE_DUCKS_IN_LOOP2
    }
    
    //O
    for( int i = 0; i < MO7_O_DUCK_NUM; i++ )
    {
        dtypes[i] = BLACK_DUCK;
        ptypes[i] = DUCK_MO7_O;
        speeds[i] = 1.0;
    }
    for( int i = 0; i < MO7_O_DUCK_NUM; i++ )
    {
        CREATE_DUCKS_IN_LOOP2
    }
    
    //7
    for( int i = 0; i < MO7_7_DUCK_NUM; i++ )
    {
        dtypes[i] = BLACK_DUCK;
        ptypes[i] = DUCK_MO7_7;
        speeds[i] = 1.0;
    }
    for( int i = 0; i < MO7_7_DUCK_NUM; i++ )
    {
        CREATE_DUCKS_IN_LOOP2
    }

    return ducks;
}

-(NSMutableArray*)getBGDucks:(CGRect)rect
{
    NSMutableArray* ducks = [NSMutableArray array];

    enum DUCK_TYPE dtypes[4]={BLACK_DUCK,BLUE_DUCK,RED_DUCK,PARROT_DUCK};
    enum PILOT_TYPE ptypes[4]={DUCK_SIN,DUCK_SIN,DUCK_SIN,DUCK_SIN};
    float speeds[4]={1.0,1.5,1.5,1.5};

    CREATE_DUCKS2
    
    return ducks;
}

@end
