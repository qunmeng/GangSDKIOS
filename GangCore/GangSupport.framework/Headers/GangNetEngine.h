//
//  GangNetEngine.h
//  GangSDKDemo
//
//  Created by codone on 2017/7/31.
//  Copyright © 2017年 codone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GangNetEngine : NSObject
//post
+(void)postToPath:(NSString *)path withParams:(NSDictionary *)params withMappingClassName:(NSString *)className whenSuccess:(void (^)(id result))success whenFailure:(void (^)(NSError *error))fail;
+(void)postToPath:(NSString *)path withParams:(NSDictionary *)params encode:(BOOL)encode withMappingClassName:(NSString*)className whenSuccess:(void (^)(id result))success whenFailure:(void (^)(NSError *error))fail;
+(void)postToPath:(NSString *)path appendBaseUrl:(BOOL)append withParams:(NSDictionary *)params encode:(BOOL)encode withMappingClassName:(NSString*)className whenSuccess:(void (^)(id result))success whenFailure:(void (^)(NSError *error))fail;
//upload
+(void)uploadToPath:(NSString *)path params:(NSDictionary *)params addBodyData:(NSData*)data withName:(NSString*)fileName mimeType:(NSString*)mimeType withMappingObject:(NSString*)className success:(void (^)(id result))success fail:(void (^)(NSError *error))fail progress:(void(^)(double persent))progress;


/**
 加密
 @param parameters 待加密的字典
 @return 加密后的字符串
 @param key 加密key
 */
+(NSString*)encode:(NSDictionary*)parameters withKey:(NSString*)key;

/**
 解密
 @param encodedString 待解密的字符串
 @return 解密后的字典
 @param key 解密key
 */
+(NSDictionary*)decode:(NSString*)encodedString withKey:(NSString*)key;
@end
