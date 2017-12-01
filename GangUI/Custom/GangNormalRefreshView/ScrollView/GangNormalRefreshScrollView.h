//
//  GangNormalRefreshScrollView.h
//  GangSDK
//
//  Created by codone on 2017/8/25.
//  Copyright © 2017年 qm. All rights reserved.
//

#import <GangSupport/CodoneRefresh.h>

@protocol ScrollViewRefreshDelegate <NSObject>
//刷新时回调
-(void)refreshDatas:(id)sender;
@end

@interface GangNormalRefreshScrollView : UIScrollView
@property(assign) id<ScrollViewRefreshDelegate> refreshDelegate;

/**
 *开始刷新
 */
-(void)startRefresh;
/**
 *停止刷新
 */
-(void)endRefresh;

#pragma override
-(NSString*)customRefreshViewName;

@end
