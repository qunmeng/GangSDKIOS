//
//  GangMuteTableViewCell.h
//  GangSDK
//
//  Created by codone on 2017/8/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseTableViewCell.h"

@interface GangMuteTableViewCell : GangBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iv_head;
@property (weak, nonatomic) IBOutlet UILabel *label_name;
@property (weak, nonatomic) IBOutlet UIView *view_flagIvs;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_width_flags;
@property (weak, nonatomic) IBOutlet UIImageView *iv_bg_position;
@property (weak, nonatomic) IBOutlet UILabel *label_position;
@property (weak, nonatomic) IBOutlet UILabel *label_gameRole;
@property (weak, nonatomic) IBOutlet UIImageView *iv_bg_level;
@property (weak, nonatomic) IBOutlet UIView *view_level;
@property (weak, nonatomic) IBOutlet UILabel *label_level;
@property (weak, nonatomic) IBOutlet UILabel *label_overTime;
@property (weak, nonatomic) IBOutlet UIButton *btn_cancelMute;
@end
