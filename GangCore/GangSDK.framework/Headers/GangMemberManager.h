//
//  GangMemberManager.h
//  GangSDK
//
//  Created by codone on 2017/10/30.
//  Copyright © 2017年 qm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GangUserBean.h"

@interface GangMemberManager : NSObject
+ (instancetype _Nonnull)instance;
- (instancetype _Nullable)init NS_UNAVAILABLE;

#pragma mark - 社群成员相关操作

/**
 *  获取成员信息
 *  @param  targetuserid  成员id
 */
- (void)getGangMemeberInfoWithTargetUserid:(NSString*_Nonnull)targetuserid
                                   success:(void (^_Nullable)(GangUserBean *_Nullable data))success
                                      fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  邀请加入社群
 *  @param  nickname  被邀请的用户昵称
 */
- (void)inviteMemberWithNickname:(NSString *_Nonnull)nickname
                         success:(void (^_Nullable)(id _Nullable data))success
                            fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  社群管理转让
 *  @param  targetuserid  接受转让的用户id
 */
- (void)transferGangOwnerWithTargetUserid:(NSString*_Nonnull)targetuserid
                                  success:(void (^_Nullable)(GangBaseBean *_Nullable data))success
                                  failure:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  修改社群成员职位
 *  @param  targetuserid  用户id
 *  @param  roleid        职位类型
 */
- (void)modifyMemberRoleWithTargetUserid:(NSString *_Nonnull)targetuserid
                                  roleid:(NSInteger)roleid
                                 success:(void (^_Nullable)(GangBaseBean * _Nullable data))success
                                    fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  禁言
 *  @param  targetuserid  需要禁言的用户id
 *  @param  reason        禁言的理由
 *  @param  seconds       禁言的时长(单位:秒，-1代表永久禁言)
 */
- (void)muteMemberWithTargetUserid:(NSString *_Nonnull)targetuserid
                        withReason:(NSString*_Nullable)reason
                          keepTime:(NSInteger)seconds
                           success:(void (^_Nullable)(GangBaseBean * _Nullable data))success
                              fail:(void (^_Nullable)(NSError * _Nullable error))failure;
/**
 *  解除禁言
 *  @param  targetuserid  解禁用户id
 */
- (void)cancelMuteMemberWithTargetUserid:(NSString *_Nonnull)targetuserid
                                 success:(void (^_Nullable)(GangBaseBean * _Nullable))success
                                    fail:(void (^_Nullable)(NSError * _Nullable))failure;

/**
 *  踢出社群
 *  @param  targetuserid  被踢的用户id
 */
- (void)kickOutMemberWithTargetUserid:(NSString*_Nonnull)targetuserid
                              success:(void (^_Nullable)(GangBaseBean * _Nullable data))success
                              failure:(void (^_Nullable)(NSError * _Nullable error))failure;
@end
