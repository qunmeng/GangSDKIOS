//
//  UIView+CodoneUIKit.h
//  WJD
//
//  Created by codone on 2017/1/11.
//  Copyright © 2017年 codone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Codone)
/**
 *设置圆角
 *@param radius 圆角半径
 *@param corners 设置圆角的角
 */
-(void)setRadius:(float)radius
       forCorner:(UIRectCorner)corners;

- (NSLayoutConstraint*)addTopMarginForSubView:(UIView*)subView margin:(float)margin relationType:(NSLayoutRelation)relationType;
- (NSLayoutConstraint*)addLeftMarginForSubView:(UIView*)subView margin:(float)margin relationType:(NSLayoutRelation)relationType;
- (NSLayoutConstraint*)addBottomMarginForSubView:(UIView*)subView margin:(float)margin relationType:(NSLayoutRelation)relationType;
- (NSLayoutConstraint*)addRightMarginForSubView:(UIView*)subView margin:(float)margin relationType:(NSLayoutRelation)relationType;
- (NSLayoutConstraint*)setWidth:(float)width relationType:(NSLayoutRelation)relationType;
- (NSLayoutConstraint*)setHeight:(float)width relationType:(NSLayoutRelation)relationType;
- (NSLayoutConstraint*)setEqualWidthForView:(UIView*)view withView:(UIView*)toView;
- (NSLayoutConstraint*)setEqualHeightForView:(UIView*)view withView:(UIView*)toView;
- (void)setCenterXForSubView:(UIView*)subView;
- (void)setCenterYForSubView:(UIView*)subView;

- (void)addSubViewToEqual:(UIView*)subView;
- (void)addSubViewInCenter:(UIView*)subView x:(float)x y:(float)y;
- (void)addSubViewsEqualHeight:(NSArray*)subviews;
- (void)addSubViewsToEqual:(NSArray*)subviews;
- (void)addSubViewsMatchSelf:(NSArray*)subviews;
- (void)removeAllSubViews;

- (UIImage *)createImage;
-(void)addRadius:(float)radius atCorners:(UIRectCorner)corners;
@end
