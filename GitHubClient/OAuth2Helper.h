//
//  OAuthHelper.h
//  GitHubClient
//
//  Created by 常琼 on 16/5/3.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const GithubLoginUrl;
FOUNDATION_EXPORT NSString *const GithubTokenUrl;
FOUNDATION_EXPORT NSString *const GithubCodeUrl;
FOUNDATION_EXPORT NSString *const CLIENT_ID;
FOUNDATION_EXPORT NSString *const client_secret;
FOUNDATION_EXPORT NSString *const SCOPE;
FOUNDATION_EXPORT NSString *const REDIRECT_URI;
FOUNDATION_EXPORT NSString *const RepositoryList_Url;


@protocol OAuth2HelperDelegate <NSObject>

- (void)pullUserInfo;

- (void)displayUserInfo:(id)userInfo;

- (void)refreshList:(id)userInfo;
@end


@interface OAuth2Helper : NSObject



@property(strong,nonatomic) id <OAuth2HelperDelegate> delegate;



/**
 *  打开登录页
 */
- (void)openLoginUrl;

/**
 *  获取code
 */
- (void)getCodeFromUrl:(NSURL *)url;


/**
 *  发送token
 *
 *  @param token
 */
- (void)pullUserInfoWithToken;


/**
 *  获取库列表
 */
- (void)RepositoryList;

@end
