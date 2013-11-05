//
//  Jelly.h
//  NishikiFish
//
//  Created by dong hua on 12-8-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Fish.h"
@interface Jelly : Fish {
    CGPoint dst;
}

+(id) makeJelly;
-(id) initJelly;
-(void) setUpDst:(int) dx dy:(int)dy;
@end
