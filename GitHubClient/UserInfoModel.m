//
//  UserInfoModel.m
//  GitHubClient
//
//  Created by 常琼 on 16/5/6.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "UserInfoModel.h"
#define kidentify @"kidentify"
#define kname @"kname"
#define kblog @"kblog"
#define kcompany @"kcompany"
#define kemail @"kemail"

@implementation UserInfoModel



- (void)encodeWithCoder:(NSCoder *)encode{

    [encode encodeObject:self.identify forKey:kidentify];
    [encode encodeObject:self.name forKey:kname];
    [encode encodeObject:self.blog forKey:kblog];
    [encode encodeObject:self.company forKey:kcompany];
    [encode encodeObject:self.email forKey:kemail];
}
- (nullable instancetype)initWithCoder:(NSCoder *)decoder{
    self = [super init];

    if(self){

        self.identify = [decoder decodeObjectForKey:kidentify];
        self.name = [decoder decodeObjectForKey:kname];
        self.company = [decoder decodeObjectForKey:kcompany];
        self.blog = [decoder decodeObjectForKey:kblog];
        self.email = [decoder decodeObjectForKey:kemail];
    }

       return self;
}

@end
