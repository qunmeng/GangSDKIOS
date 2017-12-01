//
//  GangChatAttacksTableViewCell.m
//  GangSDK
//
//  Created by codone on 2017/9/30.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangChatAttacksTableViewCell.h"
#import <GangSDK/GangAttackBean.h>
#import "GangMonsterAttackViewController.h"
#import "GangWaterTreeViewController.h"

@implementation GangChatAttacksTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(float)computeTheCellHeight:(GangAttackBean*)obj{
    NSMutableAttributedString *ats = [[NSMutableAttributedString alloc] init];
    [ats appendAttributedString:[GangTools getshowContent:[NSString stringWithFormat:@"%@：",[GangTools getLocalizationOfKey:@"突发任务"]] textColor:[UIColor colorFromHexRGB:GangColor_gangChat_tipTitle] font:[UIFont systemFontOfSize:12] lineSpace:0 paraSpace:0]];
    [ats appendAttributedString:[GangTools getshowContent:obj.content textColor:[UIColor colorFromHexRGB:GangColor_gangChat_taskContent] font:[UIFont systemFontOfSize:11] lineSpace:0 paraSpace:0]];
    self.label_tips.attributedText = ats;
    float h = [self.label_tips sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width-70-8-47, 0)].height;
    h = h>23?h:23;
    return h+21;
}

-(void)setTheObj:(GangAttackBean*)obj{
    [super setTheObj:obj];
    NSMutableAttributedString *ats = [[NSMutableAttributedString alloc] init];
    [ats appendAttributedString:[GangTools getshowContent:[NSString stringWithFormat:@"%@：",[GangTools getLocalizationOfKey:@"突发任务"]] textColor:[UIColor colorFromHexRGB:GangColor_gangChat_tipTitle] font:[UIFont systemFontOfSize:12] lineSpace:0 paraSpace:0]];
    [ats appendAttributedString:[GangTools getshowContent:obj.content textColor:[UIColor colorFromHexRGB:GangColor_gangChat_taskContent] font:[UIFont systemFontOfSize:11] lineSpace:0 paraSpace:0]];
    self.label_tips.attributedText = ats;
    switch (obj.type) {
        case 0:
            [self.btn_action setTitle:[GangTools getLocalizationOfKey:@"攻击"] forState:UIControlStateNormal];
            [self.btn_action setBackgroundImage:[UIImage imageNamed:@"qm_btn_gangchat_tip_attack"] forState:UIControlStateNormal];
            break;

        case 1:
            [self.btn_action setTitle:[GangTools getLocalizationOfKey:@"浇水"] forState:UIControlStateNormal];
            [self.btn_action setBackgroundImage:[UIImage imageNamed:@"qm_btn_gangchat_tip_water"] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
}

- (IBAction)btn_action_click:(id)sender {
    if (self.baseCellDelegate&&[self.baseCellDelegate respondsToSelector:@selector(selector1:)]) {
        [self.baseCellDelegate selector1:self.obj_hold];
    }
}

@end
