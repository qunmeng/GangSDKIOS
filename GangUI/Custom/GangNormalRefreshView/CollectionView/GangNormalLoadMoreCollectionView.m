//
//  GangNormalLoadMoreCollectionView.m
//  Refresh
//
//  Created by codone on 2017/7/14.
//  Copyright © 2017年 codone. All rights reserved.
//

#import "GangNormalLoadMoreCollectionView.h"

@implementation GangNormalLoadMoreCollectionView
-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        __weak GangNormalLoadMoreCollectionView *weakSelf = self;
        [[self setupFooter:[self customLoadViewName] withBlock:^{
            if (weakSelf.loadMoreDelegate&&[weakSelf.loadMoreDelegate respondsToSelector:@selector(loadMoreDatas:)]) {
                [weakSelf.loadMoreDelegate performSelector:@selector(loadMoreDatas:) withObject:weakSelf];
            }
        }] hideRefreshView];
    }
}

-(void)hideTheRefreshFooter:(BOOL)hide{
    if (hide) {
        [self.refreshFooter hideRefreshView];
    }else{
        [self.refreshFooter showLoadMoreData];
    }
}

-(void)endLoadMoreDatas:(BOOL)showNoMore{
    if (showNoMore) {
        [self.refreshFooter showNoMoreData];
    }else{
        [self.refreshFooter endRefreshing];
    }
}

-(NSString*)customLoadViewName{
    return @"CodoneNormalLoadView";
}
@end
