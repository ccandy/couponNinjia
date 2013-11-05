//
//  QSence.m
//  NishikiFish
//
//  Created by dong hua on 12-8-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "QSence.h"
#import "loadingSence.h"
#import "DBHelper.h"
#import "labelHelper.h"
@interface QSence(PrivateMethod)

-(void) downloadQS;
-(void) goBack:(id) sender;
-(void) goPrev:(id) sender;
-(void) goNext:(id) sender;
-(void) buyItem:(id) sender;
-(void) ref:(id) sender;
-(void) itemSelect:(id) sender;
-(void) addBack;
-(void) initLabels;
-(void) initQS:(NSArray *)dic from:(int) p tobound:(int)b;
-(CCMenuItem*) itemHelper:(int) t pos:(CGPoint) point withStr:(NSString*) str;
@end

@implementation QSence

+(id) scene{
    CCScene* scene = [CCScene node];
    CCLayer* layer = [QSence node];
    [scene addChild:layer];
    return  scene;
}

-(id) init{
    if((self = [super init])){
        prefs = [NSUserDefaults standardUserDefaults];
        qs = [[NSMutableArray alloc] init];
        qsb = [[NSMutableArray alloc]init];
        [self addBack];
        upperBand = 0;
        [self initButtons];
        [self initLabels];
        selection = -1;
        y = 300;
        total = 0;
        [self downloadQS];
    }
    return self;
}

-(void) addBack{
    CCSprite* bg = [CCSprite spriteWithFile:@"gameback.jpg"];
    bg.scaleX = 480/bg.contentSize.width;
    bg.scaleY = 320/bg.contentSize.height;
    bg.anchorPoint = ccp(0,0);
    [self addChild:bg z:1];

}


-(void) downloadQS{
    
    if([loadingSence getInternet]){
       if([[prefs objectForKey:@"currentQs"]count] == 0){
           UIAlertView* alter = [[UIAlertView alloc]initWithTitle:@"QS" message:@"NO Counpon avaliable now" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
           [alter show];
       }else {
           NSArray* q = [prefs objectForKey:@"currentQs"];
           for(int n = 0; n < [q count]; n++){
               [qs addObject:[q objectAtIndex:n]];
           }
           pageNum = [q count]/6;
           if([q count] >6){
               upperBand = 6;
           }else {
               upperBand = [q count];
           }
           [self initQS:q from:0 tobound:upperBand];
      }
    }else{
        UIAlertView* alter = [[UIAlertView alloc]initWithTitle:@"QS" message:@"NO Internet, cannot update Q" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alter show];
    }
    
}

-(void) initQS:(NSArray *)dic from:(int) p tobound:(int)b{
    qbs = [CCMenu menuWithItems: nil];
    int startX1 = 50;
    int startX2 = 175;
    int startX3 = 325;
    int startX4 = 425;
    int startY = 250;
    for(int n = p; n < b;n++){
        NSDictionary* d = [dic objectAtIndex:n];
        CCMenuItem* i = [self itemHelper:n pos:CGPointMake(startX1, startY) withStr:[d objectForKey:@"info"]];
        CCMenuItem* i1 = [self itemHelper:n pos:CGPointMake(startX2, startY) withStr:[d objectForKey:@"com"]];
        CCMenuItem* i2 = [self itemHelper:n pos:CGPointMake(startX3, startY) withStr:[d objectForKey:@"QDate"]];
        CCMenuItem* i3 = [self itemHelper:n pos:CGPointMake(startX4, startY) withStr:[d objectForKey:@"Price"]];
        startY -= 30;
        [qbs addChild:i];
        [qbs addChild:i1];
        [qbs addChild:i2];
        [qbs addChild:i3];
    }
    qbs.position = ccp(0,0);
    [self addChild:qbs z:3];
}

-(CCMenuItemFont*) itemHelper:(int) t pos:(CGPoint) point withStr:(NSString *)str{
    CCMenuItemFont* i = [CCMenuItemFont itemFromString:str target:self selector:@selector(itemSelect:)];
    i.fontSize = 15;
    i.tag = t;
    i.position = point;
    return i;
}


-(void) initButtons{
    [CCMenuItemFont setFontName:@"Marker Felt"];
    [CCMenuItemFont setFontSize:25];
    CCMenuItem* mPrev = [CCMenuItemFont itemFromString:@"prev" target:self selector:@selector(goPrev:)];
    mPrev.position = ccp(0,0);
    CCMenuItem* mBuy = [CCMenuItemFont itemFromString:@"Buy" target:self selector:@selector(buyItem:)];
    mBuy.position = ccp(200,0);
    CCMenuItem* mRef = [CCMenuItemFont itemFromString:@"Refresh" target:self selector:@selector(ref:)];
    mRef.position = ccp(300,0);
    CCMenuItem* mBack = [CCMenuItemFont itemFromString:@"Back" target:self selector:@selector(goBack:)];
    mBack.position = ccp(400,0);
    CCMenuItem* mNext = [CCMenuItemFont itemFromString:@"next" target:self selector:@selector(goNext:)];
    mNext.position = ccp(100,0);
    CCMenu* m = [CCMenu menuWithItems:mPrev,mBuy,mRef,mBack,mNext, nil];
    m.position = ccp(50,50);
    [self addChild:m z:3];
}

-(void) initLabels{
    [self addChild:[labelHelper makeLabel:CGPointMake(50, 275) withStr:@"Info"] z:3];
    [self addChild:[labelHelper makeLabel:CGPointMake(175,275) withStr:@"Company Name"] z:3];
    [self addChild:[labelHelper makeLabel:CGPointMake(325,275) withStr:@"Avilable Until"] z:3];
    [self addChild:[labelHelper makeLabel:CGPointMake(425, 275) withStr:@"Price"] z:3];
    CCLabelAtlas* temp = [labelHelper makeLabel:CGPointMake(400, 75) withStr:@"total"];
    temp.color = ccWHITE;
    [self addChild:temp  z:3];
    lblTotal = [labelHelper makeLabel:CGPointMake(450, 75) withStr:[NSString stringWithFormat:@"%d",total]];
    lblTotal.color = ccWHITE;
    [self addChild:lblTotal z:3];
    
    
    CCLabelAtlas* temp1 = [labelHelper makeLabel:CGPointMake(100, 75) withStr:@"Available Score:"];
    temp1.color = ccBLUE;
    [self addChild:temp1  z:3];
    NSMutableArray* user = [NSMutableArray arrayWithArray:[prefs objectForKey:@"currentUser"]];
    int n = [[user objectAtIndex:4]intValue];
    lblAScore = [labelHelper makeLabel:CGPointMake(200, 75) withStr:[NSString stringWithFormat:@"%d",n]];
    lblAScore.color = ccBLUE;
    [self addChild:lblAScore z:3];
    
    
    
    
    
}

-(void) goBack:(id) sender{
    [[CCDirector sharedDirector] replaceScene:[loadingSence loadSence:@"gameback.jpg" from:0 to:3]];

}
-(void) goPrev:(id) sender{
    if(currentPage >=1){
        currentPage--;
        [qbs removeAllChildrenWithCleanup:YES];
        [self initQS:qs from:currentPage*6 tobound:((currentPage+1)*6)];
    }
}
-(void) goNext:(id) sender{
    int bigger = [qs count] - (currentPage+1)*6;
    if( bigger> 0){
        [qbs removeAllChildrenWithCleanup:YES];
        currentPage++;
        int q = [qs count] - (currentPage+1)*6;
        if(q > 0){
            [self initQS:qs from:currentPage*6 tobound:((currentPage+1)*6)];
        }else{
            [self initQS:qs from:currentPage*6 tobound:[qs count]];
        }
    }
    
}
-(void) buyItem:(id) sender{
    NSMutableArray* user = [NSMutableArray arrayWithArray:[prefs objectForKey:@"currentUser"]];
    if(selection == -1){
        UIAlertView* alter = [[UIAlertView alloc]initWithTitle:@"QS" message:@"You have to select one coungh frist" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alter show];
    }else {
        NSDictionary* d = [qs objectAtIndex:selection];
        int s = [[user objectAtIndex:4]intValue];
        if(s-[[d objectForKey:@"Score"]intValue] < 0){
            UIAlertView* alter = [[UIAlertView alloc]initWithTitle:@"QS" message:@"You don't have enought credits to get this coungh" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alter show];

        }else{
            s-=[[d objectForKey:@"Score"]intValue];
            [user replaceObjectAtIndex:4 withObject:[NSNumber numberWithInt:s]];
            [DBHelper buyQs:[d objectForKey:@"qid"] forUser:[user objectAtIndex:0]];
            [prefs setObject:user forKey:@"currentUser"];
            [prefs synchronize];
            [lblAScore setString:[NSString stringWithFormat:@"%d",s]];
        }
    }
    [self ref:nil];
}
-(void) ref:(id) sender{
    [qbs removeAllChildrenWithCleanup:YES];
    [qs removeAllObjects];
    NSData* qdata = [DBHelper getQs];
    NSError* error;
    if(qdata != nil){
        NSMutableArray* json = [NSJSONSerialization JSONObjectWithData:qdata options:kNilOptions error:&error];
        [prefs setObject:json forKey:@"currentQs"];
    }else {
        NSMutableArray* json = [[NSMutableArray alloc]init];
        [prefs setObject:json forKey:@"currentQs"];
        [prefs synchronize];
    }

    [self downloadQS];
}

-(void) itemSelect:(id) sender{
    selection = [sender tag];
    CCMenuItemFont* i = sender;
    CCArray* temp = [qbs children];
    NSDictionary* d = [qs objectAtIndex:selection];
    if(i.color.b == ccWHITE.b && i.color.g == ccWHITE.g && i.color.r == ccWHITE.r){
        i.color = ccBLUE;
        for ( int n = 0; n <[temp count]; n++){
            CCMenuItemFont* f = [temp objectAtIndex:n];
            if(f.tag == selection){
                f.color = ccBLUE;
            }else{
                f.color = ccWHITE;
            }
        }
        total = [[d objectForKey:@"Price"]intValue];
    }
    [lblTotal setString:[NSString stringWithFormat:@"%d",total]];
    
    
}

-(void) dealloc{
    [qs release];
    [super dealloc];
}

@end
