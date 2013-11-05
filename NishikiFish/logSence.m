//
//  logSence.m
//  NishikiFish
//
//  Created by dong hua on 12-8-7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "logSence.h"
#import "loadingSence.h"
#import "textFieldMaker.h"
#import "DBHelper.h"
#import "labelHelper.h"
#import "buttonHelper.h"
@interface logSence(PrivateMethod)
-(void) goBack:(id) sender;
-(void) regLocal:(NSDictionary*) dic;
-(void) changeToMain;
-(void) addBackGround;
-(void) addLabels;
-(void) addTexts;
-(void) addButtons;
@end

@implementation logSence

+(id) scene{
    CCScene* scene = [CCScene node];
    CCLayer* layer = [logSence node];
    [scene addChild:layer];
    return scene;
}

-(id) init{
    if((self = [super init])){
        currentTime = 0;
        totalTime = 0;
        if([loadingSence getInternet]){
            [self addBackGround];
            [self addLabels];
            [self addTexts];
            [self addButtons];

            [self scheduleUpdate];
        }else{
            UIAlertView* alter = [[UIAlertView alloc]initWithTitle:@"Something is wrong" message:@"You need internet to login" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alter show];
            [self addButtons];
            [self addBackGround];
        }
        
    }
    return self;
}

-(void) addLabels{
    [self addChild:[labelHelper makeLabel:CGPointMake(80, 220) withStr:@"User Name"] z:3];
    [self addChild:[labelHelper makeLabel:CGPointMake(80, 180) withStr:@"Pass Word"] z:3];
}

-(void) addTexts{
    txtID = [textFieldMaker getTextField:120 y:300 height:200 width:30 gate:self];
    [[[[CCDirector sharedDirector] openGLView] window] addSubview:txtID];
    
    txtPw = [textFieldMaker getTextField:80 y:300 height:200 width:30 gate:self];
    txtPw.secureTextEntry = YES;
    [[[[CCDirector sharedDirector] openGLView] window] addSubview:txtPw];
    
}

-(void) addButtons{
    /*
    CCMenuItem *back = [CCMenuItemImage itemFromNormalImage:@"back.png" selectedImage:@"back.png"
                                                     target:self selector:@selector(goBack:)];
    
    CCMenuItem* login = [CCMenuItemImage itemFromNormalImage:@"jtg.png" selectedImage:@"jtg.png"
                                                      target:self selector:@selector(goMain:)];
    login.position = ccp(150,0);
    
    CCMenu* m = [CCMenu menuWithItems:back, login,nil];
    m.position = ccp(240,40);
    [self addChild:m z:3];*/
    
    
    
    buttonHelper* back = [buttonHelper makeButton:@"  Back  " pos:CGPointMake(350, 75) fontNum:25];
    back.item = [CCMenuItemImage itemFromNormalImage:@"button1.png" selectedImage:@"button1.png"
                                              target:self selector:@selector(goBack:)];
    [back updateMPos];
    
    buttonHelper* login = [buttonHelper makeButton:@"Login me in" pos:CGPointMake(150, 75) fontNum:25];
    login.item = [CCMenuItemImage itemFromNormalImage:@"button1.png" selectedImage:@"button1.png"
                                               target:self selector:@selector(goMain:)];
    [login updateMPos];
    CCMenu* m = [CCMenu menuWithItems: nil];
    m.anchorPoint = ccp(0,0);
    m.position = ccp(0,0);
    [m addChild:login.item];
    [m addChild:back.item];
    
    [self addChild:m z:2];
    [self addChild:login.label z:2];
    [self addChild:back.label z:2];
    
    
    
    
    

}

-(void) addBackGround{
    CCSprite* bg = [CCSprite spriteWithFile:@"logback.jpg"];
    CGSize size = [[CCDirector sharedDirector] winSize];
    bg.scaleX = size.width/bg.textureRect.size.width;
    bg.scaleY = size.height/bg.textureRect.size.height;
    bg.anchorPoint = ccp(0,0);
    [self addChild:bg z:1];
    
    CCSprite* bg1 = [CCSprite spriteWithFile:@"loginBack.png"];
    bg1.position =ccp(240,200);
    [self addChild:bg1 z:2];
    
}

-(void) update:(ccTime) delta{
    
    currentTime += delta;
    totalTime = currentTime;
    if(totalTime == 3){
        txtID.hidden = NO;
        txtPw.hidden = NO;
        [self unscheduleUpdate];
    }
}

-(void) changeToMain{
    [txtID removeFromSuperview];
    [txtPw removeFromSuperview];
    [self unscheduleUpdate];
    [[CCDirector sharedDirector] replaceScene:[loadingSence loadSence:@"logback.jpg" from:2 to:3]];
}


-(void) goBack:(id) sender{
    [txtPw removeFromSuperview];
    [txtID removeFromSuperview];
    
    [[CCDirector sharedDirector] replaceScene:[loadingSence loadSence:@"logback.jpg" from:0 to:0]];
}

-(void) goMain:(id) sender{
    
    prefs = [NSUserDefaults standardUserDefaults];
    d = [DBHelper getUser:txtID.text];
    
    if(![loadingSence getInternet]){
        
        UIAlertView* alter = [[UIAlertView alloc]initWithTitle:@"Something is wrong" message:@"You need internet to login" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alter show];
    } else if(txtID.text.length == 0){
        UIAlertView* alter = [[UIAlertView alloc]initWithTitle:@"Something is wrong" message:@"User name cannot be null" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alter show];
    }else if( d == nil){
        
        UIAlertView* alter = [[UIAlertView alloc]initWithTitle:@"Something is wrong" message:@"User donesn't exist" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alter show];
    }else {
        if(d != nil){
            NSError* error;
            NSMutableArray* json = [NSJSONSerialization JSONObjectWithData:d options:kNilOptions error:&error];
            NSDictionary* dic = [json objectAtIndex:0];
            NSString* passw = [NSString stringWithString:[dic objectForKey:@"pw"]];
            if([passw isEqualToString:txtPw.text]){
                NSArray* ps = [prefs objectForKey:txtID.text];
                if(ps == nil){
                    [self regLocal:dic];
                }else {
                    int sLocal = [[ps objectAtIndex:4] intValue];
                    int sOnline = [[dic objectForKey:@"pscore"] intValue];
                    NSLog(@"score local:%d score online %d",sLocal,sOnline);
                    if(sLocal != sOnline){
                        [DBHelper updateScore:sLocal forUser:txtID.text];
                    }else {
                        NSMutableArray* user = [NSMutableArray arrayWithArray:ps];
                        [user replaceObjectAtIndex:4 withObject:[NSNumber numberWithInt:sOnline]];
                        [prefs setValue:user forKey:@"currentUser"];
                        [prefs setValue:user forKey:txtID.text];
                        [prefs synchronize];
                    }
                     
                }
                [self changeToMain];

            }else {
                UIAlertView* alter = [[UIAlertView alloc]initWithTitle:@"Something is wrong" message:@"Invaild password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alter show];
            }
        }
    }
}


-(void) regLocal:(NSDictionary *)dic{
    NSMutableArray* user = [[NSMutableArray alloc] init ];
   
    [user addObject:[dic objectForKey:@"pid"]];
    [user addObject:[dic objectForKey:@"pw"]];
     
    [user addObject:[dic objectForKey:@"Phone"]];
    [user addObject:[dic objectForKey:@"Email"]];
    [user addObject:[dic objectForKey:@"pscore"]];
    [user addObject:[dic objectForKey:@"wtype"]];
    
    NSData* q = [DBHelper getQsfor:[dic objectForKey:@"pid"]];
    NSMutableArray* qbs;
    if(q != nil){
        NSError* error;
        qbs = [NSJSONSerialization JSONObjectWithData:q options:kNilOptions error:&error];
    }else{
        qbs = [[NSMutableArray alloc] init];
    }
    
    qbs = [[NSMutableArray alloc] init];
    [user addObject:qbs];
    //NSData* data = [NSKeyedArchiver archivedDataWithRootObject:user];
    
    [prefs setValue:user forKey:[dic objectForKey:@"pid"]];
    [prefs setValue:user forKey:@"currentUser"];
    [prefs synchronize];
    user = nil;
    qbs = nil;
    
    
}

-(BOOL) textFieldShouldReturn:(UITextField*) textField{
    [textField endEditing:YES];
    return YES;
}


-(void) dealloc{
    [super dealloc];
}


@end
