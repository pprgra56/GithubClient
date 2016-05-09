//
//  Repository.h
//  GitHubClient
//
//  Created by 常琼 on 16/5/9.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repository : NSObject

@property(nonatomic,copy)  NSString *name;
@property(nonatomic,copy)  NSString *stargazers_count;
@property(nonatomic,copy)  NSString *forks_count;




@end
