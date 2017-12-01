//
//  GangUserBean.h
//  GangSDK
//
//  Created by codone on 2017/8/11.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseBean.h"
#import "GangPositionListBean.h"

@class GangUserBeanData;
@interface GangUserBean : GangBaseBean
@property(strong) GangUserBeanData *data;
@end

@interface GangUserBeanData : NSObject
@property(strong) NSString *gameid;                                 /**<应用的唯一标识符*/
@property(strong) NSString *userid;                                 /**<GangSDK中的用户id*/
@property(strong) NSString *gameuserid;                             /**<接入应用中的用户唯一标识符*/
@property(strong) NSString *nickname;                               /**<用户昵称*/
@property(strong) NSString *laststlogintime;                        /**<最后登录时间*/
@property(strong) NSString *iconurl;                                /**<用户头像*/
@property(strong) NSString *consortiaid;                            /**<社群id,为nil则表示还没有加入社群*/
@property(strong) NSDictionary *ext;                                /**<用户额外信息*/
@property(assign) BOOL taskfinished;                                /**<任务是否完成*/
@property(assign) BOOL hasvisited;                                  /**<是否有公会邀请*/

@property(assign) NSInteger roleid;                                 /**<成员职务id*/
@property(strong) NSString *rolename;                               /**<成员职务*/
@property(assign) NSInteger rolelevel;                              /**<职位*/
@property(assign) NSInteger activenum;                              /**<活跃值*/
@property(assign) NSInteger contributenum;                          /**<贡献值*/
@property(assign) NSInteger weekcontributenum;                      /**<周贡献值*/
@property(assign) BOOL isonline;                                    /**<是否在线*/
@property(assign) NSInteger lastlogintime;                          /**<最近上线时间时间戳(单位:毫秒)*/
@property(strong) NSArray<GangPositionListBeanDataItem*> *rolelist; /**<社群角色设置*/

#pragma 禁言
@property(assign) BOOL isforbiddenspeak;                            /**<是否被禁言了*/
@property(strong) NSString *blacklistid;                            /**<禁言列表id*/
@property(strong) NSString *stopspeakinfo;                          /**<被禁言原因*/
@property(assign) NSInteger keeptime;                               /**<被禁言的时间*/
@property(assign) NSInteger overtime;                               /**<禁言到期时间戳(单位:毫秒)*/

#pragma 申请人相关
@property(strong) NSString *applicationid;                          /**<申请id*/
@property(strong) NSString *note;                                   /**<备注*/
@property(strong) NSString *createtime;                             /**<被禁言时间戳(单位:毫秒)*/
@property(assign) NSInteger status;                                 /**<状态：0-邀请；1-通过；2-拒绝*/
@property(assign) NSInteger gamelevel;                              /**<用户游戏等级*/
@property(strong) NSString *gamerole;                               /**<用户游戏角色*/

#pragma 社群相关
@property(strong) NSString *consortianame;                          /**<社群名称*/
@property(strong) NSString *consortiaiconurl;                       /**<社群图标*/
@property(strong) NSString *consortiaactivelevel;                   /**<社群活跃等级*/
@property(strong) NSString *consortiabuildlevel;                    /**<社群等级*/

@end
