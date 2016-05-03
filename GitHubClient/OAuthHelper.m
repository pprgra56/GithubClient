//
//  OAuthHelper.m
//  GitHubClient
//
//  Created by 常琼 on 16/5/3.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "OAuthHelper.h"
#import "HttpTool.h"

@import UIKit;
@interface OAuthHelper()


@end

@implementation OAuthHelper

+(void)getCode{
    
    UIApplication *application =  [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:@"https://github.com/login/oauth/authorize?client_id=b3eb1dd9811e58d681a0&scope=user&redirect_uri=pprgra56://"];
    [application openURL:url];


}
+(void)sendToken:(NSString *)token{

    NSString *urlstr = @"https://api.github.com/user?access_token=";

    [HttpTool get:urlstr andToken:token success:^(id responseObj) {

    NSDictionary *dic = @{@"key":responseObj};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NTRESULT" object:nil userInfo:dic];

        
    } failure:^(id error) {
        NSLog(@"something wrong %@",error);
        
    }];    
    
}

@end