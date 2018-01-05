//
//  GangMessageBean.h
//  GangSDK
//
//  Created by codone on 2017/12/6.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseBean.h"

@class GangMessageBeanData;
@interface GangMessageBean : NSObject
@property(assign) int msgtype;                     /**<1-邀请加入；2-踢出公会；3-申请拒绝；4-系统消息*/
@property(strong) NSString *messageid;             /**<消息id*/
@property(strong) NSString *message;               /**<消息内容*/
@property(strong) NSString *createtime;            /**<创建时间*/
@property(assign) BOOL isread;                     /**<是否已读*/
@property(strong) GangMessageBeanData *data;       /**message 解析对应的bean*/
@end

@interface GangMessageBeanData : NSObject
@property(strong) NSString *visitid;                /**<邀请id*/
@property(strong) NSString *consortiaid;            /**<社群id*/
@property(strong) NSString *consortiaicon;          /**<社群头像*/
@property(strong) NSString *consortianame;          /**<社群名称*/
@property(strong) NSString *consortialevel;         /**<社群等级*/
@property(assign) NSInteger consortianownum;        /**<社群当前人数*/
@property(strong) NSString *consortiadeclaration;   /**<社群宣言*/

@property(strong) NSString *iconurl;                /**<图标*/
@property(strong) NSString *title;                  /**<标题*/
@property(strong) NSString *content;                /**<内容*/

#pragma mark - 本地存储
@property(assign) NSInteger status;                 /**<状态:0-邀请 1-通过 2-拒绝 3-删除 4-详情*/
@end
