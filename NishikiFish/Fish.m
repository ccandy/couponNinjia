//
//  Fish.m
//  NishikiFish
//
//  Created by dong hua on 12-8-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Fish.h"
#import "flyFish.h"
#import "Jelly.h"
@implementation Fish
@synthesize dead;
@synthesize sizeX;
@synthesize sizeY;
@synthesize score;
@synthesize rightModel;
@synthesize leftModel;
+(id) makeFish:(int)f{
    switch (f) {
        case 0:
            return [[self alloc] initFish];
            break;
        case 1:
            return [flyFish makeFly];
            break;
        case 2:
            return [Jelly makeJelly];
            break;
        default:
            return NULL;
            break;
    }
}

-(id) initFish{
    if((self = [super initWithFile:@"fish.png"])){        
        self.scaleX = 45/self.contentSize.width;
        self.scaleY = 45/self.contentSize.height;
        sizeX = 45;
        sizeY = 45;
        accY = -45;
        xSpeed = 75 * pow(-1, arc4random()%2);
        if(xSpeed < 0){
            self.flipX = YES;
        }
		ySpeed = arc4random()% 80 + 120;
		accX = 0;
		dead = NO;
        leftModel = @"fishleft.png";
		rightModel = @"fishright.png";
        int y = arc4random()%40;
        self.position = ccp(arc4random()%480,-50 - y);
        score = 20;
        angle = 0;
        //[self scheduleUpdate];
    }
    return self;
}

-(BOOL) isOut{
    CGPoint pos = self.position;
    return (pos.y > 330 || pos.y < -100||pos.x < -4 || pos.x > 490);
    
}



-(void) fishRun:(ccTime) delta{
    CGPoint pos = self.position;
    pos.x += xSpeed*delta;
    ySpeed = ySpeed + accY * delta;
    pos.y += ySpeed*delta + 0.5*accY*pow(delta,2);
    self.position = ccp(pos.x,pos.y);
    angle = (angle + 10) % 360;
    self.rotation = angle;
    if([self isOut]){
        dead = YES;
    }
}

-(void) dealloc{
    [super dealloc];
}

@end
