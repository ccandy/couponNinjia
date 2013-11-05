//
//  viewQ.m
//  NishikiFish
//
//  Created by Hua Dong on 12-12-23.
//
//

#import "viewQ.h"
#import "loadingSence.h"
#import "labelHelper.h"
#import "DBHelper.h"
#import "QSDetail.h"
@interface viewQ(PrivateMethod)
-(void) addBackGround;
-(void) initLabels;
-(void) goPrev:(id) sender;
-(void) goNext:(id) sender;
-(void) ref:(id) sender;
-(void) goBack:(id) sender;
-(void) getQS;
-(void) itemSelect:(id) sender;

@end


@implementation viewQ

+(id) scene{
    CCScene* scene = [CCScene node];
    CCLayer* layer = [viewQ node];
    [scene addChild:layer];
    return  scene;
}

-(id) init{
    if((self = [super init])){
        prefs = [NSUserDefaults standardUserDefaults];
        qs = [[NSMutableArray alloc]init];
        upperBand = 0;
        [self addBackGround];
        [self initLabels];
        [self initButtons];
        [self downloadQS];
    }
    return self;

}

-(void) addBackGround{
    CCSprite* bg = [CCSprite spriteWithFile:@"gameback.jpg"];
    bg.scaleX = 480/bg.contentSize.width;
    bg.scaleY = 320/bg.contentSize.height;
    bg.anchorPoint = ccp(0,0);
    [self addChild:bg z:1];

}


-(void) initLabels{
    [self addChild:[labelHelper makeLabel:CGPointMake(50, 275) withStr:@"Info"] z:3];
    [self addChild:[labelHelper makeLabel:CGPointMake(175,275) withStr:@"Company Name"] z:3];
    [self addChild:[labelHelper makeLabel:CGPointMake(325,275) withStr:@"Avilable Until"] z:3];
    [self addChild:[labelHelper makeLabel:CGPointMake(425, 275) withStr:@"Price"] z:3];
}

-(void) initButtons{
    [CCMenuItemFont setFontName:@"Marker Felt"];
    [CCMenuItemFont setFontSize:25];
    CCMenuItem* mPrev = [CCMenuItemFont itemFromString:@"prev" target:self selector:@selector(goPrev:)];
    mPrev.position = ccp(0,0);
    CCMenuItem* mRef = [CCMenuItemFont itemFromString:@"Refresh" target:self selector:@selector(ref:)];
    mRef.position = ccp(150,0);
    CCMenuItem* mBack = [CCMenuItemFont itemFromString:@"Back" target:self selector:@selector(goBack:)];
    mBack.position = ccp(300,0);
    CCMenuItem* mNext = [CCMenuItemFont itemFromString:@"next" target:self selector:@selector(goNext:)];
    mNext.position = ccp(400,0);
    CCMenu* m = [CCMenu menuWithItems:mPrev,mRef,mBack,mNext, nil];
    m.position = ccp(50,50);
    [self addChild:m z:3];
}


-(void) goPrev:(id) sender{
    if(currentPage >=1){
        currentPage--;
        [qbs removeAllChildrenWithCleanup:YES];
        [self initQS:qs from:currentPage*6 tobound:((currentPage+1)*6)];
    }

}

-(void) goBack:(id)sender{
    [[CCDirector sharedDirector] replaceScene:[loadingSence loadSence:@"gameback.jpg" from:0 to:3]];
}

-(void) downloadQS{
    
    if([loadingSence getInternet]){
        if([[prefs objectForKey:@"UserQs"]count] == 0){
            UIAlertView* alter = [[UIAlertView alloc]initWithTitle:@"QS" message:@"you don't have any Counpon" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alter show];
        }else {
            NSArray* q = [prefs objectForKey:@"UserQs"];
            for(int n = 0; n < [q count]; n++){
                [qs addObject:[q objectAtIndex:n]];
            }
            if([q count] >6){
                upperBand = 6;
            }else {
                upperBand = [q count];
            }
            
            [self initQS:q from:0 tobound:upperBand];
        }
    }else{
        UIAlertView* alter = [[UIAlertView alloc]initWithTitle:@"QS" message:@"NO Internet, cannot update Counpon" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alter show];
    }
    
}


-(void) ref:(id)sender{
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

-(void) goNext:(id)sender{
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

-(void) itemSelect:(id) sender{
    CCMenuItem* i = sender;
    NSDictionary* temp = [qs objectAtIndex:i.tag];
    NSNumber* qid = [temp objectForKey:@"qid"];
    if(qid != nil){
        [prefs setObject:[temp objectForKey:@"qid"] forKey:@"chooseQ"];
        [prefs synchronize];
        [[CCDirector sharedDirector] replaceScene:[QSDetail sence]];
    }else{
        UIAlertView* alter = [[UIAlertView alloc]initWithTitle:@"QS" message:@"SomeThing is wrong" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alter show];
    }

}

-(void)dealloc{
    [qs release];
    [super dealloc];
}

@end
