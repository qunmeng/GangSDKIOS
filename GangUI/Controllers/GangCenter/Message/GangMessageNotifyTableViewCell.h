//
//  GangMessageNotifyTableViewCell.h
//  Demo
//
//  Created by xd on 2017/12/12.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseTableViewCell.h"

@interface GangMessageNotifyTableViewCell : GangBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iv_senderIcon;
@property (weak, nonatomic) IBOutlet UILabel *label_senderName;
@property (weak, nonatomic) IBOutlet UILabel *label_date;
@property (weak, nonatomic) IBOutlet UILabel *label_content;
@property (weak, nonatomic) IBOutlet UIButton *btn_delete;
@property (weak, nonatomic) IBOutlet UIButton *btn_details;
@property (weak, nonatomic) IBOutlet UIImageView *iv_bg;

@end
