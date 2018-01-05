//
//  GangSDK+Pay.h
//  GangPay
//
//  Created by codone on 2017/12/29.
//  Copyright © 2017年 qm. All rights reserved.
//

#import <GangSDK/GangSDK.h>
#import "GangPayInfo.h"

@interface GangSDK (Pay)
/**
 初始化
 @param wechatAppID 在微信申请到的appID
 @param aliScheme 用来从支付宝回调的scheme,与plist文件中注册的scheme保持一致
 */
-(void)init:(NSString *_Nonnull)wechatAppID alipay:(NSString *_Nonnull)aliScheme;

/**
 处理支付后回跳
 @param url 传递的url
 */
-(void)handleURL:(NSURL *_Nonnull)url;
@end
