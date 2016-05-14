//
//  UserRepositoryCell.h
//  GitHubClient
//
//  Created by 常琼 on 16/5/9.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Repository;

@interface UserRepositoryCell : UITableViewCell

- (void)setRepositoryInfo:(Repository *)repo;
@end
