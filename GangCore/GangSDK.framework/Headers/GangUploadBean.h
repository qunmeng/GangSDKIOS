//
//  GangUploadBean.h
//  GangSDK
//
//  Created by codone on 2017/8/15.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseBean.h"

@class GangUploadBeanData;
@interface GangUploadBean : GangBaseBean
@property(strong) GangUploadBeanData *data;
@end

@interface GangUploadBeanData : NSObject
@property(strong) NSString *url;
@property(strong) NSString *iconurl;

@end
