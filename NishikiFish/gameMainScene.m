//
//  gameMainScene.m
//  NishikiFish
//
//  Created by dong hua on 12-8-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "gameMainScene.h"
#import "bear.h"
#import "loadingSence.h"
#import "buttonHelper.h"
@interface gameMainScene(PrivateMethod)
-(void) goShop:(id) sender;
-(void) goQ:(id) sender;
-(void) goGame:(id) sender;
-(void) goBack:(id) sender;
-(void) initButton;
-(NSString*) transName:(int) n;
@end

@implementation gameMainScene


+(id) scene{
    CCScene* scene = [CCScene node];
    CCLayer* layer = [gameMainScene node];
    [scene addChild:layer];
    return scene;
}

-(id) init{
    if((self = [super init])){
        
        CCSprite* bg = [CCSprite spriteWithFile:@"itemback.jpg"];
        bg.scaleX = 480/bg.contentSize.width;
        bg.scaleY = 320/bg.contentSize.height;
        bg.anchorPoint = ccp(0,0);
        [self addChild:bg z:1];
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSMutableArray* u = [prefs valueForKey:@"currentUser"];
        CCLabelTTF* lblName = [CCLabelTTF labelWithString:@"User Name:" fontName:@"Arial" fontSize:25];
        lblName.color = ccc3(153, 0, 153);
        lblName.position = ccp(100,280);
        [self addChild:lblName z:3];
        
        CCLabelTTF* lblName1 = [CCLabelTTF labelWithString:[u objectAtIndex:0] fontName:@"Arial" fontSize:25];
        lblName1.color = ccc3(153, 0, 153);
        lblName1.position = ccp(220,280);
        [self addChild:lblName1 z:3];
        
        CCLabelTTF* lblScore = [CCLabelTTF labelWithString:@"Score:" fontName:@"Arial" fontSize:25];
        lblScore.color = ccc3(153, 0, 153);
        lblScore.position = ccp(75,240);
        [self addChild:lblScore z:3];

        NSNumber* n = [u objectAtIndex:4];
        CCLabelTTF* lblScore1 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",[n intValue]] fontName:@"Arial" fontSize:25];
        lblScore1.color = ccc3(153, 0, 153);
        lblScore1.position = ccp(205,240);
        [self addChild:lblScore1 z:3];
        
        CCLabelTTF* lblWeapon = [CCLabelTTF labelWithString:@"Weapon:" fontName:@"Arial" fontSize:25];
        lblWeapon.color = ccc3(153, 0, 153);;
        lblWeapon.position = ccp(90,200);
        [self addChild:lblWeapon z:3];

        CCLabelTTF* lblWeapon1 = [CCLabelTTF labelWithString:[self transName:[[u objectAtIndex:5]intValue]] fontName:@"Arial" fontSize:25];
        lblWeapon1.color = ccc3(153, 0, 153);
        lblWeapon1.position = ccp(215,200);
        [self addChild:lblWeapon1 z:3];
        
        bear* b =[bear makeBear];
        b.position = ccp(30,255);
        [b unscheduleUpdate];
        b.scaleX = 0.5;
        b.scaleY = 0.5;
        [self addChild:b z:3];
                                                                                                                                                                                                                                         
        CCSprite* fish1 = [CCSprite spriteWithFile:@"fish.png"];
        /*fish1.position = ccp(27, 240);
        fish1.scaleX = 35/fish1.contentSize.width;
        fish1.scaleY = 35/fish1.contentSize.height;*/
        [self addChild:fish1 z:3];
        
        CCSprite* fish2 = [CCSprite spriteWithFile:@"flyfish.png"];
        /*fish2.position = ccp(27, 200);
        fish2.scaleX = 35/fish1.contentSize.width;
        fish2.scaleY = 35/fish1.contentSize.height;*/
        [self addChild:fish2 z:3];
        [self initButton];
         
    }
    return self;
}


-(void) initButton{
    
    buttonHelper* b1 = [buttonHelper makeButton:@"Buy Item" pos:CGPointMake(60, 75) fontNum:25];
    b1.item = [CCMenuItemImage itemFromNormalImage:@"button1.png" selectedImage:@"button1.png" target:self selector:@selector(goShop:)];
    [b1 updateMPos];
    [self addChild:b1.label z:3];
    
    buttonHelper* b2 = [buttonHelper makeButton:@"Buy Coupon" pos:CGPointMake(190, 75) fontNum:25];
    b2.item = [CCMenuItemImage itemFromNormalImage:@"button1.png" selectedImage:@"button1.png" target:self selector:@selector(goQ:)];
    [b2 updateMPos];
    [self addChild:b2.label z:3];
    
    buttonHelper* b3 = [buttonHelper makeButton:@"Start Game" pos:CGPointMake(310, 75) fontNum:25];
    b3.item = [CCMenuItemImage itemFromNormalImage:@"button1.png" selectedImage:@"button1.png" target:self selector:@selector(goGame:)];
    [b3 updateMPos];
    [self addChild:b3.label z:3];
    
    buttonHelper* b4 = [buttonHelper makeButton:@"Log me out" pos:CGPointMake(430, 75) fontNum:25];
    b4.item = [CCMenuItemImage itemFromNormalImage:@"button1.png" selectedImage:@"button1.png" target:self selector:@selector(goBack:)];
    [b4 updateMPos];
    [self addChild:b4.label z:3];
    
    buttonHelper* b5 = [buttonHelper makeButton:@"View my Coupon" pos:CGPointMake(60, 150) fontNum:25];
    b5.item = [CCMenuItemImage itemFromNormalImage:@"button1.png" selectedImage:@"button1.png" target:self selector:@selector(viewCoupon:)];
    [b5 updateMPos];
    [self addChild:b5.label z:3];
    
    
    CCMenu* m = [CCMenu menuWithItems:b1.item,b2.item,b3.item,b4.item,b5.item,nil];
    m.anchorPoint = ccp(0,0);
    m.position = ccp(0,0);
    [self addChild:m z:2];

}

-(void) goShop:(id) sender{
    [[CCDirector sharedDirector] replaceScene:[loadingSence loadSence:@"itemback.jpg" from:0 to:5]];
}
-(void) goQ:(id) sender{
    [[CCDirector sharedDirector] replaceScene:[loadingSence loadSence:@"itemback.jpg" from:0 to:7]];
}
-(void) goGame:(id) sender{
    [[CCDirector sharedDirector] replaceScene:[loadingSence loadSence:@"itemback.jpg" from:0 to:4]];
}

-(void) viewCoupon:(id)sender{
     [[CCDirector sharedDirector] replaceScene:[loadingSence loadSence:@"itemback.jpg" from:0 to:8]];
}

-(void) goBack:(id) sender{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setValue:nil forKey:@"currentUser"];
    [prefs synchronize];
    [[CCDirector sharedDirector] replaceScene:[loadingSence loadSence:@"itemback.jpg" from:0 to:0]];
}

-(NSString*) transName:(int) n{
    NSString* t;
    switch (n) {
        case 0:
            t = @"Single Knife";
            break;
        case 1:
            t = @"Double Knife";
            break;
        case 2:
            t = @"Circle Knife";
            break;
        default:
            break;
    }
    return t;
}


-(void) dealloc{
    [super dealloc];
}

@end
