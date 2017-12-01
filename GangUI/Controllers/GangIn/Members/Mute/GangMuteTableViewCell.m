//
//  GangMuteTableViewCell.m
//  GangSDK
//
//  Created by codone on 2017/8/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangMuteTableViewCell.h"
#import <GangSDK/GangUserBean.h>
#import <GangSupport/MGWebImage.h>

@implementation GangMuteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.label_level setTextColor:[UIColor colorFromHexRGB:GangColor_gangMember_mute_level]];
    self.label_name.textColor = [UIColor colorFromHexRGB:GangColor_gangMember_mute_name];
    self.label_gameRole.textColor = [UIColor colorFromHexRGB:GangColor_gangMember_mute_role];
    self.label_overTime.textColor = [UIColor colorFromHexRGB:GangColor_gangMember_mute_time];
    self.label_position.textColor = [UIColor colorFromHexRGB:GangColor_gangMember_mute_position];
    [self.btn_cancelMute setTitleColor:[UIColor colorFromHexRGB:GangColor_gangMember_mute_cancel] forState:UIControlStateNormal];
    [self.btn_cancelMute setTitle:[GangTools getLocalizationOfKey:@"解除禁言"] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTheObj:(GangUserBeanData*)obj{
    [super setTheObj:obj];
    self.view_level.hidden = obj.gamelevel==0;
    self.label_level.text = [NSString stringWithFormat:@"Lv.%ld",(long)obj.gamelevel];
    [self.iv_head setImageWithURLString:obj.iconurl];
    self.label_name.text = obj.nickname;
    if (GangSDKInstance.userBean.data.userid==obj.userid) {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
        iv.image = [UIImage imageNamed:@"qm_icon_gangmembers_me"];
        CGRect frame = iv.frame;
        frame.origin.x = 8;
        iv.frame  = frame;
        [self.view_flagIvs addSubview:iv];
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:11];
        [label setTextColor:[UIColor colorFromHexRGB:GangColor_gangMembers_me]];
        label.textAlignment = NSTextAlignmentCenter;
        label.frame = frame;
        label.text = [GangTools getLocalizationOfKey:@"我"];
        [self.view_flagIvs addSubview:label];
        self.constraint_width_flags.constant = 8+frame.size.width;
    }
    self.label_gameRole.text = obj.gamerole;
    self.label_position.text = obj.rolename;
    self.label_overTime.text = [NSString stringWithFormat:@"剩余：%@",[self getMuteOverTimeStringFromSeconds:obj.overtime/1000-[[[NSDate alloc] init] timeIntervalSince1970]]];
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
}

-(NSString*)getMuteOverTimeStringFromSeconds:(NSInteger)seconds{
    NSString *overString = @"";
    if (seconds>100*365*12*60*60) {
        overString = @"永久";
    }else{
        NSInteger day = 24*60*60;
        if (seconds>=day) {
            overString = [overString stringByAppendingString:[NSString stringWithFormat:@"%ld天",(long)seconds/day]];
        }
        seconds = seconds%day;
        NSInteger hour = 60*60;
        if (seconds>=hour) {
            overString = [overString stringByAppendingString:[NSString stringWithFormat:@"%ld小时",(long)seconds/hour]];
        }
        seconds = seconds%hour;
        NSInteger minute = 60;
        if (seconds>=minute) {
            overString = [overString stringByAppendingString:[NSString stringWithFormat:@"%ld分",(long)seconds/minute]];
        }
        seconds = seconds%minute;
        overString = [overString stringByAppendingString:[NSString stringWithFormat:@"%ld秒",(long)seconds]];
    }
    return overString;
}

- (IBAction)btn_cancelMute_click:(id)sender {
    if (self.baseCellDelegate&&[self.baseCellDelegate respondsToSelector:@selector(selector1:)]) {
        [self.baseCellDelegate selector1:self.obj_hold];
    }
}
@end
