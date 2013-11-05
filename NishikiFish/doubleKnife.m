//
//  doubleKnife.m
//  NishikiFish
//
//  Created by dong hua on 12-8-15.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "doubleKnife.h"


@implementation doubleKnife

+(id) makeDouble{
    return [[[self alloc] initDouble]autorelease];
}

-(id) initDouble{
    if(self = [super initWithFile:@"doubleknife.png"]){
        
    }
    return self;
}

-(BOOL) cutAvaliable{
	return YES;  
}

-(void) dealloc{
    [super dealloc];
}

@end
