//
//  UIView+GangNormalToastView.m
//  cccodone
//
//  Created by codone on 2017/7/28.
//  Copyright © 2017年 codone. All rights reserved.
//

#import "UIView+GangNormalToastView.h"
#import <objc/runtime.h>
#import "GangNormalToastView.h"
#import <GangSupport/CodoneAnimationHelper.h>

@implementation UIView (GangNormalToastView)

/**
 *显示一个可复用的默认设置的toast
 *@param msg 显示的内容
 */
-(void)toastTheMsg:(NSString *)msg{
    [self toastTheMsg:msg atPosition:POSITION_CENTER duration:1.5];
}
/**
 *显示一个可复用的默认设置的toast
 *@param msg 显示的内容
 *@param position 显示位置
 *@param duration 显示时长
 */
-(void)toastTheMsg:(NSString *)msg atPosition:(int)position duration:(float)duration{
    [self toastTheMsg:msg margin:FullMargin atPosition:position duration:duration inAnimation:[CodoneAnimationHelper scaleTo:@(1) from:@(0) durTimes:0.2 endRemove:YES] outAnimation:[CodoneAnimationHelper scaleTo:@(0) from:@(1) durTimes:0.2 endRemove:NO]];
}

/**
 *显示一个toast
 *@param msg 要展示的内容
 *@param margin toastview距离四周的最小边距
 *@param position 显示的位置
 *@param duration 展示的时长 ==0时一直显示
 *@param inAnimation 进入动画
 *@param outAnimation 退出动画
 */
-(void)toastTheMsg:(NSString *)msg margin:(float)margin atPosition:(int)position duration:(float)duration inAnimation:(CABasicAnimation*)inAnimation outAnimation:(CABasicAnimation*)outAnimation{
    GangNormalToastView *toastView = objc_getAssociatedObject(self, @"toastView");
    if (!toastView) {
        toastView = [GangNormalToastView createAnToastView];
        objc_setAssociatedObject(self, @"toastView",
                                 toastView, OBJC_ASSOCIATION_RETAIN);
    }else{
        [self stopAndRemoveCurrentToastWithoutAnimation];
    }
    toastView.label_msg.text = msg;
    [self toastTheView:toastView showBg:NO touchCanceled:NO margin:margin atPosition:position duration:duration inAnimation:inAnimation outAnimation:outAnimation];
}
@end
