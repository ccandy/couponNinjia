//
//  Jelly.m
//  NishikiFish
//
//  Created by dong hua on 12-8-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Jelly.h"


@implementation Jelly

+(id) makeJelly{
    return [[[self alloc] initJelly]autorelease];
}

-(id) initJelly{
    if((self = [super initWithFile:@"jellyFish.png"])){
        xSpeed = 50;
		ySpeed = 50;
		accX = 1;
		accY = 1;
		dead = NO;
		[self setScaleX: 50/self.contentSize.width];
		[self setScaleY: 50/self.contentSize.height];
        sizeX = 50;
        sizeY = 50;
		leftModel = @"jellyl.png";
		rightModel = @"jellyr.png";
        int x = arc4random()%480;
        int y = arc4random()%320;
        self.position = ccp(x,y);
        
		score = -120;
    }
    return self;
}

-(void) setUpDst:(int)dx dy:(int)dy{
    dst = CGPointMake(dx, dy);
}

-(void) fishRun:(ccTime)dt{
    CGPoint pos = self.position;
    double dx = dst.x - pos.x;
    if(dx > 0){
        self.flipX = NO;
    }else if(dx< 0){
        self.flipX = YES;
    }
	double dy = dst.y - pos.y;
	double dz = sqrt(dx*dx + dy*dy);
	double c = dx/dz;
	pos.x += c*xSpeed*dt;
	double s = dy/dz;
	pos.y += s*ySpeed*dt;
	self.position = ccp(pos.x,pos.y);

}


@end
