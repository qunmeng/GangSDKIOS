//
//  CodoneCollectionView.h
//  WJD
//
//  Created by codone on 2017/1/6.
//  Copyright © 2017年 codone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodoneCollectionView : UICollectionView
///是否显示选择状态
@property(assign)BOOL isShowSelectCell;
///可用来存放数据
@property(strong) NSMutableArray *dataArray;
///所在的viewcontroller
@property(weak) UIViewController *parentController;

-(CGSize)computeTheCellSize:(NSString*)cellName withObj:(id)obj;
-(void)reloadThecellWithObj:(id)obj;
-(void)deleteTheCellWithObj:(id)obj;
@end
