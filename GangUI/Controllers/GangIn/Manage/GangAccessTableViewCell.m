//
//  GangAccessTableViewCell.m
//  GangSDK
//
//  Created by codone on 2017/8/14.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangAccessTableViewCell.h"
#import <GangSDK/GangRightBean.h>

@implementation GangAccessTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.label_right.textColor = [UIColor colorFromHexRGB:GangColor_managePosition_item];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTheObj:(GangRightBean*)obj{
    [super setTheObj:obj];
    self.label_right.text = obj.accessdesc;
    self.btn_select.enabled = self.canEdit&&obj.canassign;
    [self.btn_select setImage:[UIImage imageNamed:(obj.selected?@"qm_btn_roleaccess_access_selected":@"qm_btn_roleaccess_access_normal")] forState:UIControlStateNormal];
}

- (IBAction)btn_select_click:(id)sender {
    GangRightBean *right = self.obj_hold;
    right.selected = !right.selected;
    [self.btn_select setImage:[UIImage imageNamed:(right.selected?@"qm_btn_roleaccess_access_selected":@"qm_btn_roleaccess_access_normal")] forState:UIControlStateNormal];
}
@end
