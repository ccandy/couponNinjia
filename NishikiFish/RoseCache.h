//
//  RoseCache.h
//  NishikiFish
//
//  Created by Hua Dong on 13-05-05.
//
//

#import "CCNode.h"
#import "cocos2d.h"
@interface RoseCache : CCNode{
    int nextRose;
    CCSpriteBatchNode* batch;

}
-(void) updateRoses:(ccTime) ct;

@end
