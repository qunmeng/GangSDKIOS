//
//  CodoneNavigationPushAnimation.h
//  CodoneApplication
//
//  Created by codone on 2016/12/27.
//  Copyright © 2016年 codone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodoneNavigationPushAnimation : NSObject<UIViewControllerAnimatedTransitioning>

#pragma override
-(float)animationDuration;
-(void)playAnimationFromView:(UIView*)fromView toView:(UIView*)toView inContainerView:(UIView*)containerView finishBlock:(void(^)(void))finish;
@end
