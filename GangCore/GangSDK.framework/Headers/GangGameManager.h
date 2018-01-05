//
//  GangGameManager.h
//  GangSDK
//
//  Created by codone on 2017/12/6.
//  Copyright © 2017年 qm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GangGameListBean.h"

@interface GangGameManager : NSObject
+ (instancetype _Nullable)instance;
- (instancetype _Nullable)init NS_UNAVAILABLE;

#pragma mark - 推荐应用相关操作

/**
 *  获取推荐应用的列表
 */
- (void)getGameList:(void (^_Nullable)(GangGameListBean *_Nullable data))success
            failure:(void (^_Nullable)(NSError * _Nullable error))failure;

@end
