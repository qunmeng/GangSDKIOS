//
//  XLHttpCommon.h
//  XLHttpClient
//
//  Created by zbf on 2017/7/31.
//  Copyright © 2017年 xuelang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLHttpParamsResultHandler.h"

@interface XLHttpCommon : NSObject

/**
 *  默认是 60s
 */
@property (nonatomic) NSTimeInterval timeout;

/**
 *  公共参数，默认nil
 */
@property (nonatomic, strong, nullable) NSDictionary *commonParams;

/**
 *  参数加密，如果XLHttpClient.dataHandler为nil将使用此值，默认nil
 */
@property (nonatomic, strong, nullable) id<XLHttpParamsResultHandler> paramsResultHandler;

/**
 *  单例对象
 *
 *  @return 单例对象
 */
+ (XLHttpCommon * _Nonnull)sharedInstance;

/**
 *  不可用
 *
 *  @return 不可用
 */
- (instancetype _Nonnull)init NS_UNAVAILABLE;

@end
