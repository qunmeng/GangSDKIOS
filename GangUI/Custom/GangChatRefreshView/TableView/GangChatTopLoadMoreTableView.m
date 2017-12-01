//
//  GangNormalRefreshTableView.m
//  Refresh
//
//  Created by codone on 2017/7/14.
//  Copyright © 2017年 codone. All rights reserved.
//

#import "GangChatTopLoadMoreTableView.h"
#import <GangSupport/CodoneRefresh.h>

@implementation GangChatTopLoadMoreTableView

-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        __weak GangChatTopLoadMoreTableView *weakSelf = self;
        [[self setupHeader:[self customRefreshViewName] withBlock:^{
            if (weakSelf.loadMoreDelegate&&[weakSelf.loadMoreDelegate respondsToSelector:@selector(loadMoreDatas:)]) {
                [weakSelf.loadMoreDelegate performSelector:@selector(loadMoreDatas:) withObject:weakSelf];
            }
        }] showLoadMoreData];
    }
}

-(void)hideTheRefreshHeader:(BOOL)hide{
    if (hide) {
        [self.refreshHeader hideRefreshView];
    }else{
        [self.refreshHeader showLoadMoreData];
    }
}

-(void)startLoad{
    [self.refreshHeader showRefreshing];
}

-(void)endLoadMoreDatas:(BOOL)showNoMore{
    if (showNoMore) {
        [self.refreshHeader showNoMoreData];
    }else{
        [self.refreshHeader showLoadMoreData];
    }
}

-(NSString*)customRefreshViewName{
    return @"CodoneChatTopLoadMoreView";
}
@end
