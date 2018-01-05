//
//  GangPomeloManager.h
//  PomeloTe
//
//  Created by codone on 2017/8/1.
//  Copyright © 2017年 qm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GangPomeloManager : NSObject

///连接成功
@property BOOL isConnected;

+ (instancetype)instanceManager;

/**
 连接
 */
- (void)connectToHostForUserid:(NSString*)userid withUsername:(NSString*)username withRid:(NSString*)rid withParams:(NSDictionary *)params suc:(void(^)(void))success fail:(void(^)(void))failure;

/**
 进入社群频道
 */
- (void)joinGang;

/**
 离开社群频道
 */
- (void)leaveGang;

/**
 断开
 */
- (void)disconnectWithCallBack:(void (^)(void))callBack;

/**
 发送
 */
- (void)sendMessageDic:(NSDictionary*)message suc:(void(^)(id arg))success fail:(void(^)(NSError *error))failure;

/**
 请求
 */
- (void)notifyWithRoute:(NSString *)route andParams:(NSDictionary *)params suc:(void(^)(void))success fail:(void(^)(void))failure;

/**
 添加监听
 */
- (void)addRoute:(NSString*)route receiveBlock:(void(^)(id message))receive;

/**
 删除监听
 */
- (void)removeRoute:(NSString*)route;

/**
 监听收到消息
 */
- (void)addOnChatRouteWithBlock:(void (^)(id))receive;

@end
