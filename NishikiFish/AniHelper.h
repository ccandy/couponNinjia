//
//  AniHelper.h
//  NishikiFish
//
//  Created by dong hua on 12-8-6.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface AniHelper : CCNode {
    
}

+(CCAnimation*) makeAniWithFile:(NSString*) dir frames:(int) f;

@end
