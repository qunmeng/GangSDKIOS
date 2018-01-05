//
//  GangNotifyDefaultTableViewCell.m
//  Demo
//
//  Created by xd on 2017/12/13.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangNotifyDefaultTableViewCell.h"

@implementation GangNotifyDefaultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
