//
//  GangMembersTableViewCell.m
//  GangSDK
//
//  Created by codone on 2017/8/2.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangMembersTableViewCell.h"

#import "UIView+GangNormalToastView.h"
#import "UIView+GangNormalLoadingView.h"
#import <GangSupport/MGWebImage.h>

@implementation GangMembersTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.label_nickname.textColor = [UIColor colorFromHexRGB:GangColor_gangMembers_nickname];
    self.label_nickname.font = [UIFont systemFontOfSize:GangFontSize_gangMembers_nickname];
    [self.label_level setTextColor:[UIColor colorFromHexRGB:GangColor_gangMembers_gamelevel]];
    [self.label_role setTextColor:[UIColor colorFromHexRGB:GangColor_gangMembers_role]];
    [self.btn_exitGang setTitle:[NSString stringWithFormat:@"%@%@",[GangTools getLocalizationOfKey:@"退出"],GangSDKInstance.settingBean.data.gamevariable.gangname] forState:UIControlStateNormal];
    [self.btn_exitGang setTitleColor:[UIColor colorFromHexRGB:GangColor_gangMembers_btn_exit] forState:UIControlStateNormal];
    [self.label_position setTextColor:[UIColor colorFromHexRGB:GangColor_gangMembers_position]];
    self.label_weekContribution.textColor = [UIColor colorFromHexRGB:GangColor_gangMembers_contribute];
    self.label_status.textColor = [UIColor colorFromHexRGB:GangColor_gangMembers_status];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(float)computeTheCellHeight:(id)obj{
    return 73;
}

-(void)setTheObj:(GangUserBeanData*)obj{
    [super setTheObj:obj];
    self.view_level.hidden = obj.gamelevel==0;
    self.label_level.text = [NSString stringWithFormat:@"Lv.%ld",(long)obj.gamelevel];
    [self.iv_head setImageWithURLString:obj.iconurl];
    [self.view_flagIvs removeAllSubViews];
    self.label_nickname.text = obj.nickname;
    float x = 0;
    if (GangSDKInstance.userBean.data.userid==obj.userid) {
        self.label_status.hidden = YES;
        self.btn_exitGang.hidden = NO;
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, 16, 16)];
        iv.image = [UIImage imageNamed:@"qm_icon_gangmembers_me"];
        CGRect frame = iv.frame;
        [self.view_flagIvs addSubview:iv];
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:11];
        [label setTextColor:[UIColor colorFromHexRGB:GangColor_gangMembers_me]];
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = frame;
        label.text = [GangTools getLocalizationOfKey:@"我"];
        [self.view_flagIvs addSubview:label];
        x += frame.size.width;
    }else{
        self.label_status.hidden = NO;
        self.label_status.text = obj.isonline?[GangTools getLocalizationOfKey:@"在线"]:[CodoneTools getTitleFromConfTime:[CodoneTools getTimeStringFromScends:obj.lastlogintime/1000]];
        self.btn_exitGang.hidden = YES;
    }
    if (obj.isforbiddenspeak) {
        if (x>0) {
            x += 4;
        }
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, 39, 16)];
        iv.image = [UIImage imageNamed:@"qm_icon_gangmembers_mute"];
        CGRect frame = iv.frame;
        frame.origin.x = x;
        iv.frame = frame;
        [self.view_flagIvs addSubview:iv];
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor colorFromHexRGB:GangColor_gangMembers_muteFlag];
        label.frame = frame;
        label.text = [GangTools getLocalizationOfKey:@"被禁言"];
        [self.view_flagIvs addSubview:label];
        x += frame.size.width;
    }
    self.constraint_width_flags.constant = x;
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
    self.label_weekContribution.text = [NSString stringWithFormat:@"%@:%ld",[GangTools getLocalizationOfKey:@"周贡献"],(long)obj.weekcontributenum];
}

- (IBAction)btn_exitGang_click:(id)sender {
    if (self.baseCellDelegate&&[self.baseCellDelegate respondsToSelector:@selector(selector1:)]) {
        [self.baseCellDelegate selector1:self.obj_hold];
    }
}
@end
