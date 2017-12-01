//
//  UIView+CodoneNormalLoadingView.h
//  cccodone
//
//  Created by codone on 2017/7/28.
//  Copyright © 2017年 codone. All rights reserved.
//

#import <GangSupport/UIView+CodoneLoading.h>

@interface UIView (CodoneNormalLoadingView)
-(void)showLoadingWithInfo:(NSString*)info;
-(void)updateLoadingWithInfo:(NSString*)info;
-(void)removeLoading;
-(void)removeLoadingWithBlock:(void (^)(void))block;
@end
