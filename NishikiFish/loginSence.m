//
//  loginSence.m
//  NishikiFish
//io
//  Created by dong hua on 12-8-4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "loginSence.h"
#import "loadingSence.h"
#import "AniHelper.h"
#import "bear.h"
#import "logSence.h"
#import "Knife.h"
#import "buttonHelper.h"
#import "RoseCache.h"
@interface  loginSence(PrivateMethod)
-(void) newUser:(id) sender;
-(void) login:(id) sender;
-(void) showCredit:(id) sender;
-(void) genFish;
-(void) initButton;
@end

@implementation loginSence



+(id) scene{
    CCScene* scene = [CCScene node];
    loginSence* layer = [loginSence node];
    [scene addChild:layer];
    return scene;
}

-(id) init{
    if((self = [super init])){
    
        CCSprite* backGround = [CCSprite spriteWithFile:@"main.jpg"];
        backGround.scaleX = 480/backGround.contentSize.width;
        backGround.scaleY = 320/backGround.contentSize.height;
        backGround.anchorPoint = ccp(0,0);
        [self addChild:backGround z:1 tag:0];
        rc = [[RoseCache alloc] init];
        [self addChild:rc z:3];
         [self initButton];
        /*
        CCMenuItem* new = [CCMenuItemImage itemFromNormalImage:@"newhere.png" selectedImage:@"newhere.png" target:self selector:@selector(newUser:)];
        
        CCMenuItem* old = [CCMenuItemImage itemFromNormalImage:@"lkc.png" selectedImage:@"lkc.png"
                           target:self selector:@selector(login:)];
        CCMenuItem* c = [CCMenuItemImage itemFromNormalImage:@"credit.png" selectedImage:@"credit.png"target:self selector:@selector(showCredit:)];
        
        CGSize size = [[CCDirector sharedDirector] winSize];
        CCMenu* m = [CCMenu menuWithItems: new,old, c,nil];
        m.position = ccp(size.width-100, size.height/2-45);
        [m alignItemsVertically];
        [self addChild:m z:3];
         */
        [self scheduleUpdate];
        
           }
    return self;
}

-(void) initButton{
    CCMenu* m = [CCMenu menuWithItems: nil];
    m.anchorPoint = ccp(0,0);
    m.position = ccp(0,0);
    
    buttonHelper* button1 = [buttonHelper makeButton:@"New player" pos:CGPointMake(400,200) fontNum:15];
    button1.item = [CCMenuItemImage itemFromNormalImage:@"button1.png" selectedImage:@"button1.png" target:self selector:@selector(newUser:)];
    [button1 updateMPos];
    [m addChild:button1.item];
    [self addChild:m z:3];
    [self addChild:button1.label z:3];
    
    buttonHelper* button2 = [buttonHelper makeButton:@"Login me in" pos:CGPointMake(400,130) fontNum:25];
    button2.item = [CCMenuItemImage itemFromNormalImage:@"button1.png" selectedImage:@"button1.png" target:self selector:@selector(login:)];
    [button2 updateMPos];
    [m addChild:button2.item];
    [self addChild:button2.label z:3];
    
    
    
}

-(void) newUser:(id)sender{
    [[CCDirector sharedDirector] replaceScene:[loadingSence loadSence:@"main.jpg" from:0 to:1]];
}

-(void) login:(id)sender{
    [[CCDirector sharedDirector] replaceScene:[loadingSence loadSence:@"main.jpg" from:0 to:2]];
}

-(void) showCredit:(id)sender{
    
}

-(void) genFish{
    fishs = [[[NSMutableArray alloc]init]autorelease];
    [fishs addObject:[CCSprite spriteWithFile:@"fly.png"]];
    [fishs addObject:[CCSprite spriteWithFile:@"jellyFish.png"]];
    [fishs addObject:[CCSprite spriteWithFile:@"salmon.png"]];
}

-(void) update:(ccTime) delta{
    /*
    if (b.velocity.x > 0) {
        fish.position = ccp([b getPos].x  + 80, [b getPos].y + 30);
        fish.flipX = NO;
    }else {
        fish.position = ccp([b getPos].x  - 80, [b getPos].y + 30);
        fish.flipX = YES;
    }*/
    
    [rc updateRoses:delta];
}

-(void) dealloc{
    [super dealloc];
}

@end
