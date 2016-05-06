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

@interface ViewController ()<OAuth2HelperDelegate>

@property (weak, nonatomic) IBOutlet UITextView *texttv;

@property(strong,nonatomic) OAuth2Helper *oauth2Helper;
@end

@implementation ViewController

#pragma mark - LazyLoad
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



#pragma mark - OAuth2HelperDelegate
- (void)pullUserInfo{

    [self.oauth2Helper pullUserInfoWithToken];
}

- (void)displayUserInfo:(id)userInfo{

    NSLog(@"Joker number is %@",userInfo);
    [self.texttv setText:[NSString stringWithFormat:@"%@",userInfo]];
}
@end
