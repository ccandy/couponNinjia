//
//  DBHelper.h
//  NishikiFish
//
//  Created by dong hua on 12-8-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface DBHelper : CCNode {
    
}

+(NSData*) testDB;
+(NSData*) getUser:(NSString*) uid;
+(NSURLResponse* )createNew:(NSString*) uid pw:(NSString*) p em:(NSString*) e pn:(NSString*) pnum;
+(NSData*) getQs;
+(NSURLResponse*) buyQs:(NSString*) id forUser:(NSString*) uid;
+(NSURLResponse*) updateScore:(int) s forUser:(NSString*) uid;
+(NSURLResponse*) updateWeapon:(int) s forUser:(NSString*) uid;
+(NSData*) getQsfor:(NSString* )uid;
@end
