//
//  GangActivesTableViewCell.m
//  GangSDK
//
//  Created by codone on 2017/8/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangActivesTableViewCellNormal.h"
#import <GangSDK/GangUserBean.h>
#import <GangSupport/MGWebImage.h>

@implementation GangActivesTableViewCellNormal

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.label_sort.textColor = [UIColor colorFromHexRGB:GangColor_gangMember_active_sortNum];
    self.iv_level.image = [UIImage imageNamed:@"qm_bg_gamelevel"];
    self.label_title_activeNum.text = [GangTools getLocalizationOfKey:@"活跃值"];
    self.label_name.textColor = [UIColor colorFromHexRGB:GangColor_gangMember_active_name];
    self.label_position.textColor = [UIColor colorFromHexRGB:GangColor_gangMember_active_position];
    self.label_role.textColor = [UIColor colorFromHexRGB:GangColor_gangMember_active_role];
    self.label_title_activeNum.textColor = [UIColor colorFromHexRGB:GangColor_gangMember_active_activeTitle];
    self.label_activeNum.textColor = [UIColor colorFromHexRGB:GangColor_gangMember_active_activeNum];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTheObj:(GangUserBeanData*)obj{
    [super setTheObj:obj];
    self.view_level.hidden = obj.gamelevel==0;
    self.constraint_margin_left.constant = obj.gamelevel==0?62:92;
    self.label_level.text = [NSString stringWithFormat:@"Lv.%ld",(long)obj.gamelevel];
    self.label_name.text = obj.nickname;
    self.label_role.text = obj.gamerole;
    switch (obj.rolelevel) {
        case 1:
            self.iv_bg_position.image = [UIImage imageNamed:@"qm_bg_role1"];
            break;
        case 10:
            self.iv_bg_position.image = [UIImage imageNamed:@"qm_bg_role3"];
            break;
        default:
            self.iv_bg_position.image = [UIImage imageNamed:@"qm_bg_role2"];
            break;
    }
    self.label_position.text = obj.rolename;
    self.label_activeNum.text = [NSString stringWithFormat:@"%ld",(long)obj.activenum];
}

@end
