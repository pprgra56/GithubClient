//
//  GithubHttpTool.h
//  GitHubClient
//
//  Created by 常琼 on 16/5/5.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GithubHttpTool : NSObject


+(instancetype)sharedInstance;


- (void)post:(NSString *)url params:(NSDictionary *)param success:(void (^)(id responseObj))success failure:(void (^)(id error))failure;

- (void)get:(NSString *)url success:(void (^)(id responseObj))success failure:(void (^)(id error))failure;

- (void)getRepositoryWithUrl:(NSString *)url success:(void (^)(id responseObj))success failure:(void (^)(id error))failure;
@end
