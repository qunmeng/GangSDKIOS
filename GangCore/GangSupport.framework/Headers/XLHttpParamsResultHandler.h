//
//  Header.h
//  XLHttpClient
//
//  Created by zbf on 2017/8/1.
//  Copyright © 2017年 xuelang. All rights reserved.
//

#ifndef XLHttpParamsResultHandler_h
#define XLHttpParamsResultHandler_h

#import <Foundation/Foundation.h>

@protocol XLHttpParamsResultHandler <NSObject>

@optional

- (id)handlerResult:(NSData *)result error:(NSError **)error;

- (NSDictionary *)handlerParams:(NSDictionary *)params error:(NSError **)error;

@end

#endif /* Header_h */
