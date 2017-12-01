//
//  UIView+GangNormalToastView.h
//  cccodone
//
//  Created by codone on 2017/7/28.
//  Copyright © 2017年 codone. All rights reserved.
//

#import <GangSupport/UIView+CodoneToast.h>

@interface UIView (GangNormalToastView)
-(void)toastTheMsg:(NSString *)msg;
-(void)toastTheMsg:(NSString *)msg atPosition:(int)position duration:(float)duration;
-(void)toastTheMsg:(NSString *)msg margin:(float)margin atPosition:(int)position duration:(float)duration inAnimation:(CABasicAnimation*)inAnimation outAnimation:(CABasicAnimation*)outAnimation;
@end
