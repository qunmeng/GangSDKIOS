//
//  GangManageApplyTableViewCell.h
//  GangSDK
//
//  Created by codone on 2017/8/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseTableViewCell.h"

@interface GangManageApplyTableViewCell : GangBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iv_head;
@property (weak, nonatomic) IBOutlet UILabel *label_nickname;
@property (weak, nonatomic) IBOutlet UILabel *label_status;
@property (weak, nonatomic) IBOutlet UIButton *btn_agree;
@property (weak, nonatomic) IBOutlet UIButton *btn_ignore;
@property (weak, nonatomic) IBOutlet UIView *view_level;
@property (weak, nonatomic) IBOutlet UILabel *label_gameLevel;
@property (weak, nonatomic) IBOutlet UILabel *label_gameRole;

@end
