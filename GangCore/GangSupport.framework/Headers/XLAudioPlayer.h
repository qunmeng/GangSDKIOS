//
//  XLAudioPlayer.h
//  XLAudioDemo
//
//  Created by zbf on 2017/8/17.
//  Copyright © 2017年 xuelang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^XLAudioPlayerPlayFinishedBlock)(void);

@interface XLAudioPlayer : NSObject

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithURLString:(NSString *)urlString;

- (instancetype)initWithURLString:(NSString *)urlString finished:(XLAudioPlayerPlayFinishedBlock)finished;

- (void)play;

- (void)stop;

@end
