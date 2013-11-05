//
//  textFieldMaker.h
//  NishikiFish
//
//  Created by dong hua on 12-8-8.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface textFieldMaker : CCNode {
    
}

+(UITextField*) getTextField:(int) x y:(int) y height:(int) h width:(int) w gate:(id) g;

@end
