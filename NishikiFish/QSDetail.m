//
//  QSDetail.m
//  NishikiFish
//
//  Created by Hua Dong on 12-12-23.
//
//

#import "QSDetail.h"
#import "viewQ.h"
#import "labelHelper.h"
@interface QSDetail(PrivateMethod)
-(void) initButton;
-(void) initLabels;
-(void) addBack;
-(void) goBack:(id) sender;
@end

@implementation QSDetail
+(id) sence{
    CCScene* scene = [CCScene node];
    CCLayer* layer = [QSDetail node];
    [scene addChild:layer];
    return  scene;
}

-(id) init{
    if((self = [super init])){
        [self initButton];
        [self addBack];
        NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
        NSNumber* qid = [prefs objectForKey:@"chooseQ"];
        if(qid != nil){
            int q = [qid intValue];
            CGSize s = [[CCDirector sharedDirector] winSize];
            CCLabelTTF* t = [labelHelper makeLabel:CGPointMake(s.width/2-50, s.height/2) withStr:@"Coupon id: "];
            [self addChild:t z:3];
            lblQ = [labelHelper makeLabel:CGPointMake(s.width/2+100, s.height/2) withStr:[NSString stringWithFormat:@"%d",q]];
            [self addChild:lblQ z:3];
        }
    }
    return self;
}


-(void) initButton{
    CCMenuItemFont* back = [CCMenuItemFont itemFromString:@"Back" target:self selector:@selector(goBack:)];
    back.position = ccp(400,50);
    CCMenu* m = [CCMenu menuWithItems:back, nil];
    m.position = ccp(0,0);
    [self addChild:m z:3];
}

-(void) goBack:(id)sender{
    [[CCDirector sharedDirector] replaceScene:[viewQ scene]];
}

-(void) addBack{
    CCSprite* bg = [CCSprite spriteWithFile:@"gameback.jpg"];
    bg.scaleX = 480/bg.contentSize.width;
    bg.scaleY = 320/bg.contentSize.height;
    bg.anchorPoint = ccp(0,0);
    [self addChild:bg z:1];
}

@end
