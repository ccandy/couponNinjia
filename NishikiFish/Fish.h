//
//  Fish.h
//  NishikiFish
//
//  Created by dong hua on 12-8-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Fish : CCSprite {
    int score;
    double xSpeed,ySpeed,accX,accY;
    BOOL dead;
    NSString* leftModel; 
    NSString* rightModel;
    int angle;
    int sizeX, sizeY;
}
@property (readonly, copy) NSString* leftModel;
@property (readonly, copy) NSString* rightModel;
@property (assign) BOOL dead;
@property (readonly, assign) int sizeX;
@property (readonly, assign) int sizeY;
@property (readonly, assign) int score;
+(id) makeFish:(int) f;
-(id) initFish;
-(BOOL) isOut;
-(void) fishRun:(ccTime) delta;
@end
