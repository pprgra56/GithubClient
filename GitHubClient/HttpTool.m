//
//  SHHttpTool.m
//  GitHubClient
//
//  Created by 常琼 on 16/5/3.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "HttpTool.h"
#import "AFNetworking.h"


@implementation HttpTool

+(void)post:(NSString *)url params:(NSDictionary *)param success:(void (^)(id responseObj))success failure:(void (^)(id error))failure{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager POST:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success){
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure){
            failure(error);
        }
    }];

}

+(void)get:(NSString *)url andToken:(NSString *)token success:(void (^)(id responseObj))success failure:(void (^)(id error))failure{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if(token != nil){
        url = [NSString stringWithFormat:@"%@%@",url,token];
        NSString *authorization = [NSString stringWithFormat:@"%@ %@",@"token", token];
        [manager.requestSerializer setValue:authorization forHTTPHeaderField:@"Authorization"];
    }

    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if(success){
            success(responseObject);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        if(failure){
            failure(error);
        }
    }];
}

@end
