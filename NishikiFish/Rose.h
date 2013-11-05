//
//  Rose.h
//  NishikiFish
//
//  Created by dong hua on 12-8-7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Rose : CCSprite {
    CGPoint velocity,startPoint;
}

+(id) makeRose;
-(id) initRose;
-(void) reVel;
//-(void) updateRose:(ccTime) ct;
@end
