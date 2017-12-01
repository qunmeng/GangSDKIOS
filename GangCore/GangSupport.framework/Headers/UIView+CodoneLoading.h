//
//  UIView+CodoneLoading.h
//  UnderIphone
//
//  Created by codone on 2017/3/27.
//  Copyright © 2017年 codone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CodoneLoading)
//
-(void)showLoadingViewByName:(const void *)className withCreateBlock:(UIView *(^)(void))createBlock withCustomBlock:(void(^)(UIView *reuseLoadingView))customBlock;
//
-(void)updateLoadingByName:(const void *)className withUpdataBlock:(void (^)(UIView *reuseLoadingView))updateBlock;
//
-(void)removeLoadingViewByName:(const void *)className withFinishBlock:(void(^)(void))finishBlock;
@end
