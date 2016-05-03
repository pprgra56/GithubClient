//
//  OAuth2Manager.m
//  GitHubClient
//
//  Created by 臧其龙 on 16/5/1.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "OAuth2Manager.h"
#import "GithubHttCongifuration.h"
#import "OAuth2TokenRequest.h"
#import <UIKit/UIKit.h>
#import "NSUserDefaults+TokenAccess.h"

@implementation OAuth2Manager

+ (void)openSafariToLogin
{
    NSString *urlString = [NSString stringWithFormat:@"%@?client_id=%@&scope=%@&redirect_uri=%@",
                           kGithubAuthorizeURL, kGithubClientID, kGithubOAuthScope, kGithubRedirectURL];
    NSURL *url = [NSURL URLWithString:urlString];
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }

}

+ (void)handleRedirectURL:(NSURL *)url
{
    NSString *urlString      = [[url absoluteString] lowercaseString];
    NSString *redirectString = [[NSString stringWithFormat:@"%@?code=", kGithubRedirectURL] lowercaseString];
    
    if ([urlString hasPrefix:redirectString]) {
        NSString *code = [urlString stringByReplacingOccurrencesOfString:redirectString withString:@""];
        OAuth2TokenRequest *oauthRequest = [[OAuth2TokenRequest alloc] initWithCode:code];
        [oauthRequest startWithFinishedBlock:^(NSError *error, id responseObject) {
    
            if (!error) {
                NSLog(@"%@", responseObject);
                [[NSUserDefaults standardUserDefaults] setToken:responseObject[@"access_token"]];
                [[NSUserDefaults standardUserDefaults] setTokenType:responseObject[@"token_type"]];
            }
        }];
    }
}

@end
