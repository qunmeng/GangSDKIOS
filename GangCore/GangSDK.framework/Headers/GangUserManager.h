//
//  GangUserManager.h
//  GangSDK
//
//  Created by codone on 2017/10/30.
//  Copyright © 2017年 qm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GangUserBean.h"
#import "GangUploadBean.h"
#import "GangInfoBean.h"
#import "GangQueryListBean.h"
#import "GangMessageListBean.h"
#import "GangGoodsListBean.h"

@interface GangUserManager : NSObject
+ (instancetype _Nullable)instance;
- (instancetype _Nullable)init NS_UNAVAILABLE;

#pragma mark - 自己相关操作

/**
 *  根据接入应用中的gameuserid获取成员信息
 *  @param  gameuserid  接入应用中的用户唯一标识符
 */
- (void)getGangUserInfoWithTargetGameUserid:(NSString*_Nonnull)gameuserid
                                    success:(void (^_Nullable)(GangUserBean *_Nullable data))success
                                       fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  获取申请加入的社群列表
 */
- (void)getGangApplyList:(void (^_Nullable)(GangQueryListBean *_Nullable data))success
                 failure:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  获取社群加入邀请列表
 */
- (void)getGangInviteList:(void (^_Nullable)(GangQueryListBean *_Nullable data))success
                  failure:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  获取通知消息列表
 *  @param  pageNum   分页
 *  @param  pageSize  每页条数
 */
- (void)getMessageNotificationList:(int)pageNum
                          pageSize:(int)pageSize
                           success:(void (^_Nullable)(GangMessageListBean *_Nullable data))success
                           failure:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  获取购买商品列表
 */
- (void)getPayConfigInfo:(void (^_Nullable)(GangGoodsListBean *_Nullable data))success
                 failure:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  生成支付订单
 *  @param  productid  商品id
 */
- (void)createPayOrder:(NSString*_Nonnull)productid
               costnum:(NSString *_Nonnull)costnum
               paytype:(int)paytype
               success:(void (^_Nullable)(id _Nullable))success
                  fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  修改昵称
 *  @param nickname  要设置的用户名
 */
- (void)updateNickname:(NSString *_Nonnull)nickname
               success:(void (^_Nullable)(GangBaseBean *_Nullable data))success
               failure:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  修改头像
 *  @param data      图片数据
 *  @param progress  上传进度
 */
- (void)updateHeadIcon:(NSData *_Nonnull)data
               success:(void (^_Nullable)(GangUploadBean *_Nullable data))success
                  fail:(void (^_Nullable)(NSError * _Nullable error))failure
              progress:(void (^_Nullable)(double percent))progress;

/**
 *  申请加入社群
 *  @param  consortiaid  社群id
 */
- (void)applyJoinGangWithConsortiaid:(NSString *_Nonnull)consortiaid
                             success:(void (^_Nullable)(GangInfoBean *_Nullable data))success
                                fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  取消申请加入社群
 *  @param  applicationid  申请id
 */
- (void)cancelApplyJoinGangWithApplicationid:(NSString *_Nonnull)applicationid
                                     success:(void (^_Nullable)(id _Nullable data))success
                                        fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  处理社群邀请
 *  @param  visitid  邀请id
 *  @param  messageid  通知消息id
 *  @param  status  1-接受，2-拒绝
 */
- (void)dealGangInvitationWithVisitid:(NSString *_Nonnull)visitid
                            messageid:(NSString *_Nonnull)messageid
                               status:(NSInteger)status
                              success:(void (^_Nullable)(GangInfoBean *_Nullable data))success
                                 fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  标记通知消息为已读
 *  @param messageid  消息id
 */
- (void)updateMessageNotificationStateRead:(NSString *_Nonnull)messageid
                                   success:(void (^_Nullable)(GangBaseBean *_Nullable data))success
                                   failure:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  删除通知消息
 *  @param messageid  消息id
 */
- (void)deleteMessageNotification:(NSString *_Nonnull)messageid
                          success:(void (^_Nullable)(GangBaseBean *_Nullable data))success
                          failure:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 * 退出社群
 */
- (void)quitGang:(void (^_Nullable)(GangBaseBean *_Nullable data))success
         failure:(void (^_Nullable)(NSError * _Nullable error))failure;

@end
