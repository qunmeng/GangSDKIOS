//
//  GangMembersTableViewCell.h
//  GangSDK
//
//  Created by codone on 2017/8/2.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseTableViewCell.h"

@interface GangMembersTableViewCell : GangBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *label_level;
@property (weak, nonatomic) IBOutlet UIImageView *iv_head;
@property (weak, nonatomic) IBOutlet UILabel *label_nickname;
@property (weak, nonatomic) IBOutlet UIView *view_level;
@property (weak, nonatomic) IBOutlet UIView *view_flagIvs;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_width_flags;
@property (weak, nonatomic) IBOutlet UILabel *label_role;
@property (weak, nonatomic) IBOutlet UIImageView *iv_bg_position;
@property (weak, nonatomic) IBOutlet UILabel *label_position;
@property (weak, nonatomic) IBOutlet UILabel *label_weekContribution;
@property (weak, nonatomic) IBOutlet UILabel *label_status;
@property (weak, nonatomic) IBOutlet UIButton *btn_exitGang;
@end
