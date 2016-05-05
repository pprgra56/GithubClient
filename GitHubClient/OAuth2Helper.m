//
//  OAuthHelper.m
//  GitHubClient
//
//  Created by 常琼 on 16/5/3.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "OAuth2Helper.h"
#import "GithubHttpTool.h"
#import "NSString+Joker.h"
#import "NSUserDefaults+Joker.h"

#define GithubLoginUrl @"https://github.com/login/oauth/authorize"
#define GithubTokenUrl @"https://github.com/login/oauth/access_token"
#define GithubCodeUrl  @"https://api.github.com/user?access_token="

#define CLIENT_ID @"b3eb1dd9811e58d681a0"
#define client_secret @"0ae4efec24d439192e0c9b0d2af303692f47f4a2"
#define SCOPE @"user"
#define REDIRECT_URI @"pprgra56://"
@import UIKit;


@implementation OAuth2Helper




- (void)openLoginUrl{

    UIApplication *application =  [UIApplication sharedApplication];

    NSString *urlstr = [NSString stringWithFormat:@"%@?client_id=%@&scope=%@&redirect_uri=%@",GithubLoginUrl,CLIENT_ID,SCOPE,REDIRECT_URI];

    NSURL *url = [NSURL URLWithString:urlstr];

    if([application canOpenURL:url]){
        [application openURL:url];
    }
}

- (void)getCodeFromUrl:(NSURL *)url{

    NSString *code =  [NSString cutString:url.absoluteString atSympol:@"="];

    [self getTokenWithCode:code];
}
- (void)getTokenWithCode:(NSString *)code{

    NSDictionary *param = @{@"client_id":CLIENT_ID,@"client_secret":client_secret,@"code":code};
    [[GithubHttpTool sharedInstance] post:GithubTokenUrl params:param success:^(id responseObj) {
        NSLog(@"Joker 1238 is %@",responseObj);
        NSString *github_token = [(NSDictionary *)responseObj objectForKey:@"access_token"];

        //保存token
        [NSUserDefaults setToken:github_token];
        NSLog(@"Joker number is %@",self.delegate);
        if([self.delegate respondsToSelector:@selector(pullUserInfo)]){
            [self.delegate pullUserInfo];
        }
    } failure:^(id error) {

        NSLog(@"somthing wrong %@",error);
    }];
}


- (void)pullUserInfoWithToken{

    [[GithubHttpTool sharedInstance] get:GithubCodeUrl success:^(id responseObj) {

        if([self.delegate respondsToSelector:@selector(displayUserInfo:)]) [self.delegate displayUserInfo:responseObj];
    } failure:nil];

}

@end