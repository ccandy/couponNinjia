//
//  GameSence.h
//  NishikiFish
//
//  Created by dong hua on 12-8-16.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "drawNode.h"
#import "Knife.h"
@interface GameSence : CCLayer {
    NSMutableArray* fishList;
    NSMutableArray* points;
    NSMutableArray* body;
    NSMutableArray* jf;
    CCLabelTTF* scoreLabel;
    double totalTime;
    int currentTime;
    int score,gameTime;
    CGPoint sp,ep;
    drawNode* dN;
    Knife* k;
    
}

@property (nonatomic, retain) drawNode* dN;

+(id) scene;

@end
