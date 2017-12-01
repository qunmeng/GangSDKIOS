//
//  GangNormalRefreshCollectionView.h
//  Refresh
//
//  Created by codone on 2017/7/14.
//  Copyright © 2017年 codone. All rights reserved.
//

#import <GangSupport/CodoneCollectionView.h>
#import <GangSupport/CodoneRefresh.h>

@protocol CollectionViewRefreshDelegate <NSObject>
//刷新时回调
-(void)refreshDatas:(id)sender;
@end

@interface GangNormalRefreshCollectionView : CodoneCollectionView
@property(assign) id<CollectionViewRefreshDelegate> refreshDelegate;

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
