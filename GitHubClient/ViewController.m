//
//  ViewController.m
//  GitHubClient
//
//  Created by 臧其龙 on 16/4/30.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "ViewController.h"
#import "OAuth2Helper.h"
#import "AppDelegate.h"
#import "UserRepositoryCell.h"
#import "Repository.h"

@interface ViewController ()<OAuth2HelperDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextView *texttv;

@property(strong,nonatomic) OAuth2Helper *oauth2Helper;

@property(strong,nonatomic) NSMutableArray *dataarray;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation ViewController

#pragma mark - LazyLoad
-(NSMutableArray *)dataarray{
    if(_dataarray == nil){
        _dataarray = [NSMutableArray array];
    }
    return _dataarray;
}
-(OAuth2Helper *)oauth2Helper{
    if(_oauth2Helper == nil){
        _oauth2Helper = [[OAuth2Helper alloc] init];
        _oauth2Helper.delegate = self;
    }
    return _oauth2Helper;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    ((AppDelegate *) [UIApplication sharedApplication].delegate).oauth2Helper = self.oauth2Helper;
}

- (IBAction)click:(id)sender {
    [self.oauth2Helper openLoginUrl];
}
- (IBAction)clickUserInfo:(UIButton *)sender {

    [self.oauth2Helper pullUserInfoWithToken];
}

- (IBAction)getRepositorylist:(id)sender {
    [self.oauth2Helper RepositoryList];
}


#pragma mark - OAuth2HelperDelegate
- (void)pullUserInfo{

    [self.oauth2Helper pullUserInfoWithToken];
}

- (void)displayUserInfo:(id)userInfo{

    NSLog(@"Joker number is %@",userInfo);
    [self.texttv setText:[NSString stringWithFormat:@"%@",userInfo]];
}
- (void)refreshList:(id)userInfo{
    self.dataarray = userInfo;
    [self.tableview reloadData];

}
#pragma mark - TableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataarray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserRepositoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil){
        cell =(UserRepositoryCell *) [[UserRepositoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
  [cell setRepositoryInfo:((Repository *)self.dataarray[indexPath.row])];
    


    return cell;
}

@end
