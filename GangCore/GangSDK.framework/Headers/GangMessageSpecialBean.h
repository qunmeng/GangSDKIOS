//
//  GangMessageSpecialBean.h
//  GangSDK
//
//  Created by codone on 2017/12/14.
//  Copyright © 2017年 qm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GangMessageSpecialBean : NSObject
@property(assign) int type;                     /**<自定义类型*/
@property(strong) NSString *icon;               /**<图标*/
@property(strong) NSString *title;              /**<标题*/
@property(strong) NSString *content;            /**<内容*/
@property(strong) NSDictionary *extra;          /**<额外信息*/
@end
