//
//  logSence.h
//  NishikiFish
//
//  Created by dong hua on 12-8-7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface logSence : CCLayer {
    UITextField* txtID;
	UITextField* txtPw;
    double currentTime;
    int totalTime;
    CCLabelTTF* lblInfo;
    NSUserDefaults *prefs;
    NSData* d;
}


+(id) scene;

@end
