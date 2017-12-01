//
//  XLUploadFile.h
//  XLHttpClient
//
//  Created by zbf on 2017/7/31.
//  Copyright © 2017年 xuelang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLUploadFile : NSObject

/**
 *  文件名
 */
@property (nonatomic, copy, nullable) NSString *fileName;

/**
 *  名称
 */
@property (nonatomic, copy, nullable) NSString *name;

/**
 *  文件类型
 *  常见的有：image/jpeg，image/png，audio/mpeg，video/mpeg，application/zip
 */
@property (nonatomic, copy, nullable) NSString *mimeType;

/**
 *  文件体
 */
@property (nonatomic, strong, nonnull) NSData *data;

@end
