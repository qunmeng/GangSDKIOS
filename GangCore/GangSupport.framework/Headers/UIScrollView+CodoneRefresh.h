//
//  UIScrollView+CodoneRefresh.h
//  RefreshTest
//
//  Created by codone on 2017/7/7.
//  Copyright © 2017年 codone. All rights reserved.
//

#import "CodoneRefreshView.h"

@interface UIScrollView (CodoneRefresh)
@property(strong) CodoneRefreshView *refreshHeader;
@property(strong) CodoneRefreshView *refreshFooter;
-(CodoneRefreshView*)setupHeader:(NSString*)headerName withBlock:(void(^)(void))block;
-(CodoneRefreshView*)setupFooter:(NSString*)footerName withBlock:(void(^)(void))block;

@end
