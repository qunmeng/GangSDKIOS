//
//  GangGameBean.h
//  GangSDK
//
//  Created by codone on 2017/12/6.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseBean.h"

@interface GangGameBean : GangBaseBean
@property(assign) int appid;                     /**<应用内部id*/
@property(strong) NSString *appname;             /**<应用名称*/
@property(strong) NSString *appicon;             /**<应用图标*/
@property(strong) NSString *appinfo;             /**<应用介绍*/
@property(strong) NSString *androidpackage;      /**<Android包名*/
@property(strong) NSString *androiddownloadurl;  /**<Android下载地址*/
@property(strong) NSString *iospackage;          /**<iOS包名*/
@property(strong) NSString *iosscheme;           /**<iOS启动scheme*/
@property(strong) NSString *iosdownloadurl;      /**<iOS下载地址*/
@end
