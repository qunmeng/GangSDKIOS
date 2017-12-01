//
//  UIView+CodoneNormalLoadingView.m
//  cccodone
//
//  Created by codone on 2017/7/28.
//  Copyright © 2017年 codone. All rights reserved.
//

#import "UIView+GangNormalLoadingView.h"
#import "GangNormalLoadingView.h"

@implementation UIView (CodoneNormalLoadingView)

-(void)showLoadingWithInfo:(NSString *)info{
    [self showLoadingViewByName:@"GangNormalLoadingView" withCreateBlock:^UIView *{
        return [GangNormalLoadingView createAnLoadingView];
    } withCustomBlock:^(UIView *reuse) {
        GangNormalLoadingView *loading = (GangNormalLoadingView*)reuse;
        loading.userInteractionEnabled = YES;
        loading.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        loading.view_show.backgroundColor = [UIColor blackColor];
        loading.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        loading.label_info.textColor = [UIColor whiteColor];
        [loading.indicator startAnimating];
        loading.label_info.text = info;
    }];
}

-(void)updateLoadingWithInfo:(NSString *)info{
    [self updateLoadingByName:@"GangNormalLoadingView" withUpdataBlock:^(UIView *reuse) {
        GangNormalLoadingView *loading = (GangNormalLoadingView*)reuse;
        loading.label_info.text = info;
    }];
}

-(void)removeLoading{
    [self removeLoadingWithBlock:nil];
}

-(void)removeLoadingWithBlock:(void (^)(void))block{
    [self removeLoadingViewByName:@"GangNormalLoadingView" withFinishBlock:block];}
@end
