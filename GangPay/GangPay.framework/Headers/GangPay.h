//
//  GangPay.h
//  GangPay
//
//  Created by codone on 2017/12/27.
//  Copyright © 2017年 qm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GangPayInfo.h"

@interface GangPay : NSObject

+(instancetype _Nonnull)instance;


/**
 初始化
 @param wechatAppID 在微信申请到的appID
 @param aliScheme 用来从支付宝回调的scheme,与plist文件中注册的scheme保持一致
 */
+(void)init:(NSString *_Nonnull)wechatAppID alipay:(NSString *_Nonnull)aliScheme;

/**
 处理支付后回跳
 @param url 传递的url
 */
+(void)handleURL:(NSURL *_Nonnull)url;

/**
 跳转到微信支付
 @param payInfo 传入购买信息
 */
+ (void)showWechatPay:(GangPayInfo *_Nonnull)payInfo
              success:(void (^_Nullable)(void))success
                 fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 跳转到aliPay
 @param payInfo 传入购买信息
 */
+ (void)showAliPay:(GangPayInfo *_Nonnull)payInfo
           success:(void (^_Nullable)(void))success
              fail:(void (^_Nullable)(NSError * _Nullable error))failure;

@end
