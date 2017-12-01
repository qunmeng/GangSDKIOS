//
//  CodoneViewController.h
//  Yopull
//
//  Created by codone on 15/12/2.
//  Copyright © 2015年 codone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodoneTools.h"

@interface CodoneViewController : UIViewController
@property(assign) BOOL hideStatusbar;
@property(assign) UIStatusBarStyle statusbarStyleIsDefault;

-(void)setTheInit;
-(void)setTheDatas;
-(void)setTheSubviews;
-(void)setTheSubviewsAfterLayout;
-(void)firstShowViews;

@property(assign) BOOL hasRefreshed;/**<是否已经刷新成功过*/
-(void)refreshTheControllerNoJudge:(BOOL)noJudge;

-(void)setUpHideInputTap;
-(void)setUpHideInputTap:(BOOL)acrossTouch;

-(void)setStatusBarHidden:(BOOL)hiddenOrShow;
-(void)setStatusBarStyleDefault:(BOOL)toDefault;

#pragma mark - navigationcontroller

/**
 *是否禁止右划退出，默认允许
 */
@property(assign) BOOL cannotPan;
-(void)pushViewController:(UIViewController*)controller;
-(void)pushViewControllerWithoutAnimation:(UIViewController*)controller ;
-(void)popViewController;
-(void)popViewControllerWithoutAnimation;
-(void)deleteFromNavigationController;
-(void)deleteToSelfOnlyInNavigationController;

-(NSString*)pushAnimationClass;
-(NSString*)popAnimationClass;

#pragma mark - parentVC
-(void)deleteFromParentViewController;

-(void)setTheContrainerViewBeforeRemove:(UIView*)containerView;
-(void)setTheContrainerViewBeforeAdd:(UIView*)containerView;
@end
