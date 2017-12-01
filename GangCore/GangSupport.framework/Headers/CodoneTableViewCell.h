//
//  CodoneTableViewCell.h
//  YiHuiYi
//
//  Created by codone on 2016/11/10.
//  Copyright © 2016年 Linkedren. All rights reserved.
//

#import "CodoneTableView.h"

@interface CodoneTableViewCell : UITableViewCell
///cell所在的tableview
@property(weak)CodoneTableView *parentTableView;
///obj
@property(weak)id obj_hold;

#pragma need override
-(void)resetTheCell;
-(float)computeTheCellHeight:(id)obj;
-(void)setTheObj:(id)obj;
@end
