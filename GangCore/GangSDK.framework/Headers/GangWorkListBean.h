//
//  GangWorkListBean.h
//  GangSDK
//
//  Created by codone on 2017/8/14.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseBean.h"

@class GangWorkListGroupBean;
@interface GangWorkListBean : GangBaseBean
@property(strong) NSArray<GangWorkListGroupBean*> *data;
@end

@class GangWorkBean;
@interface GangWorkListGroupBean : NSObject
@property(strong) NSString *groupname;
@property(strong) NSArray<GangWorkBean*> *groupitems;
@end

@interface GangWorkBean : NSObject
@property(assign) NSInteger taskid;      /**<任务id*/
@property(strong) NSString *gameid;      /**<游戏id*/
@property(strong) NSString *consortiaid; /**<公会id*/
@property(assign) NSInteger tasktype;    /**<1-签到；2-新鲜血液；3-积极发言；4-在线时长；5-社群捐献；6-盗匪攻城*/
@property(assign) NSInteger eventtype;   /**<事件类型：1-个人任务；2-社群任务*/
@property(strong) NSString *taskiconurl; /**<任务图片的地址*/
@property(strong) NSString *tasktitle;   /**<任务标题*/
@property(strong) NSString *taskdesc;    /**<任务描述*/
@property(assign) NSInteger cycletype;   /**<1-天；2-周；3-月；4-年*/
@property(strong) NSString *rewarddesc;  /**<任务奖励描述*/
@property(assign) NSInteger neednum;     /**<需要的人数*/
@property(assign) NSInteger nownum;      /**<当前完成任务的人数*/
@property(assign) NSInteger status;      /**<状态：0-签到；1-领取；2-进行中；3-已达成*/
@end
