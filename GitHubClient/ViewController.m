//
//  ViewController.m
//  GitHubClient
//
//  Created by 臧其龙 on 16/4/30.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "OAuthHelper.h"

@interface ViewController ()


@end

@implementation ViewController
-(void)viewDidLoad{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayResult:) name:@"NTRESULT" object:nil];
}
- (IBAction)click:(id)sender {
    [OAuthHelper getCode];
}
-(void)displayResult:(NSNotification *)noti{
    NSDictionary *dic = (NSDictionary *)noti.userInfo;
    [self.texttv setText:[NSString stringWithFormat:@"%@",dic[@"key"]]];

}

@end
