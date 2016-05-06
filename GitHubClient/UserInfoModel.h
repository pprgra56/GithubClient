//
//  UserInfoModel.h
//  GitHubClient
//
//  Created by 常琼 on 16/5/6.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject<NSCoding>

@property(nonatomic,copy)  NSString *identify;
@property(nonatomic,copy)  NSString *name;
@property(nonatomic,copy)  NSString *blog;
@property(nonatomic,copy)  NSString *company;
@property(nonatomic,copy)  NSString *email;


@end