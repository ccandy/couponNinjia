//
//  AniHelper.m
//  NishikiFish
//
//  Created by dong hua on 12-8-6.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "AniHelper.h"


@implementation AniHelper

+(CCAnimation*) makeAniWithFile:(NSString*) dir frames:(int) f{
    NSMutableArray* actionList = [NSMutableArray array];
    for(int n = 1; n <=8; n++){
        [actionList addObject:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"bear%i.png", n]]];
    }
    CCAnimation* ani = [CCAnimation animationWithFrames:actionList delay:0.1];
    return ani;
}
@end
