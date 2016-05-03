//
//  AppDelegate.m
//  GitHubClient
//
//  Created by 臧其龙 on 16/4/30.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "AppDelegate.h"
#import "HttpTool.h"
#import "OAuthHelper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    return YES;
}
-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{

    //截取code
    NSRange r = [[NSString stringWithFormat:@"%@",url] rangeOfString:@"="];
    NSString  *code =  [[NSString stringWithFormat:@"%@",url] substringFromIndex:r.location+r.length];

    //url
    NSString *urlstr = @"https://github.com/login/oauth/access_token";

    NSDictionary *param = @{@"client_id":@"b3eb1dd9811e58d681a0",@"client_secret":@"0ae4efec24d439192e0c9b0d2af303692f47f4a2",@"code":code};

    [HttpTool post:urlstr params:param success:^(id responseObj) {
        NSString *token = [(NSDictionary *)responseObj objectForKey:@"access_token"];
        NSLog(@"token is %@",token);
        [OAuthHelper sendToken:token];
    } failure:^(id error) {
        NSLog(@"something wrong %@",error);
        
    }];
    

    return YES;
}
 @end
