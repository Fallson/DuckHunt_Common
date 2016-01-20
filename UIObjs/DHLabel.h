//
//  DHLabel.h
//  XDuckHunt
//
//  Created by Fallson on 8/21/13.
//  Copyright (c) 2013 Fallson. All rights reserved.
//

#import "CCLabelTTF.h"

#define DHLABEL_FONT [DHLabel GetFont]

@interface DHLabel : CCLabelTTF
+(NSString*) GetFont;
+(ccColor3B) GetColor;
@end
