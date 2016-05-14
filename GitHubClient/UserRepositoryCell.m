//
//  UserRepositoryCell.m
//  GitHubClient
//
//  Created by 常琼 on 16/5/9.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "UserRepositoryCell.h"
#import "UIImageView+WebCache.h"
#import "Repository.h"

@interface UserRepositoryCell()

@property (weak, nonatomic) IBOutlet UIImageView *headImgiv;
@property (weak, nonatomic) IBOutlet UILabel *repositoryNamelb;
@property (weak, nonatomic) IBOutlet UILabel *starNOlb;
@property (weak, nonatomic) IBOutlet UILabel *branchNOlb;

@end

@implementation UserRepositoryCell

- (void)setRepositoryInfo:(Repository *)repo{
    if(repo.name != nil){

        [self.repositoryNamelb setText:repo.name];
    }
    if(repo.stargazers_count != nil){

        [self.starNOlb setText:repo.stargazers_count];
    }
    if(repo.forks_count != nil){
        [self.branchNOlb setText:repo.forks_count];
    }
}




@end
