//
//  GangRoleTableViewCell.m
//  GangSDK
//
//  Created by codone on 2017/8/14.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangRoleTableViewCell.h"
#import <GangSDK/GangPositionListBean.h>

@implementation GangRoleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.label_position.textColor = [UIColor colorFromHexRGB:GangColor_managePosition_item];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTheObj:(GangPositionListBeanDataItem*)obj{
    [super setTheObj:obj];
    self.label_position.text = obj.rolename;
}
- (IBAction)btn_select_click:(id)sender {
    if (self.baseCellDelegate&&[self.baseCellDelegate respondsToSelector:@selector(selector1:)]) {
        [self.baseCellDelegate selector1:self.obj_hold];
    }
}

- (IBAction)btn_edit_click:(id)sender {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(clickEdit:)]) {
        [self.delegate clickEdit:self.obj_hold];
    }
}
@end
