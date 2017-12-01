//
//  GangInfoBean.h
//  GangSDK
//
//  Created by codone on 2017/8/11.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseBean.h"

@class GangInfoBeanData;
@interface GangInfoBean : GangBaseBean
@property(strong) GangInfoBeanData *data;
@end

@class GangTipsBean;
@class GangLogsBean;
@interface GangInfoBeanData : NSObject
@property(strong) NSString *consortiaid;                 /**<社群id*/
@property(strong) NSString *consortianame;               /**<社群名称*/
@property(strong) NSString *iconurl;                     /**<社群图标*/
@property(strong) NSString *labelurl;                    /**<社群标签*/
@property(strong) NSString *chairman;                    /**<社群主席*/
@property(assign) NSInteger buildlevel;                  /**<社群等级*/
@property(assign) NSInteger buildnum;                    /**<社群建设度*/
@property(assign) NSInteger activelevel;                 /**<活跃等级*/
@property(assign) NSInteger nownum;                      /**<社群当前人数*/
@property(assign) NSInteger maxnum;                      /**<社群最大人数*/
@property(assign) NSInteger moneynum;                    /**<财富值*/
@property(strong) NSString *creatorid;                   /**<社群创建者id*/
@property(strong) NSString *declaration;                 /**<社群宣言*/
@property(strong) NSArray<GangTipsBean*> *announcements; /**<公告*/
@property(strong) NSArray<GangLogsBean*> *actions;       /**<社群日志*/
@property(assign) BOOL isneedapprove;                    /**<加入社群是否需要审批*/
@end

@interface GangTipsBean : NSObject
@property(strong) NSString *content;                     /**<日志的内容*/
@property(strong) NSString *createtime;                  /**<日志的创建时间*/
@end

@interface GangLogsBean : NSObject
@property(strong) NSString *content;                     /**<公告的内容*/
@property(strong) NSString *createtime;                  /**<公告的创建时间*/
@end
