//
//  GangRecommendTableViewCell.m
//  GangSDK
//
//  Created by 雪狼 on 2017/8/1.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangRecommendTableViewCell.h"
#import <GangSupport/MGWebImage.h>

@implementation GangRecommendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //等级的字体颜色
    [self.label_gangLevel setTextColor:[UIColor colorFromHexRGB:GangColor_recommend_gangLevel]];
    //社群名称的字体颜色
    [self.label_gangName setTextColor:[UIColor colorFromHexRGB:GangColor_recommend_gangName]];
    //宣言的字体颜色
    [self.label_gangDeclaration setTextColor:[UIColor colorFromHexRGB:GangColor_recommend_gangDeclaration]];
    //社群人数的字体颜色
    [self.label_gangNowNum setTextColor:[UIColor colorFromHexRGB:GangColor_recommend_gangNowNum]];
    //设置按钮的标题字体 大小 颜色
    [self.btn_apply setTitle:@"申请加入" forState:UIControlStateNormal];
    self.btn_apply.titleLabel.font = [UIFont systemFontOfSize:GangFontSize_recommend_buttonTitle];
    [self.btn_apply setTitleColor:[UIColor colorFromHexRGB:GangColor_recommend_buttonTitle] forState:UIControlStateNormal];
}
- (void)setTheObj:(GangInfoBeanData *)obj{
    [super setTheObj:obj];
    GangInfoBeanData *data = self.obj_hold;
    if (data.consortianame != nil) {
        self.label_gangName.text = data.consortianame;
    }
    if (data.declaration != nil) {
        self.label_gangDeclaration.text = data.declaration;
    }
    if (data.iconurl != nil) {
        [self.iv_gangIcon setImageWithURLString:data.iconurl placeholder:nil];
    }
    self.label_gangLevel.text = [NSString stringWithFormat:@"%ld级",(long)data.buildlevel];
    self.label_gangNowNum.text = [NSString stringWithFormat:@"%ld",(long)data.nownum];
}

- (IBAction)btn_applyClick:(UIButton *)sender {
    if (self.baseCellDelegate&&[self.baseCellDelegate respondsToSelector:@selector(selector1:)]) {
        [self.baseCellDelegate selector1:self.obj_hold];
    }
}

- (float)computeTheCellHeight:(GangInfoBeanData *)obj{
    return 73;
}
@end
