//
//  GangAccessTableViewCell.h
//  GangSDK
//
//  Created by codone on 2017/8/14.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseTableViewCell.h"

@interface GangAccessTableViewCell : GangBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label_right;
@property (weak, nonatomic) IBOutlet UIButton *btn_select;
@property(assign) BOOL canEdit;/**<是否允许编辑*/
@end
