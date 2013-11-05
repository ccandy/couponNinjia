//
//  buttonHelper.m
//  NishikiFish
//
//  Created by Hua Dong on 13-04-15.
//
//

#import "buttonHelper.h"

@implementation buttonHelper
@synthesize item;
@synthesize size;
@synthesize pos;
@synthesize label;
+(id) makeButton:(NSString *)title pos:(CGPoint)pt fontNum:(int)n{
    return [[self alloc] initButton:title pos:pt fontNum:n];
}

-(id) initButton:(NSString *)title pos:(CGPoint)pt fontNum:(int)n{
    if(self = [super init]){
        label = [[CCLabelTTF labelWithString:title 
                                               fontName:@"Arial-BoldItalicMT" fontSize:n]retain];
        label.position = ccp(pt.x,pt.y);
        
        size = CGSizeMake(100, 50);
        pos = pt;
        label.scaleX = size.width/label.contentSize.width*2/3;
        label.scaleY = size.height/label.contentSize.height/2;
    }
    return self;
    
}

-(void) updateMPos{
    item.scaleX = size.width/item.contentSize.width;
    item.scaleY = size.height/item.contentSize.height;
    
    item.position = pos;
    
}

-(void) dealloc{
    
    [item release];
    [label release];
    [super dealloc];
}

@end
