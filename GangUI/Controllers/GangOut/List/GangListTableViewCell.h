//
//  GangListTableViewCell.h
//  GangSDK
//
//  Created by 雪狼 on 2017/8/1.
//  Copyright © 2017年 qm. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "GangBaseTableViewCell.h"

@interface GangListTableViewCell : GangBaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label_listNumber;
@property (weak, nonatomic) IBOutlet UIImageView *iv_gangIcon;
@property (weak, nonatomic) IBOutlet UILabel *label_gangLevel;
@property (weak, nonatomic) IBOutlet UILabel *label_gangName;
@property (weak, nonatomic) IBOutlet UILabel *label_gangDeclaration;
@property (weak, nonatomic) IBOutlet UILabel *label_gangNowNum;
@property (weak, nonatomic) IBOutlet UIButton *btn_apply;
@property (strong, nonatomic) NSString *consortiaid;

@end
