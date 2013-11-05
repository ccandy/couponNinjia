//
//  scoreSence.m
//  NishikiFish
//
//  Created by dong hua on 12-8-17.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "scoreSence.h"
#import "loadingSence.h"
#import "labelHelper.h"
#import "buttonHelper.h"
@interface scoreSence(PrivateMethod)
-(void) goShopping:(id)sender;
-(void) goGame:(id) sender;
-(void) addBackGround;
-(void) addLabels:(NSString*) str score:(int)s;
-(void) addSymbols;
-(void) addButtons;
@end

@implementation scoreSence

+(id) scene{
    CCScene* scene = [CCScene node];
    CCLayer* layer = [scoreSence node];
    [scene addChild:layer];
    return scene;
}

-(id) init{
    if((self = [super init])){
      
        [self addBackGround];
        [self addSymbols];
        [self addButtons];
    }
    return self;
}

-(void) addButtons{
    /*
    [CCMenuItemFont setFontName:@"Marker Felt"];
    [CCMenuItemFont setFontSize:20];
    
    CCMenuItem* m1 = [CCMenuItemImage itemFromNormalImage:@"back.png" selectedImage:@"back.png" target:self selector:@selector(goBack:)];
    m1.position = ccp(0,0);
    
    
    CCMenuItem* m2 = [CCMenuItemImage itemFromNormalImage:@"kc.png" selectedImage:@"kc.png"
                                                   target:self selector:@selector(goGame:)];
    m2.position = ccp(295,0);
    CCMenu* m = [CCMenu menuWithItems:m1,m2, nil];
    m.position = ccp(100,50);
    [self addChild:m z:3];*/
    
    buttonHelper* b1 = [buttonHelper makeButton:@"Go Back" pos:CGPointMake(100, 50) fontNum:25];
    b1.item = [CCMenuItemImage itemFromNormalImage:@"button1.png" selectedImage:@"button1.png" target:self selector:@selector(goBack:)];
    [b1 updateMPos];
    [self addChild:b1.label z:3];
    
    buttonHelper* b2 = [buttonHelper makeButton:@"Start Game" pos:CGPointMake(375, 50) fontNum:25];
    b2.item = [CCMenuItemImage itemFromNormalImage:@"button1.png" selectedImage:@"button1.png" target:self selector:@selector(goGame:)];
    [b2 updateMPos];
    [self addChild:b2.label z:3];

    
    CCMenu* m = [CCMenu menuWithItems:b1.item, b2.item,nil];
    m.anchorPoint = ccp(0,0);
    m.position = ccp(0,0);
    [self addChild:m z:2];
    
    
}

-(void) addSymbols{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSMutableArray* user = [prefs objectForKey:@"currentUser"];
    NSNumber* n = [user objectAtIndex:4];
    CCSprite* bg1;
    NSString* c;
    if([n intValue] > 100){
        bg1 = [CCSprite spriteWithFile:@"score.png"];
        c = @"WOW, GOOD JOB!!!!!";
    }else if([n intValue] > 0){
        bg1 = [CCSprite spriteWithFile:@"scorenor.png"];
        c = @"GOOD, and U CAN DO BETTER";
    }else{
        bg1 = [CCSprite spriteWithFile:@"srocecry.png"];
        c = @"IT'S OK, LETS CUT MORE FISH";
    }
    CGSize size = [[CCDirector sharedDirector] winSize];
    bg1.position = ccp(size.width/2,size.height/2);
    [self addChild:bg1 z:2];
    [self addLabels:c score:[n intValue]];
    
    
}

-(void) addLabels:(NSString*) str score:(int)s{
    CGSize size = [[CCDirector sharedDirector] winSize];
    CCLabelTTF* lbl = [CCLabelTTF labelWithString:str fontName:@"Marker Felt" fontSize:15];
    lbl.position = ccp(size.width/2+50,size.height/2+50);
    lbl.color = ccc3(128, 42, 42);
    [self addChild:lbl z:3];
    [self addChild:[labelHelper makeLabel:CGPointMake(size.width/2+50,size.height/2+15) withStr:[NSString stringWithFormat:@"you score is:%d",s]]z:3];
}

-(void) addBackGround{
    CCSprite* bg = [CCSprite spriteWithFile:@"itemback.jpg"];
    bg.scaleX = 480/bg.contentSize.width;
    bg.scaleY = 320/bg.contentSize.height;
    bg.anchorPoint = ccp(0,0);
    [self addChild:bg z:1];
    
}

-(void) goBack:(id)sender{
    [[CCDirector sharedDirector] replaceScene:[loadingSence loadSence:@"itemback.jpg" from:6 to:3]];
}

-(void) goGame:(id)sender{
    [[CCDirector sharedDirector] replaceScene:[loadingSence loadSence:@"itemback.jpg" from:6 to:4]];
}

-(void) dealloc{
    [super dealloc];
}

@end
