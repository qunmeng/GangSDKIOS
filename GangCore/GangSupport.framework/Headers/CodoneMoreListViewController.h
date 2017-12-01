//
//  MoreItemListViewController.h
//  CodoneTests
//
//  Created by codone on 2017/1/4.
//  Copyright © 2017年 codone. All rights reserved.
//

#import "CodoneViewController.h"
#import "CodoneTopScrollViewItem.h"
#import "CodoneViewController+ReloadView.h"

@protocol MoreListViewControllerDelegate <NSObject>

///滚动显示该controller
-(void)hasShowTheController:(CodoneViewController*)controller;
///点击了选中显示的controller
-(void)clickTheSelectedItemOfController:(CodoneViewController*)controller;

@end

@interface CodoneMoreListViewController : CodoneViewController
@property (strong) NSMutableArray *array_activitys;
@property (strong) NSMutableArray *array_items;

@property(assign)BOOL noScrollAnimation;/**<是否选择时不滚动*/
@property(assign)BOOL disableAutolayout;/**<是否禁止autolayout，默认使用autolayout,topScrollView会把各个item横向线性紧挨着排列，纵向填满*/
@property(assign)BOOL marginTop;/**<是否y轴顶部留间距，非autolayout情况下配合使用，来调整在topScrollView中item的上下对齐*/
@property(assign)float marginX_topScrollView;/**<topScrollView中item的x轴间距，非autolayout情况下配合使用*/
@property (strong) UIScrollView *topScrollView;
@property (strong) UIScrollView *bottomScrollView;
@property(assign)id<MoreListViewControllerDelegate> delegate;/**<代理*/
@property(assign)int defaultPage;/**<默认显示页面 0*/
@property(assign)int pageIndex;/**<当前选中页面*/

//添加一个子vc
-(void)addAnChildActivity:(UIViewController*)controller;
-(void)showAllViews;
-(void)resetTheController;
-(void)changePageTo:(int)page;

#pragma override for top item
-(CodoneTopScrollViewItem*)getTopScrollViewItemWithTitle:(NSString*)title index:(int)index;
@end
