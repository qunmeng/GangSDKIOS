//
//  CodoneLabel.h
//  TextKitAndCoreText
//
//  Created by codone on 2017/7/21.
//  Copyright © 2017年 codone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodoneLabel : UILabel
///可显示范围
@property(nullable) CGPathRef path;
///点击到url回调
@property(copy) void(^ _Nullable urlClickBlock)(id _Nullable obj);

//添加url
-(void)addUrlWithObj:(id _Nullable )obj atRange:(NSRange)range;
//插入图片
-(void)addAnImage:(UIImage*_Nonnull)img withSize:(CGSize)size atIndex:(NSInteger)index;
//复用前恢复初始化
-(void)resetSelfForReuse;
@end
