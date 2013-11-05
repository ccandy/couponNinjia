//
//  RoseCache.m
//  NishikiFish
//
//  Created by Hua Dong on 13-05-05.
//
//

#import "RoseCache.h"
#import "Rose.h"
@implementation RoseCache

-(id) init{
    if(self = [super init]){
        nextRose = 0;
        //CCSpriteFrame* bulletFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"bullet.png"];
        batch = [CCSpriteBatchNode batchNodeWithFile:@"hua.png"];
		[self addChild:batch];
        for (int i = 0; i < 51; i++)
		{
			Rose* r = [Rose makeRose];
			r.visible = NO;
			[batch addChild:r z:3];
		}
    }
    return self;
}


-(void) updateRoses:(ccTime)ct{
    CCArray* rs = [batch children];
    CCNode* node = [rs objectAtIndex:nextRose];
    Rose* r = (Rose*) node;
    r.visible = YES;
    nextRose++;
    if(nextRose > 50){
        nextRose = 0;
    }
}

@end
