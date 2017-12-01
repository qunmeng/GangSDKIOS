//
//  MGWebImageTools.h
//  MGWebImage
//
//  Created by zbf on 16/5/24.
//  Copyright © 2016年 com.mg. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MGWebImageProgressStyle) {
    //main style
    MGWebImageProgressStyleNone = 1<<31,
    MGWebImageProgressStylePie = 1<<0,
    MGWebImageProgressStyleRing = 1<<1,
    MGWebImageProgressStyleSegment = 1<<2,
    MGWebImageProgressStyleImage = 1<<3,
    
    //sub style
    MGWebImageProgressStyleIndeterminate = 1<<4,//适用于 Pie Ring Segment
    MGWebImageProgressStylePercent = 1<<5,//适用于 Ring Segment
    MGWebImageProgressStyleBackground = 1<<6,//适用于 Image
    MGWebImageProgressStyleFromTop = 1<<7,//适用于 Image
    MGWebImageProgressStyleFromBottom = 1<<8,//适用于 Image
    MGWebImageProgressStyleFromLeft = 1<<9,//适用于 Image
    MGWebImageProgressStyleFromRight = 1<<10,//适用于 Image
};

@interface MGWebImageCommon : NSObject

+ (BOOL)fastImageCacheEnabled;

+ (void)setFastImageCacheEnabled:(BOOL)enabled;

+ (UIColor *)progressPrimaryColor;

+ (void)setProgressPrimaryColor:(UIColor *)color;

+ (UIColor *)progressSecondaryColor;

+ (void)setProgressSecondaryColor:(UIColor *)color;

+ (MGWebImageProgressStyle)progressStyle;

+ (void)setProgressStyle:(MGWebImageProgressStyle)progressStyle;

@end
