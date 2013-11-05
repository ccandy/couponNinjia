//
//  textFieldMaker.m
//  NishikiFish
//
//  Created by dong hua on 12-8-8.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "textFieldMaker.h"


@implementation textFieldMaker

+(UITextField*) getTextField:(int) x y:(int) y height:(int) h width:(int) w gate:(id) g{
    UITextField* txt = [[[UITextField alloc] initWithFrame:CGRectMake(x,y, h, w)]autorelease];
    txt.backgroundColor = [UIColor clearColor];
    txt.textColor = [UIColor blueColor];
    txt.transform = CGAffineTransformTranslate(CGAffineTransformMakeRotation(M_PI/2), 0, 0);
    txt.layer.cornerRadius = 5.0;
    txt.background = [UIImage imageNamed:@"textbox.png"];
    [txt becomeFirstResponder];
    txt.hidden = YES;
    txt.autocapitalizationType = NO;
    txt.delegate = g;
    return txt;
}

@end
