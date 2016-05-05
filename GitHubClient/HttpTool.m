//
//  SHHttpTool.m
//  GitHubClient
//
//  Created by 常琼 on 16/5/3.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"


@interface HttpTool()

@property(strong,nonatomic) AFHTTPSessionManager *manager;
@end

@implementation HttpTool

+ (instancetype)sharedInstance{
    static HttpTool *httptool = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        httptool = [[HttpTool alloc] init];
    });
    return httptool;
}
- (instancetype)init{
    self = [super init];
    if (self){
        _manager = [AFHTTPSessionManager manager];
    }
    return self;
}


- (void)post:(NSString *)url params:(NSDictionary *)param success:(void (^)(id responseObj))success failure:(void (^)(id error))failure{



    [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.manager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if(success) success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        if(failure) failure(error);
    }];

}

- (void)get:(NSString *)url params:(NSDictionary *)param success:(void (^)(id responseObj))success failure:(void (^)(id error))failure{

    [self.manager GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        NSLog(@"Joker statusCode is %d",((NSHTTPURLResponse *)task.response).statusCode);
        if(success){
            NSLog(@"Joker allheader : %@",((NSHTTPURLResponse *)task.response).allHeaderFields);
            success(responseObject);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

     if(failure) failure(error);
    }];
}


@end
