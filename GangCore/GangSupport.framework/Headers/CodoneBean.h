//
//  CodoneBean.h
//  Yopull
//
//
//  Created by codone on 15/12/3.
//  Copyright © 2015年 codone. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface CodoneBean : NSObject
#pragma mark - 可选参数，用于缓存
///是否可以设置 展开控制
@property(assign)BOOL needShowMore;
///是否是展开状态
@property(assign)BOOL hasShowMore;
///是否被选择
@property(assign)BOOL hasSelected;
///是否禁止选择
@property(assign)BOOL forbidSelect;
///是否需要重新计算,在数据改变影响高度时设置YES
@property(assign) BOOL needReCompute;
///cell高度,用来缓存
@property(assign) float heightHolder;
@end
