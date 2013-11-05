//
//  labelHelper.h
//  NishikiFish
//
//  Created by dong hua on 12-8-7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface labelHelper : CCLabelTTF {
    
}

+(id) makeLabel:(CGPoint) pos withStr:(NSString*) str;

@end
