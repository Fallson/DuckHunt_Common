//
//  DHHintObj.h
//  XDuckHunt
//
//  Created by Fallson on 8/15/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

enum HINT_TYPE{TURTLE_HINT=0,CIRCLE_HINT};

@interface DHHintObj : NSObject
@property(nonatomic, assign) enum HINT_TYPE hint_type;
@property(nonatomic, assign) CGSize hint_size;

-(id) initWithWinRect: (CGRect)rect andType:(enum HINT_TYPE)type;
-(void)addtoScene: (CCLayer*)layer;
-(void)removeFromScene: (CCLayer*)layer;
-(void)update:(ccTime)dt;
-(bool)hit:(CGPoint)pnt;
-(void)setVisible:(bool)visible;
-(bool)getVisible;
@end
