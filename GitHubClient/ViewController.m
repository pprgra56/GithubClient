//
//  ViewController.m
//  GitHubClient
//
//  Created by 臧其龙 on 16/4/30.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "ViewController.h"
#import "OAuth2Manager.h"
#import "UserRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action Handler

- (IBAction)handleOpenSafari:(id)sender
{
    [OAuth2Manager openSafariToLogin];
}

- (IBAction)fetchUserFromRequest:(id)sender
{
    UserRequest *request = [[UserRequest alloc] init];
    [request startWithFinishedBlock:^(NSError *error, id result) {
        NSLog(@"error is %@,result is %@",error,result);
    }];
}

@end
