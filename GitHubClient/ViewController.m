//
//  ViewController.m
//  GitHubClient
//
//  Created by 臧其龙 on 16/4/30.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()


@end

@implementation ViewController

- (IBAction)click:(id)sender {
    UIApplication *application =  [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:@"https://github.com/login/oauth/authorize?client_id=b3eb1dd9811e58d681a0&scope=user&redirect_uri=pprgra56://"];
    [application openURL:url];
    AppDelegate *delegate =(AppDelegate *) application.delegate;



    delegate.v1 = self;


}




@end
