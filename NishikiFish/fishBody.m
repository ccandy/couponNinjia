//
//  fishBody.m
//  NishikiFish
//
//  Created by dong hua on 12-8-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "fishBody.h"
#define numJell 3
@interface fishBody(PrivateMethod)
-(BOOL) isOut;
@end

@implementation fishBody
@synthesize dead;

+(id) makeBody:(NSString *)f right:(BOOL)r{
    return [[[self alloc] initBody:f right:r]autorelease];
}

-(id) initBody:(NSString *)f right:(BOOL)r{
    if((self = [super initWithFile:f])){
        if(r){
            angleIncrment = 1;
            xSpeed = 10;
        }else {
            angleIncrment = -1;
            xSpeed = -10;
        }
        accY = -12;
        ySpeed = -80;
    }
    return self;
}

-(void) bodyGo:(ccTime) dt{
    CGPoint pos = self.position;
    pos.x += xSpeed*dt;
    pos.y += ySpeed*dt + 0.5*accY*pow(dt,2);
    if(abs(angle) < 90 ){
        angle += angleIncrment;
        self.rotation = angle;
    }
    dead = [self isOut];
    self.position = ccp(pos.x,pos.y);
    
}

-(BOOL) isOut{
    CGPoint pos = self.position;
    return ( pos.x < -4 || pos.x > 490 || pos.y > 330 || pos.y < -100);
}

-(void) dealloc{
    [super dealloc];
}
@end
