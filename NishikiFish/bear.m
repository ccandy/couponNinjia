//
//  bear.m
//  NishikiFish
//
//  Created by dong hua on 12-8-7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "bear.h"
#import "AniHelper.h"


@implementation bear
@synthesize velocity;

+(id) makeBear{
    return [[self alloc] initBear];
}

-(id) initBear{
    if((self = [super init])){
        velocity = ccp(100,0);
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"AnimBear.plist"];        
        CCSpriteBatchNode *batch = [CCSpriteBatchNode batchNodeWithFile:@"AnimBear.png"];
        [self addChild:batch];
        CCAnimation* anim = [AniHelper makeAniWithFile:@"bear" frames:8];
        CCRepeatForever* repeat = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:anim restoreOriginalFrame:NO]];
        myBear = [CCSprite spriteWithSpriteFrameName:@"bear1.png"];
        myBear.scaleX = 75/myBear.textureRect.size.width;
        myBear.scaleY = 75/myBear.textureRect.size.height;
        f = YES;
        myBear.flipX = f;
        myBear.position = ccp(-10 , 50);
        [myBear runAction:repeat];
        [batch addChild:myBear];
        [self scheduleUpdate];
    }
    return self;
}


-(void) update:(ccTime) delta{
    self.position = ccpAdd(self.position, ccpMult(velocity, delta));
    if(self.position.x > 550 || self.position.x < -70){
        f = !f;
        myBear.flipX = f;
        velocity = ccpMult(velocity, -1);
        self.position = ccp(self.position.x, arc4random() % 110 + 30);
    }
}

-(CGPoint) getPos{
    return self.position;
}

-(void) dealloc{
    [super dealloc];
}

@end
