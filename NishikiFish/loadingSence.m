//
//  loadingSence.m
//  NishikiFish
//
//  Created by dong hua on 12-8-6.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "loadingSence.h"
#import "logSence.h"
#import "loginSence.h"
#import "gameMainScene.h"
#import "shoppingScene.h"
#import "DBHelper.h"
#import "GameSence.h"
#import "scoreSence.h"
#import "QSence.h"
#import "NewUserSence.h"
#import "viewQ.h"
@interface loadingSence(PrivateMethod)
-(void) regOnline;
-(void) updateScore;
-(void) updateWeapon;
-(void) updateQs;
@end

@implementation loadingSence


static bool internet;
+(id) loadSence:(NSString* )dir from:(int) f to:(int) t{
    return [[[self alloc] initWithSence:dir from:f to:t]autorelease];
}

-(id) initWithSence:(NSString* )dir from:(int) f to:(int) t{
    if((self = [super init])){
        CCSprite* bg = [CCSprite spriteWithFile:dir];
        bg.scaleX = 480/bg.contentSize.width;
        bg.scaleY = 320/bg.contentSize.height;
        bg.anchorPoint = ccp(0,0);
        [self addChild:bg z:1];
        CCLabelTTF* label = [CCLabelTTF labelWithString:@"Loading....." fontName:@"Marker Felt" fontSize:25];
        CGSize size = [[CCDirector sharedDirector]winSize];
        label.position = ccp(size.width - 50, 50);
        [self addChild:label z:2];
        targetSence = t;
        fromSence = f;
        [self scheduleUpdate];
    }
    return self;
}


-(void) update:(ccTime*) delta{
    [self unscheduleAllSelectors];
    CCTransitionFlipX* transition;
    
    switch (targetSence) {
        case 0:
            transition = [CCTransitionFade transitionWithDuration:3 scene:[loginSence scene] withColor:ccWHITE];
            if([DBHelper testDB] != NULL){
                internet = YES;
            }else {
                internet = NO;
            }
            break;
        case 1:
            
            if([DBHelper testDB] != NULL){
                internet = YES;
            }else {
                internet = NO;
            }
            
            transition = [CCTransitionFade transitionWithDuration:3 scene:[NewUserSence scene] withColor:ccWHITE];
            break;
        case 2:
            
            if([DBHelper testDB] != NULL){
                internet = YES;
            }else {
                internet = NO;
            }
            transition = [CCTransitionFade transitionWithDuration:3 scene:[logSence scene]withColor:ccWHITE];
            break;
        case 3:
            if(fromSence == 1 && internet){
                 
                [self regOnline];
            }
            
            if(fromSence == 5 && internet){
                
                [self updateWeapon];
                [self updateScore];
            }

            transition = [CCTransitionFade transitionWithDuration:3 scene:[gameMainScene scene]withColor:ccWHITE];
            break;
        case 4:
            transition = [CCTransitionFade transitionWithDuration:3 scene:[GameSence scene]withColor:ccWHITE];
            break;
        case 5:
            transition = [CCTransitionFade transitionWithDuration:3 scene:[shoppingScene scene]withColor:ccWHITE];
            break;
        case 6:
                
            if(internet){
                [self updateScore];
            }
            transition = [CCTransitionFade transitionWithDuration:3 scene:[scoreSence scene]withColor:ccWHITE];
            break;
        case 7:
            if(internet){
                [self updateQs];
            }
            transition = [CCTransitionFade transitionWithDuration:3 scene:[QSence scene]withColor:ccWHITE];
            break;
        case 8:
            if(internet){
                [self getQsForUser];
            }
            transition = [CCTransitionFade transitionWithDuration:3 scene:[viewQ scene]withColor:ccWHITE];
        default:
            break;
    }
    
    [[CCDirector sharedDirector] replaceScene:transition];
}

+(bool) getInternet{
    return internet;
}

-(void) updateScore{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSMutableArray* user = [prefs objectForKey:@"currentUser"];
    [DBHelper updateScore:[[user objectAtIndex:4]intValue] forUser:[user objectAtIndex:0]];
}

-(void) regOnline{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSMutableArray* user = [prefs objectForKey:@"currentUser"];
    [DBHelper createNew:[user objectAtIndex:0] pw:[user objectAtIndex:1] em:[user objectAtIndex:3] pn:[user objectAtIndex:2]];
}

-(void) updateWeapon{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSMutableArray* user = [prefs objectForKey:@"currentUser"];
    [DBHelper updateWeapon:[[user objectAtIndex:5]intValue] forUser:[user objectAtIndex:0]];
}

-(void) updateQs{
    NSData* qs = [DBHelper getQs];
    NSError* error;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if(qs != nil){
        NSMutableArray* json = [NSJSONSerialization JSONObjectWithData:qs options:kNilOptions error:&error];
        [prefs setObject:json forKey:@"currentQs"];
        [prefs synchronize];
    }else {
        NSMutableArray* json = [[NSMutableArray alloc]init];
        [prefs setObject:json forKey:@"currentQs"];
        [prefs synchronize];
    }
}

-(void) getQsForUser{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSMutableArray* user = [prefs objectForKey:@"currentUser"];
    if(user != nil){
        NSData* d = [DBHelper getQsfor:[user objectAtIndex:0]];
        if(d != nil){
            NSError* error;
            NSMutableArray* json = [NSJSONSerialization JSONObjectWithData:d options:kNilOptions error:&error];
            [prefs setObject:json forKey:@"UserQs"];
            [prefs synchronize];
        }
    }
}

@end
