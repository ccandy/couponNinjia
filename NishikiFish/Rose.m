//
//  Rose.m
//  NishikiFish
//
//  Created by dong hua on 12-8-7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Rose.h"
#define WINHEIGHT 320
#define WINWIDTH 480

@implementation Rose

+(id) makeRose{
    return [[[self alloc] initRose]autorelease];
}


-(id) initRose{
    if((self = [super initWithFile:@"hua.png"])){
        self.position = ccp(arc4random() % 480, 350 + arc4random() % 20);
        startPoint = self.position;
        self.scaleX = 10/self.textureRect.size.width;
        self.scaleY = 10/self.textureRect.size.height;
        [self reVel];
        
        [self scheduleUpdate];
    }
    return self;
}

-(void) reVel{
    double dx = arc4random() % 10;
    double dy = arc4random() % 20;
    int off = pow(-1, arc4random() % 2);
    velocity = ccp(dx * off,  -dy);
    
}

-(void) update:(ccTime) delta{
    //NSLog(@"update rose");
    self.position = ccpAdd(self.position, ccpMult(velocity, delta));
    if(self.position.x < -5 || self.position.y < -5 || self.position.x > 485){
        self.position = ccp(arc4random() % 480, 350 + arc4random() % 20);
        [self reVel];
    }
    //NSLog(@"%d,%d",self.position.x,self.position.y);
}

@end
