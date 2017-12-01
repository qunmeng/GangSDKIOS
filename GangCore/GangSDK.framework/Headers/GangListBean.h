//
//  GangListBean.h
//  GangSDK
//
//  Created by xd on 2017/8/14.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseBean.h"
#import "GangInfoBean.h"

@interface GangListBean : GangBaseBean
@property(strong) NSArray<GangInfoBeanData*> *data;
@end

