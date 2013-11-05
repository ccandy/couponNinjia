//
//  viewQ.h
//  NishikiFish
//
//  Created by Hua Dong on 12-12-23.
//
//

#import "CCLayer.h"
#import "cocos2d.h"
@interface viewQ : CCLayer{
    NSUserDefaults* prefs;
    NSMutableArray* qs;
    int currentPage;
    CCMenu* qbs;
    int upperBand;
}
+(id) scene;


@end
