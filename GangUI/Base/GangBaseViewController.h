//
//  GangBaseViewController.h
//  GangSDKDemo
//
//  Created by codone on 2017/7/28.
//  Copyright © 2017年 codone. All rights reserved.
//

#import <GangSupport/CodoneViewController.h>
#import "GangUIHeader.h"

@interface GangBaseViewController : CodoneViewController
@property(assign) BOOL keyboardAutoFitDisable;/**<禁止自动适配键盘弹出*/
-(void)gang_toast:(NSString*)message;
-(void)gang_loading:(NSString*)info;
-(void)gang_updataLoading:(NSString *)info;
-(void)gang_removeLoading;
@end
