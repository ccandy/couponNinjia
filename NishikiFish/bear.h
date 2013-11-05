//
//  bear.h
//  NishikiFish
//
//  Created by dong hua on 12-8-7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface bear : CCNode {
    CCSprite* myBear;
    CGPoint velocity;
    bool f;

}

@property(readonly, nonatomic) CGPoint velocity;

+(id) makeBear;
-(id) initBear;
-(CGPoint) getPos;

@end
