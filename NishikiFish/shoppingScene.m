//
//  shoppingScene.m
//  NishikiFish
//
//  Created by dong hua on 12-8-8.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "shoppingScene.h"
#import "loadingSence.h"
#import "gameMainScene.h"
#import "buttonHelper.h"
@interface shoppingScene(PrivateMethod) 
-(void) renewItemList;
-(void) itemCilcked:(CCMenuItemImage*)sender;
-(void) buyItem:(id) sender;
-(void) goBack:(id) sender;
-(void) initButton;
@end


@implementation shoppingScene


+(id) scene{
    CCScene* scene = [CCScene node];
    CCLayer* layer = [shoppingScene node];
    [scene addChild:layer];
    return scene;
}

-(id) init{
    if((self = [super init])){
        CCSprite* bg = [CCSprite spriteWithFile:@"itemback.jpg"];
        CGSize size = [[CCDirector sharedDirector] winSize ];
        bg.scaleX = size.width/bg.textureRect.size.width;
        bg.scaleY = size.height/bg.textureRect.size.height;
        bg.anchorPoint = ccp(0,0);
        [self addChild:bg z:1];
        
        prefs = [NSUserDefaults standardUserDefaults];
        NSArray* array = [prefs objectForKey:@"currentUser"];
        user = [[NSMutableArray alloc] init];
        for(int n = 0; n < [array count]; n++){
            [user addObject:[array objectAtIndex:n]];
        }
         
        wtype = [[user objectAtIndex:5]intValue];
        s = [[user objectAtIndex:4] intValue];
        itemList = [[NSMutableArray alloc] init];
        [self renewItemList];
        
        CCMenu* m = [CCMenu menuWithItems: nil];
        int xoff = 0;
        for(int n = 0; n < itemList.count; n++){
            CCMenuItemImage* i = [CCMenuItemImage itemFromNormalImage:[itemList objectAtIndex:n] selectedImage:[itemList objectAtIndex:n] target:self selector:@selector(itemCilcked:)];
            i.scaleX = 50/i.contentSize.width;
            i.scaleY = 50/i.contentSize.height;
            i.position = ccp(xoff,0);
            [m addChild:i z:1 tag:n];
            xoff = xoff + 100;
        }
        m.position = ccp(50,250);
        [self addChild:m z:3];
        [self initButton];
    }
    return self;
}

-(void) initButton{
    /*
    CCMenu* m1 = [CCMenu menuWithItems: nil];
    CCMenuItem* m11 = [CCMenuItemImage itemFromNormalImage:@"buy.png" selectedImage:@"buy.png"
                                                    target:self selector:@selector(buyItem:)];
    m11.position = ccp(0,0);
    [m1 addChild:m11];
    
    
    CCMenuItem* m12 = [CCMenuItemImage itemFromNormalImage:@"gb.png" selectedImage:@"gb.png"
                                                    target:self selector:@selector(goBack:)];
    m12.position = ccp(280,0);
    [m1 addChild:m12];
    m1.position = ccp(100,50);
    [self addChild:m1 z:3];
     */
    buttonHelper* b1 = [buttonHelper makeButton:@"Buy it" pos:CGPointMake(100, 50) fontNum:25];
    b1.item = [CCMenuItemImage itemFromNormalImage:@"button1.png" selectedImage:@"button1.png"
                                            target:self selector:@selector(buyItem:)];
    [b1 updateMPos];
    [self addChild:b1.label z:3];
    
    buttonHelper* b2 = [buttonHelper makeButton:@"Go Back" pos:CGPointMake(375, 50) fontNum:25];
    b2.item = [CCMenuItemImage itemFromNormalImage:@"button1.png" selectedImage:@"button1.png" target:self selector:@selector(goBack:)];
    [b2 updateMPos];
    [self addChild:b2.label z:3];
    
    
    CCMenu* m1 = [CCMenu menuWithItems: nil];
    m1.anchorPoint = ccp(0,0);
    m1.position = ccp(0,0);
    [m1 addChild:b1.item];
    [m1 addChild:b2.item];
    [self addChild:m1 z:2];
    
    
    
}


-(void) renewItemList{
    [itemList addObject:[NSString stringWithString:@"30m.png"]];
    [itemList addObject:[NSString stringWithString:@"20m.png"]];
    [itemList addObject:[NSString stringWithString:@"10m.png"]];
    [itemList addObject:[NSString stringWithString:@"doubleknife.png"]];
    [itemList addObject:[NSString stringWithString:@"circleKnife.png"]];
}

-(void) dealloc{
    [user release];
    [itemList release];
    [super dealloc];
}

-(void) itemCilcked:(CCMenuItemImage*)sender{
    selection = [sender tag];
    [self removeChild:pic cleanup:YES];
    pic = [CCSprite spriteWithFile:[itemList objectAtIndex:[sender tag]]];
    pic.scaleX = 200/pic.contentSize.width;
    pic.scaleY = 200/pic.contentSize.height;
    pic.position = ccp(240,140);
    [self addChild:pic z:2];
    
}

-(void) buyItem:(id) sender{
    //int s = [[user objectAtIndex:4]intValue];
    //int s = 10000;
    if(selection > 2){
        if(wtype == 1 && selection == 3){
            alter = [[UIAlertView alloc]initWithTitle:@"WEAPON" message:@"U already have doubleSword" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alter show];
        }else if(wtype == 2 && selection == 4){
            alter = [[UIAlertView alloc]initWithTitle:@"WEAPON" message:@"U already have circleSword" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alter show];
        }else if(wtype != selection){
            if(selection == 3){
                if((s - 300) >= 0){
                    alter = [[UIAlertView alloc]initWithTitle:@"WEAPON" message:@"Switch to doubleSword" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alter show];
                    wtype = 1;
                    //[user replaceObjectAtIndex:6 withObject:[NSNumber numberWithInt:selection]];
                    s-=300;
                }else {
                    alter = [[UIAlertView alloc]initWithTitle:@"WEAPON" message:@"you don't have enough score" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alter show];
                }
            }
            if(selection == 4){
                if((s - 300) >= 0){
                    alter = [[UIAlertView alloc]initWithTitle:@"WEAPON" message:@"Switch to circleSword" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alter show];
                    //[user replaceObjectAtIndex:6 withObject:[NSNumber numberWithInt:selection]];
                    wtype = 2;
                    s-=300;
                }else {
                    
                    alter = [[UIAlertView alloc]initWithTitle:@"WEAPON" message:@"you don't have enough score" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                    [alter show];
                }
            }
        }
    }else {
        if([[prefs objectForKey:@"currentItem"] intValue] != -1){
            alter = [[UIAlertView alloc]initWithTitle:@"WEAPON" message:@"You Can Only Buy One Item" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alter show];

        }else {
            if((s-selection*100) >=0){
                [prefs setValue:[NSNumber numberWithInt:(selection+1)] forKey:@"currentItem"];
                s-=([sender tag]*100);
                NSString* is = [NSString stringWithFormat:@"you buy addition %d second game time",(selection+1)*10];
                alter = [[UIAlertView alloc]initWithTitle:@"ITEM" message:is delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alter show];
            }else {
                alter = [[UIAlertView alloc]initWithTitle:@"ITEM" message:@"you don't have enough score" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alter show];
            }
        }
    }
    //[user replaceObjectAtIndex:4 withObject:[NSNumber numberWithInt:s]];
}

-(void) goBack:(id) sender{
    
    [user replaceObjectAtIndex:5 withObject:[NSNumber numberWithInt:wtype]];
    [user replaceObjectAtIndex:4 withObject:[NSNumber numberWithInt:s]];
    [prefs setValue:user forKey:[user objectAtIndex:0]];
    [prefs synchronize];
    [prefs setValue:user forKey:@"currentUser"];
    [prefs synchronize];
    
    [[CCDirector sharedDirector] replaceScene:[loadingSence loadSence:@"itemback.jpg" from:5 to:3]];
    //[[CCDirector sharedDirector] replaceScene:[gameMainScene scene]];
}

@end
