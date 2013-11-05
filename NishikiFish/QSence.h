//
//  QSence.h
//  NishikiFish
//
//  Created by dong hua on 12-8-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface QSence : CCLayer {
    int upperBand;
    NSMutableArray* qs;
    NSMutableArray* qsb;
    int selection;
    NSUserDefaults *prefs;
    int y;
    CCMenu* qbs;
    int total;
    CCLabelAtlas* lblTotal;
    CCLabelAtlas* lblAScore;
    int pageNum;
    int currentPage;
}

+(id) scene;

@end
