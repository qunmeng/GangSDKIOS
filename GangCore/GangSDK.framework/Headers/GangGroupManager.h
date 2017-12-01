//
//  GangGroupManager.h
//  GangSDK
//
//  Created by codone on 2017/10/30.
//  Copyright © 2017年 qm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GangInfoBean.h"
#import "GangPositionListBean.h"
#import "GangUploadBean.h"
#import "GangUserListBean.h"
#import "GangMembersListBean.h"
#import "GangWorkListBean.h"
#import "GangListBean.h"
#import "GangLogListBean.h"

@interface GangGroupManager : NSObject
+ (instancetype _Nonnull)instance;
- (instancetype _Nullable)init NS_UNAVAILABLE;

#pragma mark - 社群管理相关操作

/**
 *  获取社群排行榜
 *  @param  sortType  排行榜类型(1-等级；2-人数；3-财富)
 *  @param  pageNum   分页
 *  @param  pageSize  每页条数
 */
- (void)getGangList:(NSInteger)sortType
             atPage:(int)pageNum
           pageSize:(int)pageSize
            success:(void (^_Nullable)(GangListBean *_Nullable data))success
               fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  获取社群推荐列表
 */
- (void)getGangRecommendList:(void (^_Nullable)(id _Nullable data))success
                     failure:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  社群模糊搜索列表
 *  @param  key       id/社群名称（模糊查询）
 *  @param  pageNum   分页
 *  @param  pageSize  每页条数
 */
- (void)searchGang:(NSString*_Nonnull)key
            atPage:(int)pageNum
          pageSize:(int)pageSize
           success:(void (^_Nullable)(GangListBean *_Nullable data))success
              fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  获取社群信息
 *  @param  consortiaid  社群id
 */
- (void)getGangInfoWithConsortiaid:(NSString*_Nonnull)consortiaid
                           success:(void (^_Nullable)(GangInfoBean *_Nullable data))success
                              fail:(void (^_Nullable)(NSError  * _Nullable error))failure;

/**
 *  获取社群入会申请列表
 *  @param  endTime   分页  起始时间戳，获取第一页为 @""
 *  @param  pageSize  每页条数
 */
- (void)getMemberApplicationList:(NSString *_Nullable)endTime
                        pageSize:(int)pageSize
                         success:(void (^_Nullable)(GangUserListBean *_Nullable data))success
                            fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  获取成员列表
 *  @param  pageNum   分页
 *  @param  pageSize  每页条数
 */
- (void)getGangMembers:(int)pageNum
              pageSize:(int)pageSize
               success:(void (^_Nullable)(GangMembersListBean *_Nullable data))success
                  fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  获取成员排行榜
 *  @param  sortType  排行榜类型(1-贡献；2-活跃)
 *  @param  pageNum   分页
 *  @param  pageSize  每页条数
 */
- (void)getMemberList:(NSInteger)sortType
               atPage:(int)pageNum
             pageSize:(int)pageSize
              success:(void (^_Nullable)(GangUserListBean *_Nullable data))success
                 fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  社群成员模糊搜索
 *  @param  nickname  查询名字
 *  @param  pageNum   分页
 *  @param  pageSize  每页条数
 */
- (void)searchGangMember:(NSString *_Nonnull)nickname
                  atPage:(int)pageNum
                pageSize:(int)pageSize
                 success:(void (^_Nullable)(GangUserListBean *_Nullable data))success
                    fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  获取禁言列表
 *  @param  endTime   分页  起始时间戳，获取第一页为 @""
 *  @param  pageSize  每页条数
 */
- (void)getGangMuteMemberList:(NSString*_Nonnull)endTime
                     pageSize:(int)pageSize
                      success:(void (^_Nullable)(GangUserListBean *_Nullable data))success
                         fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  获取任务列表
 */
- (void)getGangTaskList:(void (^_Nullable)(GangWorkListBean *_Nullable data))success
                   fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  获取社群日志
 *  @param  endTime   分页  起始时间戳，获取第一页为 @""
 * @param  pageSize  每页条数
 */
- (void)getGangLogList:(NSString *_Nonnull)endTime
              pageSize:(int)pageSize
               success:(void (^_Nullable)(GangLogListBean *_Nullable data))success
                  fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  获取社群职位和权限
 */
- (void)getGangRoleAndAccess:(void (^_Nullable)(GangPositionListBean *_Nullable data))success
                        fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  创建社群
 *  @param  consortianame  社群名称
 *  @param  iconurl        社群图标
 *  @param  declaration    社群宣言
 */
- (void)createGangWithConsortianame:(NSString*_Nullable)consortianame
                            iconurl:(NSString *_Nullable)iconurl
                        declaration:(NSString *_Nullable)declaration
                            success:(void (^_Nullable)(GangInfoBean *_Nullable data))success
                               fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 * 修改社群名称
 *  @param  gangname  要设置的新的社群名
 */
- (void)updateGangName:(NSString *_Nonnull)gangname
               success:(void (^_Nullable)(GangBaseBean *_Nullable data))success
               failure:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  修改社群图标
 *  @param  fileData  图标数据
 *  @param  progress  上传进度
 */
- (void)updateGangIcon:(NSData *_Nonnull)fileData
               success:(void (^_Nullable)(GangUploadBean *_Nullable data))success
                  fail:(void (^_Nullable)(NSError * _Nullable error))failure
              progress:(void (^_Nullable)(double percent))progress;

/**
 * 修改社群宣言
 *  @param  decalaration  宣言
 */
- (void)updateGangDecalaration:(NSString *_Nonnull)decalaration
                       success:(void (^_Nullable)(GangBaseBean *_Nullable data))success
                       failure:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  修改社群职位名称
 *  @param  rolename   新的职位名称
 *  @param  roleid     职位id
 */
- (void)updateGangRoleName:(NSString *_Nonnull)rolename
                    roleid:(NSInteger)roleid
                   success:(void (^_Nullable)(GangBaseBean *_Nullable data))success
                      fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  修改社群职位对应的权限
 *  @param  jsonRights  权限设置的json格式字符串
 */
- (void)changeGangApproveSwitch:(NSString *_Nonnull )jsonRights
                        success:(void (^_Nullable)(GangBaseBean *_Nullable data))success
                           fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  发布公告
 *  @param  content  要发布的公告内容
 */
- (void)publishGangTips:(NSString *_Nonnull)content
                success:(void (^_Nullable)(GangBaseBean *_Nullable data))success
                failure:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  社群捐献
 *  @param  contributenum  捐献数量
 */
- (void)donateToGangWithContributeNum:(NSInteger)contributenum
                              success:(void (^_Nullable)(GangBaseBean *_Nullable data))success
                                 fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  社群升级
 */
- (void)improveGangLevel:(void (^_Nullable)(GangBaseBean *_Nullable data))success
                 failure:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  社群入会审批开关
 *  @param  status  开关状态
 */
- (void)changeGangApplySwitch:(BOOL)status
                      success:(void (^_Nullable)(GangBaseBean *_Nullable data))success
                      failure:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  审批加入社群申请
 *  @param  applicationid  申请id
 *  @param  status         状态：1-通过；2-拒绝
 */
- (void)acceptApplicationOfUserWithId:(NSString *_Nonnull)applicationid
                               status:(int)status
                              success:(void (^_Nullable)(GangBaseBean *_Nullable data))success
                                 fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  做社群任务
 *  @param  tasktype  任务类型
 *  @param  taskid    任务id
 */
- (void)dealTask:(NSInteger)tasktype
          taskid:(NSInteger)taskid
         success:(void (^_Nullable)(GangBaseBean *_Nullable data))success
            fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  解散社群
 */
- (void)dissolvedGang:(void (^_Nullable)(GangBaseBean *_Nullable data))success
              failure:(void (^_Nullable)(NSError * _Nullable error))failure;

@end
