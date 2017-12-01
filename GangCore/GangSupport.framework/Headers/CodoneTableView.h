//
//  CodoneTableView.h
//  CodoneProject
//
//  Created by codone on 16/10/13.
//  Copyright © 2016年 Linkedren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodoneTableView : UITableView
///是否显示选择状态
@property(assign)BOOL isShowSelectCell;
///可用来存放数据
@property(strong) NSMutableArray *dataArray;
///所在的viewcontroller
@property(weak) UIViewController *parentController;

-(float)computeTheCellHeight:(NSString*)cellName withObj:(id)obj;
-(void)reloadThecellWithObj:(id)obj;
-(void)deleteTheCellWithObj:(id)obj;
@end
