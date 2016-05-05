//
//  OAuthHelper.h
//  GitHubClient
//
//  Created by 常琼 on 16/5/3.
//  Copyright © 2016年 臧其龙. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OAuth2HelperDelegate <NSObject>

- (void)pullUserInfo;

- (void)displayUserInfo:(id)userInfo;
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

@end
