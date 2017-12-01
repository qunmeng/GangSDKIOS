//
//  Base64.h
//  WerewolfiPhone
//
//  Created by zbf on 16/7/4.
//  Copyright © 2016年 mg. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MGBase64 : NSObject

+ (NSString *)encode:(const uint8_t *)input length:(NSInteger)length;

+ (NSString *)encode:(NSData *)rawBytes;

+ (NSData *)decode:(const char *)string length:(NSInteger)inputLength;

+ (NSData *)decode:(NSString *)string;

@end
