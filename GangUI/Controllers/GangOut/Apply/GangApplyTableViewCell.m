//
//  GangApplyTableViewCell.m
//  GangSDK
//
//  Created by 雪狼 on 2017/8/1.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangApplyTableViewCell.h"
#import <GangSDK/GangQueryListBean.h>
#import <GangSupport/MGWebImage.h>
#import "GangTools.h"
@implementation GangApplyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //社群等级字体颜色
    [self.label_gangLevel setTextColor:[UIColor colorFromHexRGB:GangColor_apply_gangLevel]];
    //社群名称字体颜色
    [self.label_gangName setTextColor:[UIColor colorFromHexRGB:GangColor_apply_gangName]];
    //社群人数字体颜色
    [self.label_gangNowNum setTextColor:[UIColor colorFromHexRGB:GangColor_apply_gangNowNum]];
    //社群宣言字体颜色
    [self.label_gangDeclaration setTextColor:[UIColor colorFromHexRGB:GangColor_apply_gangDeclaration]];
    //设置按钮的标题 字体颜色 字体大小
    [self.btn_cancelApply setTitle:@"取消申请" forState: UIControlStateNormal];
    self.btn_cancelApply.titleLabel.font = [UIFont systemFontOfSize:GangFontSize_apply_buttonTitle];
    [self.btn_cancelApply setTitleColor:[UIColor colorFromHexRGB:GangColor_apply_buttonTitle] forState:UIControlStateNormal];
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
    if (infoData.iconurl != nil) {
        [self.iv_gangIcon setImageWithURLString:infoData.iconurl placeholder:nil];
    }
    self.label_gangLevel.text = [NSString stringWithFormat:@"%@级",infoData.buildlevel];
    self.label_gangNowNum.text = [NSString stringWithFormat:@"%ld",(long)infoData.nownum];
    
}

- (float)computeTheCellHeight:(GangQueryListItemBean *)obj{
    return 73;
}

- (IBAction)btn_cancelApplyClick:(UIButton *)sender {
    if (self.baseCellDelegate&&[self.baseCellDelegate respondsToSelector:@selector(selector1:)]) {
        [self.baseCellDelegate selector1:self.obj_hold];
    }
}


@end
