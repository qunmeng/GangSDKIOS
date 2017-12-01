//
//  GangBasePresentViewController.h
//  GangSDKDemo
//
//  Created by codone on 2017/7/31.
//  Copyright © 2017年 codone. All rights reserved.
//

#import <GangSupport/CodonePresentViewController.h>
#import "GangUIHeader.h"

@interface GangBasePresentViewController : CodonePresentViewController
@property (weak)  NSLayoutConstraint *constraint_centerY;
@property(assign) float height_view;
@property(assign) BOOL keyboardAutoFitDisable;/**<禁止自动适配键盘弹出*/
-(void)setupKeyboardManageForHeight:(float)height atCenterY:(NSLayoutConstraint*)yConstraint;

-(void)gang_toast:(NSString*)message;
-(void)gang_loading:(NSString*)info;
-(void)gang_updataLoading:(NSString *)info;
-(void)gang_removeLoading;

-(void)dismissViewControllerAfterAnimation;
-(void)dismissViewControllerAfterDelay:(float)delay;
@end
