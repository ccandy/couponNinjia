//
//  GameSence.m
//  NishikiFish
//
//  Created by dong hua on 12-8-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GameSence.h"
#import "Fish.h"
#import "loadingSence.h"
#import "fishBody.h"
#import "Jelly.h"
#define salmonPre 0.75
#define flyPre 0.45
#define numJelly 3;
@interface GameSence(PrivateMethod)
-(void) genFish:(int) f;
-(void) stopGame;  
-(void) genBodyFor:(Fish*) f;
-(void) genJf;
@end

@implementation GameSence
@synthesize dN;

+(id) scene{
    CCScene* scene = [CCScene node];
    CCLayer* layer = [GameSence node];
    [scene addChild:layer];
    return scene;
}

-(id) init{
    if((self = [super init])){
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:@"Score:" fontName:@"Marker Felt"  fontSize:25];
        lbl.position = ccp(400,300);
        [self addChild:lbl z:3];
        scoreLabel = [CCLabelTTF labelWithString:@"0" fontName:@"Marker Felt"  fontSize:25];
        scoreLabel.position = ccp(450,300);
        [self addChild:scoreLabel z:3];
         
        
        CCSprite* bg = [CCSprite spriteWithFile:@"gameback.jpg"];
        bg.anchorPoint = ccp(0,0);
        CGSize size = [[CCDirector sharedDirector] winSize];
        bg.scaleX = size.width/bg.contentSize.width;
        bg.scaleY = size.height/bg.contentSize.height;
        [self addChild:bg z:1];
        fishList = [[NSMutableArray alloc] init];
        body = [[NSMutableArray alloc] init];
        jf = [[NSMutableArray alloc] init];
        [self genFish:((arc4random() % 8) + 1)];
        
        points = [[NSMutableArray alloc] init];
        dN = [[drawNode alloc] init];
        [self addChild:dN z:3];
        
        self.isTouchEnabled = YES;
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSMutableArray* user = [NSMutableArray arrayWithArray:[prefs objectForKey:@"currentUser"]];
        k = [Knife makeKnife:[[user objectAtIndex:5]intValue]];
        k.position = ccp(160,240);
        [self addChild:k z:3];
        gameTime = 30;
        int addTime = [[prefs objectForKey:@"currentItem"]intValue];
        if(addTime!=-1){
            gameTime += (addTime*10);
            [prefs setValue:[NSNumber numberWithInt:-1] forKey:@"currentItem"];        
        }
        
        [self genJf];
        
        [self scheduleUpdate];
    }
    return self;
}

-(void) dealloc{
    [body release];
    [points release];
    [fishList release];
    [jf release];
    [super dealloc];
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	UITouch *touch = [touches anyObject];
	sp = [touch locationInView: [touch view]];  
    sp = [[CCDirector sharedDirector] convertToGL: sp];
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
	sp = [touch locationInView: [touch view]];  
    sp = [[CCDirector sharedDirector] convertToGL: sp];
	
    ep = [touch previousLocationInView:[touch view]];
    ep = [[CCDirector sharedDirector] convertToGL:ep];
	
	[points addObject:[NSValue valueWithCGPoint:sp]];
	[points addObject:[NSValue valueWithCGPoint:ep]];
    
    k.position = ccp(ep.x,ep.y);
	k.startPoint = ccp(sp.x,sp.y);
    k.endPoint = ccp(ep.x,ep.y);

    
}


-(void) genFish:(int) f{
    int num_salmon = floor(f * salmonPre);
	int num_fly = floor(f * flyPre);
	for (int n = 0; n < num_salmon; n++){
        Fish* fish = [Fish makeFish:0];
		[fishList addObject:fish];
		[self addChild:fish z:2];
	}
    
	for (int n = 0; n < num_fly; n++){
		Fish* fish = [Fish makeFish:1];
		[fishList addObject:fish];
		[self addChild:fish z:2];
	}
}

-(void) genJf{
    int x = 2 - [jf count];
    for( int n = 0; n < x; n++){
        Jelly* f = [Fish makeFish:2];
        [f setUpDst:k.position.x dy:k.position.y];
        [self addChild:f z:3];
        [jf addObject:f];
    }
}

-(void) update:(ccTime) dt{
    
    if([points count] > 1){
		[points removeObjectAtIndex:0];
	}
	
	if([points count] > 20){
		[points removeObjectAtIndex:0];
		[points removeObjectAtIndex:0];
		[points removeObjectAtIndex:0];
		[points removeObjectAtIndex:0];
        
	}
    [dN setUpLines:points];

    for(int n = 0; n < [fishList count]; n++){
        Fish* f = [fishList objectAtIndex:n];
        [f fishRun:dt];
        if([k checkInsert:f]){
            f.dead = YES;
            score+= f.score;
            [scoreLabel setString:[NSString stringWithFormat:@"%d",score]];
            [self genBodyFor:f];
        }
        if(f.dead == YES){
            [fishList removeObject:f];
            [self removeChild:f cleanup:YES];
        }
    }
    
    for(int n = 0; n < [body count]; n++){
        fishBody* fb = [body objectAtIndex:n];
        [fb bodyGo:dt];
        if(fb.dead){
            [self removeChild:fb cleanup:YES];
        }
    }
    
    if([fishList count] == 0){
        [self genFish:(arc4random() % 8 + 1)];
    }
    
    if( [jf count] < 2){
        [self genJf];
    }
    
    for(int n = 0; n < [jf count]; n++){
        Jelly* f = [jf objectAtIndex:n];
        [f setUpDst:k.position.x dy:k.position.y];
        [f fishRun:dt];
        if([k checkInsert:f]){
            f.dead = YES;
            score+= f.score;
            [scoreLabel setString:[NSString stringWithFormat:@"%d",score]];
            [self genBodyFor:f];
        }
        if(n >= 1 && [jf count]>=1){
            Jelly* f0 = [jf objectAtIndex:n-1];
            if(abs(f.position.x- f0.position.x)<=20 && abs(f.position.y - f0.position.y)<=20){
                f.dead = YES;
                f0.dead = YES;
                [jf removeObject:f0];
                [self removeChild:f0 cleanup:YES];
            }
        }
        if(f.dead == YES){
            [jf removeObject:f];
            [self removeChild:f cleanup:YES];
        }
    }
    totalTime += dt;
    currentTime = totalTime;
    if(currentTime >= gameTime){
        [self stopGame];
    }
}

-(void) genBodyFor:(Fish*) f {
    fishBody* bl = [fishBody makeBody:f.leftModel right:NO];
    bl.scaleX = (f.sizeX/f.contentSize.width) * 0.5;
    bl.scaleY = f.sizeY/f.contentSize.height;
    bl.position = ccp( f.position.x-10, f.position.y);
    [body addObject:bl];
    [self addChild:bl z:3];

    fishBody* br = [fishBody makeBody:f.rightModel right:YES];
    br.position = ccp(f.position.x+10, f.position.y);
    br.scaleX = (f.sizeX/f.contentSize.width);
    br.scaleY = f.sizeY/f.contentSize.height;
    [body addObject:br];
    [self addChild:br z:3];
}

-(void) stopGame{
    [self unscheduleUpdate];
    [self removeAllChildrenWithCleanup:YES];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSMutableArray* user = [NSMutableArray arrayWithArray:[prefs objectForKey:@"currentUser"]];
    [user replaceObjectAtIndex:4 withObject:[NSNumber numberWithInt:score]];
    [prefs setValue:user forKey:@"currentUser"];
    [prefs synchronize];
    [prefs setValue:user forKey:[user objectAtIndex:0]];
    [prefs synchronize];
    [[CCDirector sharedDirector] replaceScene:[loadingSence loadSence:@"gameback.jpg" from:4 to:6]]; 
}


@end
