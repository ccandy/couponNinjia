//
//  drawNode.h
//  NishikiFish
//
//  Created by dong hua on 12-8-18.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface drawNode : CCNode {
	CGPoint sPoint;
	CGPoint ePoint;
	NSArray* points;
}
-(void) setUpLines:(NSArray*) ps;
-(void) setUpSp:(CGPoint) p;
-(void) setUpEp:(CGPoint) p;
@end

