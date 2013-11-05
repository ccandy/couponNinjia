//
//  Knife.m
//  NishikiFish
//
//  Created by dong hua on 12-8-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Knife.h"
#import "doubleKnife.h"
#import "circleKnife.h"
#import "Fish.h"

@implementation Knife
@synthesize startPoint;
@synthesize endPoint;

+(id) makeKnife:(int) k{
    switch (k) {
        case 0:
            return [[[self alloc] initKnife]autorelease];
            break;
        case 1:
            return [doubleKnife makeDouble];
            break;
        case 2:
            return [circleKnife makeCircle];
            break;
        default:
            return NULL;
            break;
    }
}

-(id) initKnife{
    if(self = [super initWithFile:@"knife.png"]){
        self.scaleX = 50/self.contentSize.width;
        self.scaleY = 50/self.contentSize.height;
    }
    return self;
}

-(BOOL) cutAvailable{
	return startPoint.x > endPoint.x;  
}

-(BOOL) checkInsert:(Fish*) k{
	if([self cutAvailable]== NO){
		return NO;
	}
    
    CGRect r1 = CGRectMake(self.position.x, self.position.y, 35, 35);
    CGRect r2 = CGRectMake(k.position.x, k.position.y,k.sizeX,k.sizeY);
    
    return CGRectIntersectsRect(r1, r2);
    
}





-(void) dealloc{
    [super dealloc];
}

@end
