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
#import "NSString+Joker.h"
#import "AFHTTPSessionManager.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "Repository.h"
#import <Realm/Realm.h>

@interface GithubHttpTool()

@property(strong,nonatomic) HttpTool *httpTool;

@property(nonatomic,copy)  NSString *eTag;

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
    NSLog(@"Joker token is %@",token);

    [manager.requestSerializer setValue:authorization forHTTPHeaderField:@"Authorization"];


    [_httpTool get:url params:nil success:^(id responseObj,id task) {

        if(success) success(responseObj);
    } failure:^(id error) {

        NSLog(@"someting wrong %@",error);
    }];
}

- (void)getRepositoryWithUrl:(NSString *)url success:(void (^)(id responseObj))success failure:(void (^)(id error))failure{


    if(self.eTag.length > 0) [_httpTool handleETag:self.eTag];


    [_httpTool get:url params:nil success:^(id responseObj,id task) {

        long statusCode = ((NSHTTPURLResponse *)((NSURLSessionDataTask *) task).response).statusCode;
        NSLog(@"😇Joker code status = %ld",statusCode);

        self.eTag  = ((NSDictionary *)(((NSHTTPURLResponse *)((NSURLSessionDataTask *) task).response).allHeaderFields))[@"Etag"];



        if(statusCode == 200){



            NSArray <Repository *> *array = [Repository mj_objectArrayWithKeyValuesArray:responseObj];
            RLMRealm *realm = [RLMRealm defaultRealm];
            [realm transactionWithBlock:^{
                [realm deleteAllObjects];
                [realm addObjects:array];
            }];



            if(success) success(array);

        }else if(statusCode == 304){

            RLMResults <Repository *> *array = [Repository allObjects];
            
            if(success) success(array);
        }
        
        
    } failure:^(id error) {
        
        NSLog(@"someting wrong %@",error);
    }];
}






@end
