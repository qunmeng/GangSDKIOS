//
//  GangSettingBean.h
//  GangSDK
//
//  Created by codone on 2017/8/10.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseBean.h"

@interface GangConfigListBean : NSObject
@property(assign) int world_channel_speak_time;                  /**<招募频道发言间隔*/
@property(assign) int consortia_auto_dissolved_min_usernum;      /**<新创建社群人数太少强制解散人数*/
@property(assign) int consortia_auto_dissolved_min_days;         /**<新创建社群人数太少强制解散时长(天)*/
@property(assign) int consortia_auto_dissolved_flag;             /**<新创建社群人数太少强制解散开关*/
@property(assign) int is_use_emergence_function_flag;            /**<是否开机紧急事件*/
@property(assign) int is_use_callup_function_flag;               /**<召集令开关是否开启*/
@property(assign) int consortia_kick_chairman_flag;              /**<系统自动罢免管理员*/
@property(assign) int consortia_modify_nickname_time_interval;   /**<社群改名cd*/
@property(assign) int consortia_kick_chairman_min_days;          /**<系统自动罢免管理员时间*/
@property(assign) int left_and_join_consortia_time_interval;     /**<退出后加入新社群的时间间隔*/
@property(assign) int left_consortia_contribution_clean;         /**<退出社群贡献清零开关*/
@property(strong) NSArray *speak_forbbiden_time_list;            /**<禁言时长(单位:秒)选项,NSInteger类型*/
@property(strong) NSArray<NSString*> *consortia_icons;                      /**<创建社群图标选项*/
@property(assign) int speak_task_num;                            /**<在线任务时长*/
@property(assign) BOOL user_icon_is_allow_update;                /**<是否允许修改头像*/
@property(strong) NSString *client_key;                          /**<加密key*/
@end

@interface GangPromptListBean : NSObject
@property(strong) NSString *consortia_contribute;                /**<捐献与贡献换算提示信息*/
@property(strong) NSString *add_member;                          /**<添加成员后提示信息*/
@property(strong) NSString *left_consortia;                      /**<退出社群后提示信息*/
@property(strong) NSString *stop_speak;                          /**<禁言提示信息*/
@property(strong) NSString *modify_position;                     /**<修改职位提示信息*/
@property(strong) NSString *modify_user_icon;                    /**<修改头像提示信息*/
@property(strong) NSString *modify_consortia_icon;               /**<修改社群图标提示信息*/
@property(strong) NSString *modify_consortia_name;               /**<修改社群名称提示信息*/
@property(strong) NSString *kick_user;                           /**<踢人提示信息*/
@property(strong) NSString *change_master;                       /**<转让管理员提示信息*/
@property(strong) NSString *consortia_up_level;                  /**<升级提示信息*/
@property(strong) NSString *disovle_consortia;                   /**<解散社群提示信息*/
@property(strong) NSString *create_consortia;                    /**<创建社群提示信息*/
@end

@interface GangVariableListBean : NSObject
@property(strong) NSString *gangname;                             /**<社群别称*/
@property(strong) NSString *gangowner;                            /**<管理员别称*/
@property(strong) NSString *nickname;                             /**<昵称*/
@property(strong) NSString *moneyname;                            /**<金币别称*/
@end

@interface GangLevelListBean : NSObject
@property(assign) int buildlevel;                                  /**<等级*/
@property(assign) int needbuildnum;                                /**<需要的建设值*/
@property(assign) int maxnum;                                      /**<最大人数*/
@property(assign) int costnum;                                     /**<花费*/
@end

@interface GangSettingBeanData : NSObject
@property(strong) NSString *updatetime;
@property(strong) GangConfigListBean *gameconfig;                   /**<配置信息*/
@property(strong) GangPromptListBean *gameprompt;                   /**<提示信息*/
@property(strong) GangVariableListBean *gamevariable;               /**<变量信息*/
@property(strong) NSArray<GangLevelListBean *> *consortialevellist; 
@end

@interface GangSettingBean : GangBaseBean
@property(strong) GangSettingBeanData *data;
@end

