//
//  NewUserSence.h
//  NishikiFish
//
//  Created by Hua Dong on 12-11-24.
//
//

#import "CCLayer.h"
#import "cocos2d.h"

@interface NewUserSence : CCLayer{
    UITextField* txtID;
    UITextField* txtPw;
    UITextField* txtrPw;
    UITextField* txtEmail;
    UITextField* txtPn;
    double currentTime;
    int totalTime;
    CCMenu* m;
    CCMenuItem* back;
    CCMenuItem* create;
}
+(id) scene;

@end
