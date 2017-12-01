//
//  GangNormalLoadMoreTableView.m
//  Refresh
//
//  Created by codone on 2017/7/14.
//  Copyright © 2017年 codone. All rights reserved.
//

#import "GangChatBottomRefreshTableView.h"
#import <GangSupport/CodoneRefresh.h>

@implementation GangChatBottomRefreshTableView
-(void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    if (newSuperview) {
        __weak GangChatBottomRefreshTableView *weakSelf = self;
        [self setupFooter:[self customLoadViewName] withBlock:^{
            if (weakSelf.refreshDelegate&&[weakSelf.refreshDelegate respondsToSelector:@selector(refreshDatas:)]) {
                [weakSelf.refreshDelegate performSelector:@selector(refreshDatas:) withObject:weakSelf];
            }
        }];
    }
}

-(void)startRefresh{
    [self.refreshFooter showRefreshing];
}

-(void)endRefresh{
    [self.refreshFooter endRefreshing];
}

-(NSString*)customLoadViewName{
    return @"CodoneChatBottomRefreshView";
}
@end
