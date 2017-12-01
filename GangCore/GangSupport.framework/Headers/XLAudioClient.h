//
//  XLAudioClient.h
//  XLAudioDemo
//
//  Created by zbf on 2017/8/16.
//  Copyright © 2017年 xuelang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^XLAudioPlayFinishedBlock)(void);

@interface XLAudioClient : NSObject
@property(strong) NSString *url_holder;

+ (XLAudioClient *)sharedInstance;

- (void)play:(NSString *)urlString;

- (void)play:(NSString *)urlString finished:(XLAudioPlayFinishedBlock)finished;

- (void)stop:(NSString *)urlString;

- (BOOL)isPlaying:(NSString *)urlString;

- (void)stopAll;

@end
