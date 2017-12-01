//
//  CodoneRefreshView.h
//  RefreshTest
//
//  Created by codone on 2017/7/7.
//  Copyright © 2017年 codone. All rights reserved.
//

#import "UIView+Codone.h"
typedef enum : NSUInteger {
    State_CanPull,//提示拉动状态,default
    State_CanPullOrClick,//可点击或拉动状态
    State_ReleaseToLoad,//松开加载状态
    State_Refreshing,//正在加载状态
    State_EndRefresh,//刷新完成
    State_NoMoreData,//全部加载完成状态
    State_Hidden,//不可用状态
} CodoneRefreshState;

#define RefreshAnimationTime 0.2

@interface CodoneRefreshView : UIView
///默认的边距
@property(assign) UIEdgeInsets defaultInset;
///是否滚动到露出后就刷新
@property(assign) BOOL autoRefresh;
///拉动时显示透明度
@property(assign) BOOL autoAlpha;
///当前状态
@property(assign) CodoneRefreshState state;
///所在的父控件
@property(weak) UIScrollView *scrollView;
///加载中状态的回调
@property(copy) void(^loadBlock)(void);
///记录当前是否是从 可点击或拉动状态 变化来的
@property(assign) BOOL isCanPullOrClick;

//创建 工厂方法
+(id)createACodoneRefreshViewWithName:(NSString*)name;

#pragma can override simple use
-(void)showRefresh;//显示成可刷新状态
-(void)showRefreshing;//开始刷新
-(void)showLoadMoreData;//变成可加载更多
-(void)endRefreshing;//结束刷新或加载
-(void)showNoMoreData;//没有数据啦
-(void)hideRefreshView;//隐藏起来

#pragma need override for custom
-(void)updateSelfFrame;
-(void)updateState:(CodoneRefreshState)state animated:(BOOL)animted finished:(void(^)(void))finish;
-(void)updateLoadStateWithContentOffset:(CGPoint)point;

#pragma can override for show state ui
//更改状态至sate
-(void)hasChangeToState:(CodoneRefreshState)state;
//scrollview滚动至point
-(void)hasChagneToPoint:(CGPoint)point;
@end
