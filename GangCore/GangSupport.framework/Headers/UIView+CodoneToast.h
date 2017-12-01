//
//  UIView+CodoneToast.h
//  CodoneApplication
//
//  Created by codone on 2017/1/3.
//  Copyright © 2017年 codone. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FullMargin 30

typedef enum : NSUInteger {
    POSITION_TOP=1,
    POSITION_CENTER,
    POSITION_BOTTOM
} CodoneToastPosition;

@interface UIView (CodoneToast)<CAAnimationDelegate>
-(void)toastTheView:(UIView *)toastView;
-(void)toastTheView:(UIView *)toastView showBg:(BOOL)show touchCanceled:(BOOL)canceled;
-(void)toastTheView:(UIView *)toastView showBg:(BOOL)show touchCanceled:(BOOL)canceled atPosition:(int)position duration:(float)duration;
-(void)toastTheView:(UIView *)toastView showBg:(BOOL)show touchCanceled:(BOOL)canceled margin:(float)margin atPosition:(int)position duration:(float)duration inAnimation:(CABasicAnimation*)inAnimation outAnimation:(CABasicAnimation*)outAnimation;
-(void)stopAndRemoveCurrentToast;
-(void)stopAndRemoveCurrentToastWithoutAnimation;
@end
