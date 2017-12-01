//
//  GangTasksTableViewCell.h
//  GangSDK
//
//  Created by codone on 2017/8/2.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseTableViewCell.h"

@interface GangTasksTableViewCell : GangBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iv_background;
@property (weak, nonatomic) IBOutlet UIImageView *iv_icon;
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_desc;
@property (weak, nonatomic) IBOutlet UILabel *label_gift;
@property (weak, nonatomic) IBOutlet UILabel *label_percent;
@property (weak, nonatomic) IBOutlet UIButton *btn_status;
@property (weak, nonatomic) IBOutlet UIImageView *iv_cycleTypeIcon;
@property (weak, nonatomic) IBOutlet UILabel *label_cycleType;

@end
