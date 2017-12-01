//
//  GangMoreListViewController.h
//  GangSDKDemo
//
//  Created by codone on 2017/7/31.
//  Copyright © 2017年 codone. All rights reserved.
//

#import <GangSupport/CodoneMoreListViewController.h>
#import "GangUIHeader.h"

@interface GangMoreListViewController : CodoneMoreListViewController
-(void)gang_toast:(NSString*)message;
-(void)gang_loading:(NSString*)info;
-(void)gang_updataLoading:(NSString *)info;
-(void)gang_removeLoading;
@end
