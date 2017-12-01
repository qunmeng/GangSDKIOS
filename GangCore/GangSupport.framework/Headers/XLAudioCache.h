//
//  XLAudioCache.h
//  XLAudioDemo
//
//  Created by zbf on 2017/8/28.
//  Copyright © 2017年 xuelang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLAudioCache : NSObject

+ (NSString *)getVoicePath:(NSString *)urlstr;

+ (NSUInteger)getSize;

+ (void)removeAllCache;

+ (void)removeCache:(NSString *)urlstr;

@end
