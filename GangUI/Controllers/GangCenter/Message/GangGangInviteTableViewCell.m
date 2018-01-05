//
//  GangGangInviteTableViewCell.m
//  Demo
//
//  Created by xd on 2017/12/13.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangGangInviteTableViewCell.h"
#import <GangSupport/MGWebImage.h>
@implementation GangGangInviteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    //社群等级字体颜色
    [self.label_gangLevel setTextColor:[UIColor colorFromHexRGB:GangColor_invite_gangLevel]];
    //社群名称字体颜色
    [self.label_gangName setTextColor:[UIColor colorFromHexRGB:GangColor_invite_gangName]];
    //社群人数字体颜色
    [self.label_gangNowNum setTextColor:[UIColor colorFromHexRGB:GangColor_invite_gangNowNum]];
    //社群宣言字体颜色
    [self.label_gangDeclaration setTextColor:[UIColor colorFromHexRGB:GangColor_invite_gangDeclaration]];
    //设置按钮的标题 字体颜色及其大小
    [self.btn_agreeJoin setTitle:[NSString stringWithFormat:@"加入%@",GangSDKInstance.settingBean.data.gamevariable.gangname] forState: UIControlStateNormal];
    [self.btn_agreeJoin setTitleColor:[UIColor colorFromHexRGB:GangColor_invite_agreeButtonTitle] forState:UIControlStateNormal];
    
    [self.btn_refuseJoin setTitle:@"拒绝邀请" forState: UIControlStateNormal];
    [self.btn_refuseJoin setTitleColor:[UIColor colorFromHexRGB:GangColor_invite_refuseButtonTitle] forState:UIControlStateNormal];
}

- (void)setTheObj:(GangMessageBean *)obj{
    [super setTheObj:obj];
    if (obj.isread) {
        [self.iv_bg setImage:[UIImage imageNamed:@"qm_bg_message_notify_hasread"]];
    } else {
        [self.iv_bg setImage:[UIImage imageNamed:@"qm_bg_item"]];
    }
    self.label_gangName.text = obj.data.consortianame;
    self.label_gangDeclaration.text = obj.data.consortiadeclaration;
    self.label_gangLevel.text = [NSString stringWithFormat:@"%@级",obj.data.consortialevel];
    self.label_gangNowNum.text = [NSString stringWithFormat:@"%ld",(long)obj.data.consortianownum];
    if (obj.data.consortiaicon.length > 0) {
        [self.iv_gangIcon setImageWithURLString:obj.data.consortiaicon placeholder:nil];
    }
}

- (float)computeTheCellHeight:(GangQueryListItemBean *)obj{
    return 73;
}
- (IBAction)btn_agreeJoinClick:(UIButton *)sender {
    if (self.baseCellDelegate&&[self.baseCellDelegate respondsToSelector:@selector(selector1:)]) {
        ((GangMessageBean*)self.obj_hold).data.status = 1;
        [self.baseCellDelegate selector1:self.obj_hold];
    }
}
- (IBAction)btn_refuseJoinClick:(UIButton *)sender {
    if (self.baseCellDelegate&&[self.baseCellDelegate respondsToSelector:@selector(selector1:)]) {
        ((GangMessageBean*)self.obj_hold).data.status = 2;
        [self.baseCellDelegate selector1:self.obj_hold];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
