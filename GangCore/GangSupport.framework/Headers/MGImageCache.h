//
//  MGImageCache.h
//  ImageResizeDemo
//
//  Created by ZhangBinfeng on 15/10/20.
//  Copyright © 2015年 ZhangBinfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FICEntity;

typedef void(^MGGetImageBlock)(UIImage *image);

typedef void(^MGGetImageEntityBlock)(UIImage *image, id<FICEntity> entity);

@interface MGImageCache : NSCache

+ (void)cacheDataToDisk:(NSData *)data forURLString:(NSString *)urlString;

+ (BOOL)isCachedToDiskWithURLString:(NSString *)urlString;

+ (void)cacheImageToMemmary:(UIImage *)image forURLString:(NSString *)urlString;

+ (void)removeImageForURLString:(NSString *)urlString removeDisk:(BOOL)removeDisk;

+ (void)removeAllImageFromMemory;

+ (void)removeAllImageFromMemoryAndDisk;

+ (void)removeAllImageFromDisk;

+ (void)getImageWithURLString:(NSString *)urlString finished:(MGGetImageBlock)finished;

+ (BOOL)getImageWithURLString:(NSString *)urlString FICEntity:(id<FICEntity>)entity finished:(MGGetImageEntityBlock)finished;

+ (NSData *)getImageDataWithURLString:(NSString *)urlString;

+ (NSInteger)getSize;

@end
