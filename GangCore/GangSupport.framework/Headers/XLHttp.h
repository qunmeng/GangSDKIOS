//
//  XLHttpClient.h
//  XLHttpClient
//
//  Created by zbf on 2017/7/31.
//  Copyright © 2017年 xuelang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XLUploadFile.h"
#import "XLHttpCommon.h"
#import "XLHttpParamsResultHandler.h"

/**
 *  请求完成回调
 *
 *  @param result 服务器返回的结果
 *                XLHttpClient.dataHandler或者XLHttpCommon.dataHandler不为nil，将返回dataHandler处理后的对象
 *                否则直接返回NSData
 *  @param error  错误信息
 */
typedef void(^XLHttpFinishedBlock)(id _Nullable result, NSError * _Nullable error);

/**
 *  下载文件完成回调
 *
 *  @param fileUrl 文件暂存路径，block返回之后暂存文件会删除
 *  @param error   错误信息
 */
typedef void(^XLHttpDownloadFinishedBlock)(NSURL * _Nullable fileUrl, NSError * _Nullable error);

/**
 *  上传文件进度回调
 *
 *  @param progress 进度
 */
typedef void(^XLHttpProgressBlock)(double progress);

/**
 *  网络请求类
 */
@interface XLHttpClient : NSObject

/**
 *  参数or数据处理，默认nil
 */
@property (nonatomic, strong, nullable) id<XLHttpParamsResultHandler> paramsResultHandler;

/**
 *  是否使用XLHttpCommon所配置的相关参数和工具，sharedInstance默认为YES，默认值为NO
 *  即使此值为YES，依然优先使用本类配置的参数及工具，只有本类相关参数及工具为nil时才会使用XLHttpCommon所配置的相关参数和工具
 */
@property (nonatomic, getter=isUseCommon) BOOL useCommon;

/**
 *  默认是 NSURLRequestUseProtocolCachePolicy
 */
@property (nonatomic) NSURLRequestCachePolicy cachePolicy;

/**
 *  初始化
 *
 *  @return 对象
 */
- (instancetype _Nonnull )init;

/**
 *  单例实例
 *
 *  @return 单例对象
 */
+ (XLHttpClient * _Nonnull)sharedInstance;

/**
 *  发送POST请求
 *
 *  @param urlString 请求地址
 *  @param params    请求参数
 *  @param finished  请求完成后的回调  @link XLHttpFinishedBlock
 */
- (void)postWithURLString:( NSString * _Nonnull)urlString
                   params:(NSDictionary * _Nullable)params
                 finished:(XLHttpFinishedBlock _Nullable)finished;

/**
 *  发送POST请求
 *
 *  @param urlString 请求地址
 *  @param params    请求参数
 *  @param async     是否异步
 *  @param timeout   超时时间
 *  @param finished  请求完成后的回调 @link XLHttpFinishedBlock
 */
- (void)postWithURLString:(NSString * _Nonnull)urlString
                   params:(NSDictionary * _Nullable)params
                    async:(BOOL)async
                  timeout:(NSTimeInterval)timeout
                 finished:(XLHttpFinishedBlock _Nullable)finished;

/**
 *  POST上传文件
 *
 *  @param urlString       请求地址
 *  @param params          请求参数
 *  @param file            文件信息
 *  @param uploadProgress  上传进度回调       @link XLHttpProgressBlock
 *  @param finished        请求完成后的回调    @link XLHttpFinishedBlock
 */
- (void)uploadFileWithURLString:(NSString * _Nonnull)urlString
                         params:(NSDictionary * _Nullable)params
                           file:(XLUploadFile * _Nonnull)file
                 uploadProgress:(XLHttpProgressBlock _Nullable)uploadProgress
                       finished:(XLHttpFinishedBlock _Nullable)finished;

/**
 *  POST下载文件
 *
 *  @param urlString         请求地址
 *  @param params            请求参数
 *  @param downloadProgress  下载进度回调     @link XLHttpProgressBlock
 *  @param finished          请求完成后的回调  @link XLHttpFinishedBlock
 */
- (void)downloadFileWithURLString:(NSString * _Nonnull)urlString
                           params:(NSDictionary * _Nullable)params
                 downloadProgress:(XLHttpProgressBlock _Nullable)downloadProgress
                         finished:(XLHttpDownloadFinishedBlock _Nullable)finished;

@end


