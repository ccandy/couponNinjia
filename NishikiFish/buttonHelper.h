//
//  buttonHelper.h
//  NishikiFish
//
//  Created by Hua Dong on 13-04-15.
//
//

#import "CCNode.h"
#import "cocos2d.h"
@interface buttonHelper : CCNode{
}

@property (nonatomic,retain) CCMenuItem* item;
@property (nonatomic,retain) CCLabelTTF* label;
@property (readonly) CGPoint pos;
@property (readonly) CGSize size;
+(id) makeButton:(NSString*) title pos:(CGPoint) pt fontNum:(int) n;
-(id) initButton:(NSString*) title pos:(CGPoint) pt fontNum:(int) n;
-(void) updateMPos;



@end
