//
//  GangLogListBean.h
//  GangSDK
//
//  Created by codone on 2017/8/21.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseBean.h"

@class GangLogListBeanData;
@interface GangLogListBean : GangBaseBean
@property(strong) NSArray<GangLogListBeanData*> *data;
@end

@interface GangLogListBeanData : NSObject
@property(strong) NSString *content;    /**<日志的内容*/
@property(strong) NSString *createtime; /**<日志的创建时间*/


@end
