//
//  NSUserDefaults+Joker.h
//  GitHubClient
//
//  Created by 常琼 on 16/5/5.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Joker)

/**
 *  存储github_token
 *
 *  @param token
 */
+ (void)setToken:(NSString *)token;


/**
 *  获取github_token
 *
 *  @return token
 */
+ (NSString *)getToken;
@end
