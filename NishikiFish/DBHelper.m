//
//  DBHelper.m
//  NishikiFish
//
//  Created by dong hua on 12-8-9.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "DBHelper.h"
#import "GameConfig.h"
#define pid @"default"
#define kid @"uid"
#define kpw @"pw"
#define kpn @"pn"
#define kem @"em"
#define kqid @"qid"
#define kScore @"score"
#define kType @"type"
@implementation DBHelper


+(NSData* ) testDB{
    NSMutableString *postString = [NSMutableString stringWithString:@"http://menu.qqsushi.com/phpTest/AndyTest.php"];
    [postString appendFormat:[NSString stringWithFormat:@"?%@=%@",kName,pid]];
    NSURL *urlToSend = [[NSURL alloc] initWithString:postString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:urlToSend ];  
    
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    urlData = [NSURLConnection sendSynchronousRequest:urlRequest  
                                    returningResponse:&response 
                                                error:&error];
    return urlData;

}

+(NSData*) getUser:(NSString*) uid{
    
    NSMutableString *postString = [NSMutableString stringWithString:@"http://menu.qqsushi.com/phpTest/AndyTest.php"];
    [postString appendFormat:[NSString stringWithFormat:@"?%@=%@",kName,uid]];
    NSURL *urlToSend = [[NSURL alloc] initWithString:postString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:urlToSend ];  
    
    NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    urlData = [NSURLConnection sendSynchronousRequest:urlRequest  
                                    returningResponse:&response 
                                                error:&error];
    if(urlData != NULL){
        NSString *aStr = [[[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding]autorelease];
        if(aStr.length <=2){
            return NULL;
        }
        return urlData;
    }else {
        return NULL;
    }
    
}



+(NSURLResponse*) createNew:(NSString*) uid pw:(NSString*) p em:(NSString*) e pn:(NSString*) pnum{
    NSMutableString *postString = [NSMutableString stringWithString:@"http://menu.qqsushi.com/phpTest/setJson.php"];
    [postString appendFormat:[NSString stringWithFormat:@"?%@=%@",kid,uid]];
    [postString appendFormat:[NSString stringWithFormat:@"&%@=%@",kpw,p]];
    [postString appendFormat:[NSString stringWithFormat:@"&%@=%@",kpn,pnum]];
    [postString appendFormat:[NSString stringWithFormat:@"&%@=%@",kem,e]];
    NSURL *urlToSend = [[NSURL alloc] initWithString:postString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:urlToSend ];
    NSURLResponse *response;
    NSError *error;
    [NSURLConnection sendSynchronousRequest:urlRequest  
                                    returningResponse:&response 
                                                error:&error];
    return response;
    
}

+(NSURLResponse*) buyQs:(NSString*) qid forUser:(NSString*) uid{
    NSMutableString *postString = [NSMutableString stringWithString:@"http://menu.qqsushi.com/phpTest/setQs.php"];
    [postString appendFormat:[NSString stringWithFormat:@"?%@=%@",kid,uid]];
    [postString appendFormat:[NSString stringWithFormat:@"&%@=%@",kqid,qid]];
    NSURL *urlToSend = [[NSURL alloc] initWithString:postString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:urlToSend ];
    NSURLResponse *response;
    NSError *error;
    [NSURLConnection sendSynchronousRequest:urlRequest  
                      returningResponse:&response 
                                  error:&error];
    return response;

}

+(NSData*) getQsfor:(NSString* ) uid{
    NSMutableString *postString = [NSMutableString stringWithString:@"http://menu.qqsushi.com/phpTest/getQsUser.php"];
    [postString appendFormat:[NSString stringWithFormat:@"?%@=%@",kid,uid]];
    NSLog(@"%@",postString);
    NSURL *urlToSend = [[NSURL alloc] initWithString:postString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:urlToSend ];
    NSURLResponse *response;
    NSError *error;
    NSData* urlData =[NSURLConnection sendSynchronousRequest:urlRequest
                                           returningResponse:&response
                                                       error:&error];
    if(urlData != NULL){
        NSString *aStr = [[[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding]autorelease];
        if(aStr.length <=2){
            return NULL;
        }
        return urlData;
    }else {
        return NULL;
    }

}

+(NSData*) getQs{
    
    NSMutableString *postString = [NSMutableString stringWithString:@"http://menu.qqsushi.com/phpTest/getQs.php"];
    NSURL *urlToSend = [[NSURL alloc] initWithString:postString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:urlToSend ];
    NSURLResponse *response;
    NSError *error;
    NSData* urlData =[NSURLConnection sendSynchronousRequest:urlRequest  
                          returningResponse:&response 
                                      error:&error];
    if(urlData != NULL){
        NSString *aStr = [[[NSString alloc] initWithData:urlData encoding:NSUTF8StringEncoding]autorelease];
        if(aStr.length <=2){
            return NULL;
        }
        return urlData;
    }else {
        return NULL;
    }

}





+(NSURLResponse*) updateScore:(int) s forUser:(NSString *)uid{
    NSMutableString *postString = [NSMutableString stringWithString:@"http://menu.qqsushi.com/phpTest/updateJson.php"];
    [postString appendFormat:[NSString stringWithFormat:@"?%@=%@",kid,uid]];
    [postString appendFormat:[NSString stringWithFormat:@"&%@=%d",kScore,s]];
    NSURL *urlToSend = [[NSURL alloc] initWithString:postString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:urlToSend ];
    NSURLResponse *response;
    NSError *error;
    [NSURLConnection sendSynchronousRequest:urlRequest  
                                           returningResponse:&response 
                                                       error:&error];
    return response;
}

+(NSURLResponse*) updateWeapon:(int)s forUser:(NSString *)uid{
    NSMutableString *postString = [NSMutableString stringWithString:@"http://menu.qqsushi.com/phpTest/updateWeapon.php"];
    [postString appendFormat:[NSString stringWithFormat:@"?%@=%@",kid,uid]];
    [postString appendFormat:[NSString stringWithFormat:@"&%@=%d",kType,s]];

    NSURL *urlToSend = [[NSURL alloc] initWithString:postString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:urlToSend ];
    NSURLResponse *response;
    NSError *error;
    [NSURLConnection sendSynchronousRequest:urlRequest  
                          returningResponse:&response 
                                      error:&error];
    return response;
}

@end
