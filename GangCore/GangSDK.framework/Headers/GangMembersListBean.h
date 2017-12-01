//
//  GangMembersListBean.h
//  GangSDK
//
//  Created by codone on 2017/10/10.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseBean.h"
#import "GangUserBean.h"

@class GangMembersListBeanData;
@interface GangMembersListBean : GangBaseBean
@property(strong) GangMembersListBeanData *data;
@end

@interface GangMembersListBeanData : NSObject
@property(assign) int onlinenum;                          /**<在线时间*/
@property(assign) int totalnum;                           /**<总时长*/
@property(strong) NSArray<GangUserBeanData*> *sortedlist; /**<成员列表*/
@end
