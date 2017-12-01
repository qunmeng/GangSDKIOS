//
//  GangNormalRefreshTableView.h
//  Refresh
//
//  Created by codone on 2017/7/14.
//  Copyright © 2017年 codone. All rights reserved.
//

#import "GangChatBottomRefreshTableView.h"

@protocol TableViewTopLoadMoreDelegate <NSObject>
//刷新时回调
-(void)loadMoreDatas:(id)sender;
@end

@interface GangChatTopLoadMoreTableView : CodoneTableView
@property(assign) id<TableViewTopLoadMoreDelegate> loadMoreDelegate;

/**
 *根据下拉刷新的数据判断是否显示footer进行上拉加载
 *默认隐藏
 */
-(void)hideTheRefreshHeader:(BOOL)hide;

/**
 *开始加载
 */
-(void)startLoad;

/**
 *停止加载
 *showNoMore 显示没有更多数据
 */
-(void)endLoadMoreDatas:(BOOL)showNoMore;

#pragma override
-(NSString*)customRefreshViewName;
@end
