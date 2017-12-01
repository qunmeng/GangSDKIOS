//
//  GangNormalLoadMoreCollectionView.h
//  Refresh
//
//  Created by codone on 2017/7/14.
//  Copyright © 2017年 codone. All rights reserved.
//

#import "GangNormalRefreshCollectionView.h"

@protocol CollectionViewLoadMoreDelegate <NSObject>
//加载更多时回调
-(void)loadMoreDatas:(id)sender;
@end

@interface GangNormalLoadMoreCollectionView : GangNormalRefreshCollectionView
@property(assign) id<CollectionViewLoadMoreDelegate> loadMoreDelegate;
/**
 *根据下拉刷新的说教决策是否显示footer进行上拉加载
 *默认隐藏
 */
-(void)hideTheRefreshFooter:(BOOL)hide;
/**
 *停止加载
 *showNoMore 显示没有更多数据
 */
-(void)endLoadMoreDatas:(BOOL)showNoMore;

#pragma override
-(NSString*)customLoadViewName;
@end
