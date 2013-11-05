//
//  circleKnife.m
//  NishikiFish
//
//  Created by dong hua on 12-8-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "circleKnife.h"
#import "Knife.h"

@implementation circleKnife

+(id) makeCircle{
    return [[[self alloc] initCircle]autorelease];
}


-(id) initCircle{
    if(self = [self initWithFile:@"circleKnife.png"]){
        rad = 100;
		angle = 0;
        self.scaleX = 50/self.contentSize.width;
        self.scaleY = 50/self.contentSize.height;
        [self scheduleUpdate];
    }
    return self;
}

-(BOOL) cutAvailable{
    return YES;
}


-(BOOL) checkInsert:(Fish*) f{
    if([self cutAvailable] == NO){
		return NO;
	}
    double offX = pow((self.position.x - f.position.x),2);
    double offY = pow((self.position.y - f.position.y),2);
    return ((offX + offY) <= pow(rad,2));
}

-(void)update:(ccTime) dt{
	angle = (angle + 1) % 360;
	self.rotation = angle;
}

@end
