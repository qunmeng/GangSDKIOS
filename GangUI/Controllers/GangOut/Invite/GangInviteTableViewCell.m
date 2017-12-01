//
//  GangInviteTableViewCell.m
//  GangSDK
//
//  Created by 雪狼 on 2017/8/1.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangInviteTableViewCell.h"
#import <GangSupport/MGWebImage.h>

@implementation GangInviteTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //社群等级字体颜色
    [self.label_gangLevel setTextColor:[UIColor colorFromHexRGB:GangColor_invite_gangLevel]];
    //社群名称字体颜色
    [self.label_gangName setTextColor:[UIColor colorFromHexRGB:GangColor_invite_gangName]];
    //社群人数字体颜色
    [self.label_gangNowNum setTextColor:[UIColor colorFromHexRGB:GangColor_invite_gangNowNum]];
    //社群宣言字体颜色
    [self.label_gangDeclaration setTextColor:[UIColor colorFromHexRGB:GangColor_invite_gangDeclaration]];
    //设置按钮的标题 字体颜色及其大小
    [self.btn_agreeJoin setTitle:@"同意" forState: UIControlStateNormal];
    self.btn_agreeJoin.titleLabel.font = [UIFont systemFontOfSize:GangFontSize_invite_buttonTitle];
    [self.btn_agreeJoin setTitleColor:[UIColor colorFromHexRGB:GangColor_invite_agreeButtonTitle] forState:UIControlStateNormal];
    
    [self.btn_refuseJoin setTitle:@"拒绝" forState: UIControlStateNormal];
    self.btn_refuseJoin.titleLabel.font = [UIFont systemFontOfSize:GangFontSize_invite_buttonTitle];
    [self.btn_refuseJoin setTitleColor:[UIColor colorFromHexRGB:GangColor_invite_refuseButtonTitle] forState:UIControlStateNormal];
}

- (void)setTheObj:(GangQueryListItemBean *)obj{
    [super setTheObj:obj];
    GangQueryListItemBean *infoData = self.obj_hold;
    if (infoData.consortianame != nil) {
        self.label_gangName.text = infoData.consortianame;
    }
    if (infoData.declaration != nil) {
        self.label_gangDeclaration.text = infoData.declaration;
    }
    self.label_gangLevel.text = [NSString stringWithFormat:@"%@级",infoData.buildlevel];
    self.label_gangNowNum.text = [NSString stringWithFormat:@"%ld",(long)infoData.nownum];
    if (infoData.iconurl.length > 0) {
        [self.iv_gangIcon setImageWithURLString:infoData.iconurl placeholder:nil];
    }
}

- (float)computeTheCellHeight:(GangQueryListItemBean *)obj{
    return 73;
}


- (IBAction)btn_agreeJoinClick:(UIButton *)sender {
    if (self.baseCellDelegate&&[self.baseCellDelegate respondsToSelector:@selector(selector1:)]) {
        ((GangQueryListItemBean*)self.obj_hold).status = 1;
        [self.baseCellDelegate selector1:(GangQueryListItemBean*)self.obj_hold];
    }
}

- (IBAction)btn_refuseJoinClick:(UIButton *)sender {
    if (self.baseCellDelegate&&[self.baseCellDelegate respondsToSelector:@selector(selector1:)]) {
        ((GangQueryListItemBean*)self.obj_hold).status = 2;
        [self.baseCellDelegate selector1:(GangQueryListItemBean*)self.obj_hold];
    }
}

@end
