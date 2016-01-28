//
//  DHPlaneObj.h
//  XDuckHunt
//
//  Created by Fallson on 8/18/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

enum PLANE_TYPE{PLANE1=0, PLANE2};

@interface DHPlaneObj : NSObject
@property(nonatomic, assign) enum PLANE_TYPE plane_type;
@property(nonatomic, assign) CGSize plane_size;

-(id)initWithWinRect:(CGRect)rect andType:(enum PLANE_TYPE) type;
-(void)addtoScene: (CCLayer*)layer;
-(void)removeFromScene: (CCLayer*)layer;
-(void)update:(ccTime)dt;
-(void)setVisible:(bool)visible;
-(bool)getVisible;
@end
