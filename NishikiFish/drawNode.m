//
//  drawNode.m
//  NishikiFish
//
//  Created by dong hua on 12-8-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "drawNode.h"


@implementation drawNode

-(void) setUpEp:(CGPoint)p{
	ePoint = p;
}

-(void) setUpSp:(CGPoint)p{
	sPoint = p;
}

-(void) dealloc{
	[super dealloc];
}
-(void) setUpLines:(NSArray*) ps{
	points = ps;
}

-(void) draw{
	//glEnable(GL_LINE_SMOOTH);
	for(int n = 0; n<[points count]/2; n++){
		sPoint = [[points objectAtIndex:(n*2)]CGPointValue];
		ePoint = [[points objectAtIndex:(n*2+1)]CGPointValue];
		ccDrawLine(ccp(sPoint.x,sPoint.y), ccp(ePoint.x,ePoint.y));
	}
}


@end
