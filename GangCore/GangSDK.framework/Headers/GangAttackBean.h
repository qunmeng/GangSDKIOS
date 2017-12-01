//
//  GangAttackBean.h
//  GangSDK
//
//  Created by codone on 2017/10/9.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseBean.h"

@interface GangAttackBean : GangBaseBean
@property(assign) int type;
@property(assign) NSInteger taskid;      /**<任务的id*/
@property(assign) NSInteger tasktype;    /**<任务的类型*/
@property(assign) int timeout;           /**<任务持续时间*/
@property(strong) NSString *content;     /**<任务的内容*/
@property(strong) NSString *taskiconurl; /**<任务的图标地址*/

@end
