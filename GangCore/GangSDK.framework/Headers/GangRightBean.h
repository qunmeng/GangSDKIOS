//
//  GangRightBean.h
//  GangSDK
//
//  Created by codone on 2017/8/21.
//  Copyright © 2017年 qm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GangRightBean : NSObject
@property(assign) NSInteger accessid;   /**<权限id*/
@property(strong) NSString *accessdesc; /**<权限描述*/
@property(assign) BOOL canassign;       /**<是否可分配:1-是,0-否*/
@property(assign) BOOL selected;        /**<是否分配该权限*/
@end
