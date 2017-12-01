//
//  GangNormalLoadMoreTableView.h
//  Refresh
//
//  Created by codone on 2017/7/14.
//  Copyright © 2017年 codone. All rights reserved.
//

#import <GangSupport/CodoneTableView.h>

@protocol TableViewBottomRefreshDelegate <NSObject>
//刷新时回调
-(void)refreshDatas:(id)sender;
@end

@interface GangChatBottomRefreshTableView : CodoneTableView
@property(assign) id<TableViewBottomRefreshDelegate> refreshDelegate;

/**
 *开始刷新
 */
-(void)startRefresh;
/**
 *停止刷新
 */
-(void)endRefresh;

#pragma override
-(NSString*)customLoadViewName;
@end
