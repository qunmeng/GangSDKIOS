//
//  JSONKit.h
//  viewpager
//
//  Created by Apple on 15/3/17.
//  Copyright (c) 2015年 com.test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MGJSONKitDeserializing)

- (id)MGObjectFromJSONString;
- (id)MGMutableObjectFromJSONString;

@end

@interface NSData (MGJSONKitDeserializing)

- (id)MGObjectFromJSONData;
- (id)MGMutableObjectFromJSONData;

@end
  
@interface NSString (MGJSONKitSerializing)

- (NSData *)MGJSONData;
- (NSString *)MGJSONString;

@end

@interface NSArray (MGJSONKitSerializing)

- (NSData *)MGJSONData;
- (NSString *)MGJSONString;

@end

@interface NSDictionary (MGJSONKitSerializing)

- (NSData *)MGJSONData;
- (NSString *)MGJSONString;

@end

