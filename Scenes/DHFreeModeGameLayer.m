//
//  DHFreeModeGameLayer.m
//  XDuckHunt
//
//  Created by Fallson on 7/27/13.
//  Copyright Fallson 2013. All rights reserved.
//


// Import the interfaces
#import "DHFreeModeGameLayer.h"
#import "CCTouchDispatcher.h"
// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "DHBackGroundObj.h"
#import "DHDuckObj.h"
#import "DHPilot.h"
#import "DHConstons.h"
#import "DHGameChapter.h"
#import "DHFreeModePannelObj.h"
#import "DHDogObj.h"
#import "DHGameData.h"
#import "DHGameOverLayer.h"
#import "DHIntroPannelObj.h"
#import "SimpleAudioEngine.h"
#import "DHGameMenuLayer.h"
#import "DHScore.h"
#import "DHFreeModeContinueLayer.h"
#import "DHHintObj.h"
#import "DHPlaneObj.h"
#pragma mark - DHFreeModeGameLayer

@interface DHFreeModeGameLayer()
@property (nonatomic,retain) NSMutableArray* ducks;
@end

// DHFreeModeGameLayer implementation
@implementation DHFreeModeGameLayer
{
    DHBackGroundObj* _bgObj;
    CGRect           _bgRect;
    
    int              _cur_chp;
    int              _next_chp;
    CGRect           _duckRect;
    
    DHFreeModePannelObj* _pannel;
    CGRect            _pannelRect;
    
    DHDogObj*      _dogObj;
    CGRect         _dogRect;
    
    DHIntroPannelObj* _introObj;
    CGRect            _introRect;
    
    DHHintObj*     _hintObj;
    CGRect         _hintRect;
    
    DHPlaneObj*    _planeObj;
    CGRect         _planeRect;
    
    ccTime         _nextDuckTime;
    ccTime         _gameTime;
    int            _gameLvl;
    
    int            _hit_count;
    int            _miss_count;
    GameHit        _game_hit;
    int            _gameScore;
    
    enum GAME_BONUS_TYPE _gameBonus;
    int                  _gameBonusLvl;
    
    
    bool           _gameover;
}
@synthesize ducks = _ducks;


// Helper class method that creates a Scene with the DHFreeModeGameLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	DHFreeModeGameLayer *layer = [DHFreeModeGameLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

#pragma mark - init part
// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) )
    {
        [DHGameData sharedDHGameData].cur_game_mode = FREE_MODE;
        
        [self initBG];
        [self initDog];
        [self initIntro];
        [self initDucks];
        [self initPannel];
        [self initPauseMenu];
        [self initHint];
        [self initPlane];
        
        _nextDuckTime = 0;
        _gameTime = 0;
        _gameLvl = 0;
        
        _hit_count = 0;
        _game_hit.duck_hit = 0;
        _game_hit.bird_hit = 0;
        _game_hit.parrot_hit = 0;
        _miss_count = 0;
        _gameScore = 0;
        
        _gameBonus = 0;
        _gameBonusLvl = 1;
        
        _gameover = false;
        
        //[self schedule:@selector(nextFrame:)];
        [self scheduleUpdate];
        
        //self.isTouchEnabled = YES;
        [self setTouchEnabled:YES];
    }
	return self;
}

-(void)initBG
{
    CGSize sz = [ [CCDirector sharedDirector] winSize];
    CGPoint ori = ccp(0,0);
    _bgRect.origin = ori;
    _bgRect.size = sz;
    _bgObj = [[DHBackGroundObj alloc] initWithWinRect: _bgRect];
    [_bgObj addtoScene: self];
}

-(void)initDog
{
    _dogRect = _bgRect;
    _dogRect.size.height *= 0.25;
    
    _dogObj = [[DHDogObj alloc] initWithWinRect:_dogRect];
    [_dogObj addtoScene: self];
}
 
-(void)initIntro
{
    _introRect = _bgRect;
    _introRect.origin.y +=0.25*_introRect.size.height;
    _introRect.size.height *= 0.65;
    
    _introObj = [[DHIntroPannelObj alloc] initWithWinRect:_introRect];
    [_introObj addtoScene:self];
}

-(void)initDucks
{
    _duckRect = _bgRect;
    _duckRect.origin.y += 0.25*_duckRect.size.height;
    _duckRect.size.height *= 0.75;
    
    _cur_chp = CHAPTER0;
    _next_chp = _cur_chp + FREEMODE_CHAPTER_STEP;
    _ducks = [[NSMutableArray alloc] init];
}

-(void)initPannel
{
    _pannelRect = _bgRect;
    _pannelRect.origin.y += 0.9*_pannelRect.size.height;
    _pannelRect.size.height *= 0.1;
    _pannel = [[DHFreeModePannelObj alloc] initWithWinRect:_pannelRect];
    [_pannel addtoScene:self];
}

-(void)initHint
{
    _hintRect = _bgRect;
    
    _hintObj = [[DHHintObj alloc] initWithWinRect:_hintRect andType:TURTLE_HINT];
    [_hintObj addtoScene:self];
    [_hintObj setVisible:false];
}

-(void)initPlane
{
    _planeRect = _bgRect;
    
    _planeObj = [[DHPlaneObj alloc] initWithWinRect:_planeRect andType:PLANE1];
    [_planeObj addtoScene:self];
    [_planeObj setVisible:false];
}

-(void)initPauseMenu
{
    CGRect rect = _bgRect;
    CCMenuItem *menuitem_pause = [CCMenuItemImage
                                  itemWithNormalImage:@"Pause.png" selectedImage:@"Pause.png"
                                  target:self selector:@selector(PauseMenuPressed:)];
    menuitem_pause.position = ccp(rect.origin.x + rect.size.width*0.85, rect.origin.y + rect.size.height*0.1);
    menuitem_pause.scale *= (0.5*CC_CONTENT_SCALE_FACTOR()*[[DHGameData sharedDHGameData] getScale]);
    
    CCMenu* main_menu = [CCMenu menuWithItems:menuitem_pause, nil];
    main_menu.position = CGPointZero;
    [self addChild:main_menu];
}

-(void)PauseMenuPressed:(id)sender
{
    [DHGameData sharedDHGameData].cur_game_pause = 1;
    //[[CCDirector sharedDirector] replaceScene: [CCTransitionFade transitionWithDuration:0.1 scene:[DHGameScoreListLayer scene] ]];
    [[CCDirector sharedDirector] pushScene: [CCTransitionFade transitionWithDuration:0.1 scene:[DHGameMenuLayer scene] ]];
}

#pragma mark - update part
-(void) update:(ccTime)dt
{
    [self updateBG:dt];
    [self updateDog:dt];
    [self updateIntro:dt];
    [self updatePannel:dt];
    [self updateHint:dt];
    [self updatePlane:dt];
    
    if( _dogObj.dog_state == DOG_DISAPPEAR )
    {
        [_introObj removeFromScene:self];
        
        _gameTime += dt;
        [self updateDucks:dt];
        
        if(FREEMODE_TOTAL_DUCK <= _miss_count)
        {
            [self game_over];
        }
        
        if( _cur_chp == _next_chp && !_gameover )
        {
            _next_chp += FREEMODE_CHAPTER_STEP;
            [self game_continue];
        }
        
        static int fallson_bonus_idx = 1;
        if( _gameLvl >= FREEMODE_CHAPTER_STEP*fallson_bonus_idx ) //
        {
            [_hintObj setVisible:true];
            fallson_bonus_idx++;
        }
    }
}

-(void) updateBG:(ccTime)dt
{
    [_bgObj update:dt];
}

-(void) updateDog:(ccTime)dt
{
    [_dogObj update:dt];
}
 
-(void) updateIntro:(ccTime)dt
{
    [_introObj update:dt];
}

-(void)updateHint:(ccTime)dt
{
    [_hintObj update:dt];
}

-(void)updatePlane:(ccTime)dt
{
    [_planeObj update:dt];
}

-(void) updateDucks:(ccTime)dt
{
    bool need_release_ducks = true;
  
    NSMutableIndexSet* discardItems = [NSMutableIndexSet indexSet];
    NSUInteger index = 0;
    for( DHDuckObj* duckObj in _ducks )
    {
        [duckObj update:dt];
        
        if( duckObj.duck_living_time > DUCK_FLYAWAY_TIME && duckObj.duck_state == FLYING )
        {
            duckObj.duck_state = START_FLYAWAY;
            _miss_count++;
        }
        
        if( duckObj.duck_state == DISAPPEAR )
        {
            [discardItems addIndex:index];
            [duckObj removeFromScene:self];
        }
        else
        {
            need_release_ducks = false;
        }
        index++;
    }
    [_ducks removeObjectsAtIndexes:discardItems];

    
    if( _gameTime >= _nextDuckTime || need_release_ducks ) //time out and release ducks
    {
        if( _gameTime >= _nextDuckTime )
        {
            _nextDuckTime += DUCK_FLYAWAY_TIME;
        }
        else
        {
            _nextDuckTime = _gameTime + DUCK_FLYAWAY_TIME;
        }
        
        NSMutableArray* new_ducks = nil;
        switch (_gameBonus)
        {
            case NONE_BONUS:
            {
                _cur_chp++;
                if( _cur_chp >= CHAPTER_MAX )
                {
                    _cur_chp = CHAPTER_MAX-1;
                }
                new_ducks = [[DHGameChapter sharedDHGameChapter] getChapterDucks:_cur_chp andWinRect:_duckRect];
            }
                break;
            case FALLSON_BONUS:
            {
                _cur_chp++;
                if( _cur_chp >= CHAPTER_MAX )
                {
                    _cur_chp = CHAPTER_MAX-1;
                }
                new_ducks = [[DHGameChapter sharedDHGameChapter] getChapterDucks:_cur_chp andWinRect:_duckRect];
                [new_ducks addObjectsFromArray:[[DHGameChapter sharedDHGameChapter] getFallsonBonusDucks:_duckRect]];
            }
                break;
            case NORMAL_BONUS:
            {
                new_ducks = [[DHGameChapter sharedDHGameChapter] getBonusDucks:_duckRect];
            }
                break;
            case ILOVEU_BONUS:
            {
                new_ducks = [[DHGameChapter sharedDHGameChapter] getILoveUBonusDucks:_duckRect];
            }
                break;
            case MO7_BONUS:
            {
                new_ducks = [[DHGameChapter sharedDHGameChapter] getMO7BonusDucks:_duckRect];
            }
                break;
            default:
                break;
        }
        _gameLvl++;
        _gameBonus = NONE_BONUS;
        
        if( new_ducks != nil )
        {
            for( DHDuckObj* duckObj in new_ducks )
            {
                [duckObj addtoScene:self];
            }
            [_ducks addObjectsFromArray: new_ducks];
        }
    }
}

-(void)updatePannel:(ccTime)dt
{
    [_pannel setLeft_duck:(FREEMODE_TOTAL_DUCK-_miss_count)<0?0:(FREEMODE_TOTAL_DUCK-_miss_count)];
    //[_pannel setHit_count:_hit_count];
    [_pannel setLvl:_gameLvl];
    [_pannel setScore:_gameScore];
    [_pannel setHighest_score:[[DHGameData sharedDHGameData] getHighestScore:FREE_MODE]];
    [_pannel update:dt];
}

-(void)game_continue
{
    [DHGameData sharedDHGameData].cur_game_score = _gameScore;
    [DHGameData sharedDHGameData].cur_game_hit = _game_hit;
    [DHGameData sharedDHGameData].cur_game_miss = _miss_count;
    [[CCDirector sharedDirector] pushScene:[CCTransitionFade transitionWithDuration:0.1 scene:[DHFreeModeContinueLayer scene] ]];
}

-(void)game_over
{
    if( _gameover )
        return;
    
    _gameover = true;
    [DHGameData sharedDHGameData].cur_game_score = _gameScore;
    [DHGameData sharedDHGameData].cur_game_hit = _game_hit;
    [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.1 scene:[DHGameOverLayer scene] ]];    
}

- (void) nextFrame:(ccTime)dt
{
//    CGSize sz = [ [CCDirector sharedDirector] winSize];
//    seeker1.position = ccp( seeker1.position.x + 100*dt, seeker1.position.y );
//    //NSLog(@"rect: (%f, %f)", seeker1.textureRect.size.width, seeker1.textureRect.size.height);
//    if (seeker1.position.x > sz.width+seeker1.textureRect.size.width/20) {
//        seeker1.position = ccp( -seeker1.textureRect.size.width/20, seeker1.position.y );
//    }
}

#pragma mark - touch part
-(void) registerWithTouchDispatcher
{
	[[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    if( [DHGameData sharedDHGameData].bgMusic == 1 )
        [[SimpleAudioEngine sharedEngine] playEffect:@"shoot.wav"];
    
	CGPoint location = [self convertTouchToNodeSpace: touch];
    [self touchDucks:location];
}

-(void)touchDucks:(CGPoint)location
{
    for( DHDuckObj* duckObj in _ducks)
    {
        if( duckObj.duck_state == FLYING || duckObj.duck_state == FLYAWAY )
        {
            bool duckHit = [duckObj hit: location];
            if( duckHit )
            {
                duckObj.duck_state = START_DEAD;
                
                _hit_count++;
                switch( duckObj.duck_type )
                {
                    case BLACK_DUCK:
                    case BLUE_DUCK:
                    case RED_DUCK:
                        _game_hit.duck_hit++;
                        break;
                    case BIRD_DUCK:
                        _game_hit.bird_hit++;
                        break;
                    case PARROT_DUCK:
                        _game_hit.parrot_hit++;
                        break;
                    default:
                        break;
                }
                
                _gameScore += [DHScore GetScoreByType:duckObj.duck_type];
            }
        }
    }
    
    static bool mo7_bonus_active = true;
    if( _gameLvl >= 5 && _gameScore >= 10000 && mo7_bonus_active)
    {
        _gameBonus = MO7_BONUS;
        [_planeObj setVisible:true];
        mo7_bonus_active = false;
    }
    else if( [_hintObj getVisible] && [_hintObj hit:location] )
    {
        _gameBonus = FALLSON_BONUS;
        [_hintObj setVisible:false];
    }
    else if( _gameScore >= _gameBonusLvl * 4000 )
    {
        _gameBonusLvl += 2;
        _gameBonus = NORMAL_BONUS;
    }
}

#pragma mark - dealloc part
// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	[_bgObj release];
    [_ducks release];
    [_pannel release];
    [_dogObj release];
    [_introObj release];
    [_hintObj release];
    [_planeObj release];
    
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
