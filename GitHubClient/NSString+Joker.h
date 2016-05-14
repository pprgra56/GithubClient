//
//  NSString+Joker.h
//  GitHubClient
//
//  Created by 常琼 on 16/5/4.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Joker)

/**
 *  截取字符串
 *
 *  @param str    原字符串
 *  @param symple 开始截取标识
 *
 *  @return 返回字符串
 */
+ (NSString *)interception:(NSString *)str from:(NSString *)symple;

+ (NSString *)getDocPathWithComponent:(NSString *)component;




@end
