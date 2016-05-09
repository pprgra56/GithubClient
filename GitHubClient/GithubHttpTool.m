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
#import "AFNetworking.h"
#import "MJExtension.h"
#import "Repository.h"

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

    AFHTTPSessionManager *manager =  [_httpTool performSelector:@selector(manager)];
    if (self.eTag.length > 0) {
        [manager.requestSerializer setValue:self.eTag forHTTPHeaderField:@"If-None-Match"];
        manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    }


    [_httpTool get:url params:nil success:^(id responseObj,id task) {

        long statusCode = ((NSHTTPURLResponse *)((NSURLSessionDataTask *) task).response).statusCode;
        NSLog(@"😇Joker code status = %ld",statusCode);

        NSString *etag = ((NSDictionary *)(((NSHTTPURLResponse *)((NSURLSessionDataTask *) task).response).allHeaderFields))[@"Etag"];
        self.eTag = etag;

        NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [docPath stringByAppendingPathComponent:@"Repository.arc"];

        if(statusCode == 200){

            NSArray *result =  (NSArray *)responseObj;

             NSArray *array = [Repository mj_objectArrayWithKeyValuesArray:responseObj];



            //归档
            [NSKeyedArchiver archiveRootObject:result toFile:path];
            if(success) success(array);

        }else if(statusCode == 304){

            //读取缓存
            NSArray  *responseObjArray =  [NSKeyedUnarchiver unarchiveObjectWithFile:path];

             NSArray *array = [Repository mj_objectArrayWithKeyValuesArray:responseObjArray];

            if(success) success(array);
        }


    } failure:^(id error) {

        NSLog(@"someting wrong %@",error);
    }];
}






@end
