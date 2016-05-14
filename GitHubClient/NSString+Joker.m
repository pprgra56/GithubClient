//
//  NSString+Joker.m
//  GitHubClient
//
//  Created by 常琼 on 16/5/4.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "NSString+Joker.h"

@implementation NSString (Joker)

+(NSString *)interception:(NSString *)str from:(NSString *)symple{

    NSRange range =  [str rangeOfString:symple];
    return [[NSString stringWithFormat:@"%@",str] substringFromIndex:range.location+range.length];
}
+ (NSString *)getDocPathWithComponent:(NSString *)component{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [docPath stringByAppendingPathComponent:component];
}


@end
