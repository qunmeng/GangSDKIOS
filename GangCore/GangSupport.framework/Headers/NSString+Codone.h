//
//  NSString+CodoneMD5.h
//  WJD
//
//  Created by codone on 2017/1/11.
//  Copyright © 2017年 codone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Codone)

- (NSString *)md2;

- (NSString *)md4;

- (NSString *)md5;

- (NSString *)sha1;

- (NSString *)sha224;

- (NSString *)sha256;

- (NSString *)sha384;

- (NSString *)sha512;
@end
