//
//  flyFish.m
//  NishikiFish
//
//  Created by dong hua on 12-8-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "flyFish.h"


@implementation flyFish

+(id) makeFly{
    return [[[self alloc] initFly] autorelease];
}

-(id) initFly{
    if((self = [super initWithFile:@"flyfish.png"])){
        factor = pow(-1, arc4random()%2);
        xSpeed = (arc4random()% 200 + 300);
        xSpeed *= factor;
        if(factor < 0){
            self.flipX = YES;
        }
		ySpeed = arc4random()% 100 + 50;
		accX = 10;
		accY = -9.8;
		dead = NO;
		self.scaleX = 35/self.contentSize.width;
		self.scaleY = 35/self.contentSize.height;
        sizeX = 35;
        sizeY = 35;
		leftModel = @"flyl.png";
		rightModel = @"flyr.png";
        int y = arc4random()%40;
        int x = arc4random()%479 + 1;
		self.position = ccp(x,y);
		score = 50;
        
        //[self scheduleUpdate];
    }
    return self;
}

-(void) dealloc{
    [super dealloc];
}

-(void) fishRun:(ccTime)delta{
    CGPoint pos = self.position;
    pos.x += xSpeed*delta + 0.5*accX*pow(delta,2);
    xSpeed = xSpeed + accX * delta;
    pos.y += ySpeed*delta + 0.5*accY*pow(delta,2);
    ySpeed = ySpeed + accY * delta;
    self.position = ccp(pos.x,pos.y);
    if([self isOut]){
        dead = YES;
    }
    
}

-(int) getFactor{
    return factor;
}

@end
