//
//  loginSence.h
//  NishikiFish
//
//  Created by dong hua on 12-8-4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "bear.h"
#import "RoseCache.h"
@interface loginSence : CCLayer {
    NSMutableArray* fishs;
    CCSprite* fish;
    bear* b;
    RoseCache* rc;
}

+(id) scene;


@end
