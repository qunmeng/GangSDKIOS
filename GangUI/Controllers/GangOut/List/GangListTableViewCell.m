//
//  GangListTableViewCell.m
//  GangSDK
//
//  Created by 雪狼 on 2017/8/1.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangListTableViewCell.h"
#import <GangSupport/MGWebImage.h>

@implementation GangListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.label_gangName setTextColor:[UIColor colorFromHexRGB:GangColor_gangLists_gangName]];
    [self.label_gangLevel setTextColor:[UIColor colorFromHexRGB:GangColor_gangLists_gangName]];
    [self.label_gangNowNum setTextColor:[UIColor colorFromHexRGB:GangColor_gangLists_gangNum]];
    [self.label_gangDeclaration setTextColor:[UIColor colorFromHexRGB:GangColor_gangLists_gangDeclaration]];
    //设置按钮的标题 字体大小 字体颜色
    [self.btn_apply setTitle:@"申请加入" forState:UIControlStateNormal];
    self.btn_apply.titleLabel.font = [UIFont systemFontOfSize:GangFontSize_gangLists_buttonTitle];
    [self.btn_apply setTitleColor:[UIColor colorFromHexRGB:GangColor_gangLists_buttonTitle] forState:UIControlStateNormal];
}

- (void)setTheObj:(GangInfoBeanData *)obj{
    [super setTheObj:obj];
    GangInfoBeanData *infoData = self.obj_hold;
    if (infoData.consortiaid != nil) {
        self.consortiaid = infoData.consortiaid;
    }
    if (infoData.consortianame != nil) {
        self.label_gangName.text = infoData.consortianame;
    }
    if (infoData.declaration != nil) {
        self.label_gangDeclaration.text = infoData.declaration;
    }
    if (infoData.iconurl != nil) {
        [self.iv_gangIcon setImageWithURLString:infoData.iconurl placeholder:nil];
    }
    self.label_gangLevel.text = [NSString stringWithFormat:@"%ld级",(long)infoData.buildlevel];
    self.label_gangNowNum.text = [NSString stringWithFormat:@"%ld",(long)infoData.nownum];
}

- (IBAction)btn_applyClick:(UIButton *)sender {
    if (self.baseCellDelegate&&[self.baseCellDelegate respondsToSelector:@selector(selector1:)]) {
        [self.baseCellDelegate selector1:self.obj_hold];
    }
}

-(float)computeTheCellHeight:(GangInfoBeanData *)obj{
    return 72.5;
}

@end
