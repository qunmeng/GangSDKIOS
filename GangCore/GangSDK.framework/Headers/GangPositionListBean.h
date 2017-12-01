//
//  GangPositionListBean.h
//  GangSDK
//
//  Created by codone on 2017/8/21.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseBean.h"
#import "GangRightBean.h"

@class GangPositionListBeanData;
@interface GangPositionListBean : GangBaseBean
@property(strong) GangPositionListBeanData *data;

@end

@class GangPositionListBeanDataItem;
@interface GangPositionListBeanData : NSObject
@property(assign) BOOL canedit;/**<用户是否拥有编辑权限:1-是,0-否*/
@property(strong) NSArray<GangPositionListBeanDataItem*> *roleinfo;/**<所有角色列表*/
@property(strong) NSArray<GangRightBean*> *accessinfo;/**<所有权限列表*/
@end

@interface GangPositionListBeanDataItem : NSObject
@property(assign) NSInteger roleid;    /**<角色id*/
@property(strong) NSString *rolename;  /**<角色名称*/
@property(strong) NSArray *accesslist; /**<角色拥有的权限id列表，NSInteger类型*/
@property(assign) BOOL canedit;        /**<该角色的权限是否可编辑:1-是,0-否*/
@end
