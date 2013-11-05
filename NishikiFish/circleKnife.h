//
//  circleKnife.h
//  NishikiFish
//
//  Created by dong hua on 12-8-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Knife.h"
@interface circleKnife : Knife {
    int angle;
    double rad;
}

+(id) makeCircle;
-(id) initCircle;
@end
