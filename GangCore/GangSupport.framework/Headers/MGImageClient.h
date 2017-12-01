//
//  MGImageClient.h
//  ImageResizeDemo
//
//  Created by ZhangBinfeng on 15/10/20.
//  Copyright © 2015年 ZhangBinfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MGProgressBlock)(CGFloat progress, NSString *urlString);
typedef void(^MGFinishedBlock)(UIImage *image, NSString *urlString);
typedef void(^MGDataFinishedBlock)(NSData *data, NSString *urlString);

@interface MGImageClient : NSObject

+ (void)loadImageWithURLString:(NSString *)urlString finished:(MGFinishedBlock)finished;

+ (void)loadImageWithURLString:(NSString *)urlString progress:(MGProgressBlock)progress finished:(MGFinishedBlock)finished;

+ (void)loadImageDataWithURLString:(NSString *)urlString finished:(MGDataFinishedBlock)finished;

+ (void)loadImageDataWithURLString:(NSString *)urlString progress:(MGProgressBlock)progress finished:(MGDataFinishedBlock)finished;

@end
