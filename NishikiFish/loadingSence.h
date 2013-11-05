//
//  loadingSence.h
//  NishikiFish
//
//  Created by dong hua on 12-8-6.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCScene.h"
@interface loadingSence : CCScene {
    int targetSence;
    int fromSence;
}

+(id) loadSence:(NSString* )dir from:(int) f to:(int) t;
-(id) initWithSence:(NSString* )dir from:(int) f to:(int) t;
+(bool) getInternet;

@end
