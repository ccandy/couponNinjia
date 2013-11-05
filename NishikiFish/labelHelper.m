//
//  labelHelper.m
//  NishikiFish
//
//  Created by dong hua on 12-8-7.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "labelHelper.h"


@implementation labelHelper

+(id) makeLabel:(CGPoint)pos withStr:(NSString *)str{
    CCLabelTTF* label  = [CCLabelTTF labelWithString:str fontName:@"Arial" fontSize:20];
    label.position = ccp(pos.x,pos.y);
    label.color = ccc3(153, 0, 153);
    return label;
}

@end
