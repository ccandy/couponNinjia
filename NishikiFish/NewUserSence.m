//
//  NewUserSence.m
//  NishikiFish
//
//  Created by Hua Dong on 12-11-24.
//
//

#import "NewUserSence.h"
#import "loadingSence.h"
#import "labelHelper.h"
#import "textFieldMaker.h"
#import "DBHelper.h"
#import "buttonHelper.h"
@interface NewUserSence(PrivateMethod)
-(void) addBackGround;
-(void) addUI;
-(void) addLabels;
-(void) addTexts;
-(void) addButtons;
-(void) goMain:(id)sender;
-(void) goBack:(id) sender;
-(void) changeToMain;
-(void) cleanTxt;
-(void) regOnline;
-(void) regLocal;
-(BOOL) NSStringIsValidEmail:(NSString *)checkString;
@end

@implementation NewUserSence

+(id) scene{
    CCScene* scene = [CCScene node];
    CCLayer* layer = [NewUserSence node];
    [scene addChild:layer];
    return scene;
}


-(id) init{
    if((self = [super init])){
        if(![loadingSence getInternet]){
            UIAlertView* alter = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please check your internet connection" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alter show];
            [self addButtons];
            [self addBackGround];
        }else{
            [self addBackGround];
            [self addUI];
            [self scheduleUpdate];
        }
    }
    return self;
}

-(void) addBackGround{
    CCSprite* bg = [CCSprite spriteWithFile:@"reginback.jpg"];
    CGSize size = [[CCDirector sharedDirector]winSize];
    bg.scaleX = size.width/bg.textureRect.size.width;
    bg.scaleY = size.height/bg.textureRect.size.height;
    bg.anchorPoint = ccp(0,0);
    [self addChild:bg z:1];
    
    CCSprite* bg1 = [CCSprite spriteWithFile:@"regBack.png"];
    bg1.anchorPoint = ccp(0,0);
    bg1.position = ccp(15,60);
    [self addChild:bg1 z:2];
}

-(void) addUI{
    [self addLabels];
    [self addTexts];
    [self addButtons];
}

-(void) addLabels{
    [self addChild:[labelHelper makeLabel:CGPointMake(90, 250) withStr:@"User Name"] z:3];
    [self addChild:[labelHelper makeLabel:CGPointMake(90, 200) withStr:@"PassWord"] z:3];
    [self addChild:[labelHelper makeLabel:CGPointMake(85, 150) withStr:@"Re-enter"]z:3];
    [self addChild:[labelHelper makeLabel:CGPointMake(75, 100) withStr:@"Email"] z:3];
}

-(void) addTexts{
    txtID = [textFieldMaker getTextField:150 y:330 height:200 width:30 gate:self];
    [[[[CCDirector sharedDirector] openGLView] window] addSubview:txtID];

    txtPw = [textFieldMaker getTextField:100 y:330 height:200 width:30 gate:self];
    [[[[CCDirector sharedDirector] openGLView] window] addSubview:txtPw];
    txtPw.secureTextEntry = YES;
    
    txtrPw = [textFieldMaker getTextField:50 y:330 height:200 width:30 gate:self];
    [[[[CCDirector sharedDirector] openGLView] window] addSubview:txtrPw];
    txtrPw.secureTextEntry = YES;
    
    txtEmail = [textFieldMaker getTextField:0 y:330 height:200 width:30 gate:self];
    [[[[CCDirector sharedDirector] openGLView] window] addSubview:txtEmail];
    
}

-(void) update:(ccTime) dt{
    currentTime += dt;
    totalTime = currentTime;
    if(totalTime == 3){
        txtID.hidden = NO;
        txtPw.hidden = NO;
        txtrPw.hidden = NO;
        txtEmail.hidden = NO;
        txtPn.hidden = NO;
        [self unscheduleUpdate];
    }
}


-(void) addButtons{
    buttonHelper* b1 = [buttonHelper makeButton:@"Go Back"pos:CGPointMake(100,25) fontNum:25];
    b1.item = [CCMenuItemImage itemFromNormalImage:@"button1.png" selectedImage:@"button1.png" target:self selector:@selector(goBack:)];
    [b1 updateMPos];
    [self addChild:b1.label z:3];
    
    buttonHelper* b2 = [buttonHelper makeButton:@"Send Registration" pos:CGPointMake(375,25) fontNum:25];
    b2.item = [CCMenuItemImage itemFromNormalImage:@"button1.png" selectedImage:@"button1.png" target:self selector:@selector(goMain:)];
    [b2 updateMPos];
    [self addChild:b2.label z:3];
    
    m = [CCMenu menuWithItems:b1.item, b2.item,nil];
    m.anchorPoint = ccp(0,0);
    m.position = ccp(0,0);
    [self addChild:m z:2];
    
}

-(void) goMain:(id)sender{
    //BOOL vaild = YES;
    if(txtID.text.length == 0){
        UIAlertView* alter = [[UIAlertView alloc]initWithTitle:@"Error" message:@"User ID can not be Null" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alter show];
    }else if(txtPw.text.length == 0){
        UIAlertView* alter = [[UIAlertView alloc]initWithTitle:@"Error" message:@"PassWord can not be Null" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alter show];
    }else if(txtrPw.text.length == 0){
        UIAlertView* alter = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please re-enter Password" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alter show];
    }else if(![txtrPw.text isEqualToString:txtPw.text]){
        UIAlertView* alter = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Passwords must match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alter show];
    }else if(txtEmail.text.length == 0){
        UIAlertView* alter = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Email can not be Null" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alter show];
    }else if([DBHelper getUser:txtID.text]!= NULL){
        UIAlertView* alter = [[UIAlertView alloc]initWithTitle:@"Error" message:@"User already exist" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alter show];
        
    }else if(![self NSStringIsValidEmail:txtEmail.text]){
        UIAlertView* alter = [[UIAlertView alloc]initWithTitle:@"Error" message:@"You have to enter a vaild email address" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alter show];
    }else{
        [self changeToMain];
    }
}

-(void) regOnline{
    NSString* p = @"N/A";
    [DBHelper createNew:txtID.text pw:txtPw.text em:txtEmail.text pn:p];
}



-(void) cleanTxt{
    [txtID removeFromSuperview];
    [txtPw removeFromSuperview];
    [txtrPw removeFromSuperview];
    [txtEmail removeFromSuperview];
}

-(void) changeToMain{
    [self regOnline];
    [self regLocal];
    [self cleanTxt];
    [[CCDirector sharedDirector] replaceScene:[loadingSence loadSence:@"reginback.jpg" from:1 to:3]];
    
}

-(void) regLocal{
    NSMutableArray* user = [[NSMutableArray alloc] init];
    [user addObject:txtID.text];
    [user addObject:txtPw.text];
    [user addObject:@"N/A"];
    [user addObject:txtEmail.text];
    //score;
    [user addObject:[NSNumber numberWithInt:0]];
    //wtype
    [user addObject:[NSNumber numberWithInt:0]];
    //qs
    [user addObject:[[NSMutableArray alloc] init]];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setValue:user forKey:txtID.text];
    [prefs setValue:user forKey:@"currentUser"];
    [prefs setValue:[NSNumber numberWithInt:-1] forKey:@"currentItem"];
    [prefs synchronize];
    [user release];

}

-(BOOL) textFieldShouldReturn:(UITextField*) textField{
    [textField endEditing:YES];
    return YES;
}

-(void) goBack:(id) sender{
    [self cleanTxt];
    [[CCDirector sharedDirector] replaceScene:[loadingSence loadSence:@"reginback.jpg" from:0 to:0]];
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}


@end
