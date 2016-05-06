//
//  GithubHttpTool.m
//  GitHubClient
//
//  Created by 常琼 on 16/5/5.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "GithubHttpTool.h"
#import "HttpTool.h"
#import "NSUserDefaults+Joker.h"
#import "AFHTTPSessionManager.h"

@interface GithubHttpTool()

@property(strong,nonatomic) HttpTool *httpTool;
@end



@implementation GithubHttpTool

+ (instancetype)sharedInstance{

    static GithubHttpTool *githubHttpTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        githubHttpTool = [[GithubHttpTool alloc] init];
    });
    return githubHttpTool;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _httpTool = [HttpTool sharedInstance];
    }
    return self;
}


- (void)post:(NSString *)url params:(NSDictionary *)param success:(void (^)(id responseObj))success failure:(void (^)(id error))failure{
    [_httpTool post:url params:param success:^(id responseObj) {

        if(success) success(responseObj);
    } failure:^(id error) {

        if(failure) failure(error);
    }];
}

- (void)get:(NSString *)url success:(void (^)(id responseObj))success failure:(void (^)(id error))failure{

    NSString *token =  [NSUserDefaults  getToken];

    url = [NSString stringWithFormat:@"%@%@",url,token];
    NSString *authorization = [NSString stringWithFormat:@"%@ %@",@"token", token];
    AFHTTPSessionManager *manager =  [_httpTool performSelector:@selector(manager)];
    
    [manager.requestSerializer setValue:authorization forHTTPHeaderField:@"Authorization"];
    [_httpTool get:url params:nil success:^(id responseObj) {

        if(success) success(responseObj);
    } failure:^(id error) {

        NSLog(@"someting wrong %@",error);
    }];
}








@end
