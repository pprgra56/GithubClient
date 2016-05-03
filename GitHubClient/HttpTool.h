//
//  SHHttpTool.h
//  GitHubClient
//
//  Created by 常琼 on 16/5/3.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject
+(void)post:(NSString *)url params:(NSDictionary *)param success:(void (^)(id responseObj))success failure:(void (^)(id error))failure;

+(void)get:(NSString *)url  andToken:(NSString *)token success:(void (^)(id responseObj))success failure:(void (^)(id error))failure;

@end
