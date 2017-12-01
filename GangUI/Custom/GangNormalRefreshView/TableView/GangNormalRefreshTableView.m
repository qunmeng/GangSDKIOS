//
//  GangNormalRefreshTableView.m
//  Refresh
//
//  Created by codone on 2017/7/14.
//  Copyright © 2017年 codone. All rights reserved.
//

#import "GangNormalRefreshTableView.h"

@implementation GangNormalRefreshTableView

-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        __weak GangNormalRefreshTableView *weakSelf = self;
        [self setupHeader:[self customRefreshViewName] withBlock:^{
            if (weakSelf.refreshFooter) {
                [weakSelf.refreshFooter hideRefreshView];
            }
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
