//
//  GangActivesTableViewCell.h
//  GangSDK
//
//  Created by codone on 2017/8/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseTableViewCell.h"

@interface GangDonateListTableViewCellNormal : GangBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label_sort;
@property (weak, nonatomic) IBOutlet UIView *view_level;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_margin_left;
@property (weak, nonatomic) IBOutlet UIImageView *iv_level;
@property (weak, nonatomic) IBOutlet UILabel *label_level;

@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UILabel *label_role;
@property (weak, nonatomic) IBOutlet UIImageView *iv_bg_position;
@property (weak, nonatomic) IBOutlet UILabel *label_position;
@property (weak, nonatomic) IBOutlet UILabel *label_title_contributeNum;
@property (weak, nonatomic) IBOutlet UILabel *label_contributeNum;

@end
