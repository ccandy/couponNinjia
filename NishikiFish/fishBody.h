//
//  fishBody.h
//  NishikiFish
//
//  Created by dong hua on 12-8-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Fish.h"
@interface fishBody : CCSprite {
    int xSpeed,ySpeed;
    double accY,angleIncrment,angle;
    BOOL dead,right;
}
@property(readonly, assign) BOOL dead;

+(id) makeBody:(NSString*) f right:(BOOL) r;
-(id) initBody:(NSString*) f right:(BOOL) r;
-(void) bodyGo:(ccTime) dt;

@end
