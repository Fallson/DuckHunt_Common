//
//  DHGameChapter.h
//  XDuckHunt
//
//  Created by Fallson on 8/5/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DHConstons.h"

enum CHAPTER_LVL{CHAPTER0=-1,CHAPTER1=0,CHAPTER2,CHAPTER3,CHAPTER4,CHAPTER5,
                 CHAPTER6, CHAPTER7, CHAPTER8, CHAPTER9, CHAPTER10, CHAPTER_MAX};

@interface DHGameChapter : NSObject

+(DHGameChapter *)sharedDHGameChapter;
-(NSMutableArray*)getChapterDucks:(enum CHAPTER_LVL) lvl andWinRect:(CGRect)rect;
-(NSMutableArray*)getBonusDucks:(CGRect)rect;
-(NSMutableArray*)getILoveUBonusDucks:(CGRect)rect;
-(NSMutableArray*)getFallsonBonusDucks:(CGRect)rect;
-(NSMutableArray*)getMO7BonusDucks:(CGRect)rect;
-(NSMutableArray*)getBGDucks:(CGRect)rect;
@end
