//
//  AppDelegate.m
//  GitHubClient
//
//  Created by 臧其龙 on 16/4/30.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "AppDelegate.h"
#import "AFNetworking.h"

@interface AppDelegate ()
@property(strong,nonatomic) AFHTTPSessionManager *manager;

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


    //获取token
    self.manager = [AFHTTPSessionManager manager];
    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];



        //参数
        NSDictionary *param = @{@"client_id":@"b3eb1dd9811e58d681a0",@"client_secret":@"0ae4efec24d439192e0c9b0d2af303692f47f4a2",@"code":code};

       [self.manager POST:urlstr parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

           NSString *token = [(NSDictionary *)responseObject objectForKey:@"access_token"];
           NSLog(@"token is %@",token);

           //获取user信息
           [self sendToken:(NSString *)token];


    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        NSLog(@"something wrong %@",error);
    }];



    return YES;
}
-(void)sendToken:(NSString *)token{

    NSString *authorization = [NSString stringWithFormat:@"%@ %@",@"token", token];
    [self.manager.requestSerializer setValue:authorization forHTTPHeaderField:@"Authorization"];

    NSString *urlstr = [NSString stringWithFormat:@"https://api.github.com/user?access_token=%@",token];

    [self.manager GET:urlstr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSLog(@"Joker number is %@",responseObject);

        [self.v1.texttv setText:[NSString stringWithFormat:@"%@",responseObject]];



    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"something wrong %@",error);

    }];




}
 @end
