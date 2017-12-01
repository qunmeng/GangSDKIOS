//
//  GangTasksTableViewCell.m
//  GangSDK
//
//  Created by codone on 2017/8/2.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangTasksTableViewCell.h"
#import <GangSDK/GangWorkListBean.h>
#import <GangSupport/MGWebImage.h>

@implementation GangTasksTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.label_title setTextColor:[UIColor colorFromHexRGB:GangColor_work_name]];
    [self.label_desc setTextColor:[UIColor colorFromHexRGB:GangColor_work_desc]];
    [self.label_gift setTextColor:[UIColor colorFromHexRGB:GangColor_work_gift]];
    [self.label_percent setTextColor:[UIColor colorFromHexRGB:GangColor_work_percent]];
    self.label_cycleType.textColor = [UIColor colorFromHexRGB:GangColor_work_flag];
    [self.btn_status setTitleColor:[UIColor colorFromHexRGB:GangColor_work_btn_doing] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTheObj:(GangWorkBean*)obj{
    [super setTheObj:obj];
    [self.iv_icon setImageWithURLString:obj.taskiconurl];
    self.label_desc.text = obj.taskdesc;
    self.label_title.text = obj.tasktitle;
    self.label_gift.text = obj.rewarddesc;
    self.label_percent.text = [NSString stringWithFormat:@"%ld/%ld",(long)obj.nownum,(long)obj.neednum];
    switch (obj.status) {
        case 0:
            self.btn_status.enabled = YES;
            [self.btn_status setTitle:[GangTools getLocalizationOfKey:@"签到"] forState:UIControlStateNormal];
            [self.btn_status setBackgroundImage:[UIImage imageNamed:@"qm_btn_gangtask_sign"] forState:UIControlStateNormal];
            [self.btn_status setTitleColor:[UIColor colorFromHexRGB:GangColor_work_btn_sign] forState:UIControlStateNormal];
            break;
        case 1:
            self.btn_status.enabled = YES;
            [self.btn_status setTitle:[GangTools getLocalizationOfKey:@"领取"] forState:UIControlStateNormal];
            [self.btn_status setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
            break;
        case 2:
            self.btn_status.enabled = NO;
            [self.btn_status setTitle:[GangTools getLocalizationOfKey:@"进行中"] forState:UIControlStateNormal];
            [self.btn_status setBackgroundImage:[UIImage imageNamed:@"qm_btn_gangtask_doing"] forState:UIControlStateNormal];
            [self.btn_status setTitleColor:[UIColor colorFromHexRGB:GangColor_work_btn_doing] forState:UIControlStateNormal];
            break;
        case 3:
            self.btn_status.enabled = NO;
            [self.btn_status setTitle:[GangTools getLocalizationOfKey:@"已完成"] forState:UIControlStateNormal];
            [self.btn_status setBackgroundImage:[UIImage imageNamed:@"qm_btn_gangtask_finished"] forState:UIControlStateNormal];
            [self.btn_status setTitleColor:[UIColor colorFromHexRGB:GangColor_work_btn_finished] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    
    switch (obj.cycletype) {
        case 1:
        {
            [self.label_cycleType setText:[GangTools getLocalizationOfKey:@"日常"]];
            [self.iv_cycleTypeIcon setImage:[UIImage imageNamed:@"qm_bg_gangtask_daily"]];
        }
            break;
        case 2:
        {
            [self.label_cycleType setText:[GangTools getLocalizationOfKey:@"周常"]];
            [self.iv_cycleTypeIcon setImage:[UIImage imageNamed:@"qm_bg_gangtask_week"]];
        }
            break;
        case 3:
        {
            [self.label_cycleType setText:[GangTools getLocalizationOfKey:@"月度"]];
            [self.iv_cycleTypeIcon setImage:[UIImage imageNamed:@"qm_bg_gangtask_week"]];
        }
            break;
        case 4:
        {
            [self.label_cycleType setText:[GangTools getLocalizationOfKey:@"年度"]];
            [self.iv_cycleTypeIcon setImage:[UIImage imageNamed:@"qm_bg_gangtask_week"]];
        }
            break;
        default:
            break;
    }
}

- (IBAction)btn_status_click:(id)sender {
    if (self.baseCellDelegate&&[self.baseCellDelegate respondsToSelector:@selector(selector1:)]) {
        [self.baseCellDelegate selector1:self.obj_hold];
    }
}
@end
