//
//  Knife.h
//  NishikiFish
//
//  Created by dong hua on 12-8-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Fish.h"
@interface Knife : CCSprite {
    CGPoint startPoint, endPoint;
}

@property (readwrite, nonatomic) CGPoint startPoint;
@property (readwrite, nonatomic) CGPoint endPoint;

+(id) makeKnife:(int) k;
-(id) initKnife;
-(BOOL) cutAvailable;
//-(BOOL) checkInsert:(CGPoint)pCenter: (CGRect) r:(CGPoint) pStart:(CGPoint) pEnd;
-(BOOL) checkInsert:(Fish*) k;
@end
