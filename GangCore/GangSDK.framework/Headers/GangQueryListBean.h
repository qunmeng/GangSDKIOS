//
//  GangQueryListBean.h
//  GangSDK
//
//  Created by xd on 2017/8/16.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseBean.h"

@class GangQueryListItemBean;
@interface GangQueryListBean : GangBaseBean
@property(strong) NSArray<GangQueryListItemBean*> *data;
@end

@interface GangQueryListItemBean : NSObject
#pragma 申请社群
@property(assign) NSInteger applicationid; /**<申请id*/
@property(strong) NSString *consortiaid;   /**<社群id*/
@property(strong) NSString *note;          /**<备注*/
@property(assign) NSInteger status;        /**<状态:0-邀请 1-通过 2-拒绝*/
@property(strong) NSString *createtime;    /**<申请时间*/
@property(strong) NSString *iconurl;       /**<社群头像*/
@property(strong) NSString *consortianame; /**<社群名称*/
@property(strong) NSString *buildlevel;    /**<社群等级*/
@property(strong) NSString *labelurl;      /**<社群标签*/
@property(assign) NSInteger nownum;        /**<社群当前人数*/
@property(strong) NSString *declaration;   /**<社群宣言*/
#pragma 邀请社群
@property(strong) NSString *visitid;       /**<邀请id*/
@end
