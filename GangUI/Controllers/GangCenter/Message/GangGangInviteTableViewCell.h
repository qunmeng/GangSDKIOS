//
//  GangGangInviteTableViewCell.h
//  Demo
//
//  Created by xd on 2017/12/13.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseTableViewCell.h"

@interface GangGangInviteTableViewCell : GangBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iv_gangIcon;
@property (weak, nonatomic) IBOutlet UILabel *label_gangLevel;
@property (weak, nonatomic) IBOutlet UILabel *label_gangName;
@property (weak, nonatomic) IBOutlet UILabel *label_gangDeclaration;
@property (weak, nonatomic) IBOutlet UILabel *label_gangNowNum;
@property (weak, nonatomic) IBOutlet UIButton *btn_agreeJoin;
@property (weak, nonatomic) IBOutlet UIButton *btn_refuseJoin;
@property (weak, nonatomic) IBOutlet UIImageView *iv_bg;
@end
