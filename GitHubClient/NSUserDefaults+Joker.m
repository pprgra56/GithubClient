//
//  NSUserDefaults+Joker.m
//  GitHubClient
//
//  Created by 常琼 on 16/5/5.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "NSUserDefaults+Joker.h"

static NSString *const kGithubTokenKey = @"kGithubTokenKey";

@implementation NSUserDefaults (Joker)

+ (void)setToken:(NSString *)token{

    if(token.length>0){

        [[NSUserDefaults standardUserDefaults] setObject:token forKey:kGithubTokenKey];
    }
}

+ (NSString *)getToken{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:kGithubTokenKey];
}
@end
