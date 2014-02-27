//
//  DHLabel.m
//  XDuckHunt
//
//  Created by Fallson on 8/21/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import "DHLabel.h"
#import "DHGameData.h"

@implementation DHLabel
+(NSString*)GetFont
{
    if( [DHGameData sharedDHGameData].cur_game_device == IPHONE )
        return @"Snap ITC.ttf";
    else
        return @"Snap ITC";
}

+(ccColor3B)GetColor
{
    static const ccColor3B ccDH = {255,255,0};
    return ccDH;
}
@end
