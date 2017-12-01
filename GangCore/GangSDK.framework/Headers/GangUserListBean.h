//
//  GangUserListBean.h
//  GangSDK
//
//  Created by codone on 2017/8/14.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseBean.h"
#import "GangUserBean.h"

@interface GangUserListBean : GangBaseBean
@property(strong) NSArray<GangUserBeanData*> *data;
@end
