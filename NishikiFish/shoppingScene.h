//
//  shoppingScene.h
//  NishikiFish
//
//  Created by dong hua on 12-8-8.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface shoppingScene : CCLayer {
    NSMutableArray* itemList;
    CCSprite* pic;
    int selection;
    NSUserDefaults *prefs;
    NSMutableArray* user;
    int wtype,s;
    UIAlertView* alter;
}

+(id) scene;

@end
