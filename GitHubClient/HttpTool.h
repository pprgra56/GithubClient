//
//  SHHttpTool.h
//  GitHubClient
//
//  Created by 常琼 on 16/5/3.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTool : NSObject

+ (instancetype)sharedInstance;
/**
 *  post
 *
 *  @param url     <#url description#>
 *  @param param   <#param description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)post:(NSString *)url params:(NSDictionary *)param success:(void (^)(id responseObj))success failure:(void (^)(id error))failure;

/**
 *  get
 *
 *  @param url     <#url description#>
 *  @param param   <#param description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
- (void)get:(NSString *)url params:(NSDictionary *)param success:(void (^)(id responseObj,id task))success failure:(void (^)(id error))failure;


/**
 *  test use
 *
 *  @param url     <#url description#>
 *  @param param   <#param description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
//- (void)get2:(NSString *)url params:(NSDictionary *)param success:(void (^)(id responseObj))success failure:(void (^)(id error))failure;


@end
