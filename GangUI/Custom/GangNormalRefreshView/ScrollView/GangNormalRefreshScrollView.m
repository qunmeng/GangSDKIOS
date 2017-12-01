//
//  GangNormalRefreshScrollView.m
//  GangSDK
//
//  Created by codone on 2017/8/25.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangNormalRefreshScrollView.h"

@implementation GangNormalRefreshScrollView

-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        __weak GangNormalRefreshScrollView *weakSelf = self;
        [self setupHeader:[self customRefreshViewName] withBlock:^{
            if (weakSelf.refreshDelegate&&[weakSelf.refreshDelegate respondsToSelector:@selector(refreshDatas:)]) {
                [weakSelf.refreshDelegate performSelector:@selector(refreshDatas:) withObject:weakSelf];
            }
        }];
    }
}

-(void)startRefresh{
    [self.refreshHeader showRefreshing];
}

-(void)endRefresh{
    [self.refreshHeader endRefreshing];
}

-(NSString*)customRefreshViewName{
    return @"CodoneNormalRefreshView";
}

@end
