//
//  UIImageView+MGWebLoad.h
//  ImageResizeDemo
//
//  Created by ZhangBinfeng on 15/10/20.
//  Copyright © 2015年 ZhangBinfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGImageClient.h"
#import "MGWebImageCommon.h"

@interface UIImageView (MGWebLoad)

@property (nonatomic, copy, readonly) NSString *urlString;

@property (nonatomic, strong) UIColor *progressPrimaryColor;

@property (nonatomic, strong) UIColor *progressSecondaryColor;

@property (nonatomic) MGWebImageProgressStyle progressStyle;

@property (nonatomic, strong, readonly) UIView *progressView;

@property (nonatomic, strong, readonly) MGProgressBlock progressBlock;

@property (nonatomic, strong, readonly) MGFinishedBlock finishedBlock;

@property (nonatomic) BOOL hideProgressView;

- (void)setImageWithURLString:(NSString *)urlString;

- (void)setImageWithURLString:(NSString *)urlString placeholder:(NSString *)placeholder;

- (void)setImageWithURLString:(NSString *)urlString progress:(MGProgressBlock)progress;

- (void)setImageWithURLString:(NSString *)urlString placeholder:(NSString *)placeholder progress:(MGProgressBlock)progress;

#pragma mark - SDWebImage

typedef void(^MG_SDWebImageCompletedBlock)(UIImage *image, NSError *error, NSInteger cacheType);

- (void)setImageWithURL:(NSURL *)url;

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(NSInteger)options;

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(NSInteger)options completed:(MG_SDWebImageCompletedBlock)completedBlock;

- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(MG_SDWebImageCompletedBlock)completedBlock;

@end
