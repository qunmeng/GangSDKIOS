//
//  GangLevelListTableViewCell.m
//  GangSDK
//
//  Created by codone on 2017/8/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangLevelListTableViewCell.h"
#import <GangSDK/GangInfoBean.h>
#import <GangSupport/MGWebImage.h>

@implementation GangLevelListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.label_level setTextColor:[UIColor colorFromHexRGB:GangColor_lists_level]];
    [self.label_name setTextColor:[UIColor colorFromHexRGB:GangColor_lists_name]];
    [self.label_num setTextColor:[UIColor colorFromHexRGB:GangColor_lists_num]];
    self.label_dreamWord.font = [UIFont systemFontOfSize:GangFontSize_lists_dreamWord];
    [self.label_dreamWord setTextColor:[UIColor colorFromHexRGB:GangColor_lists_dreamWord]];
    self.label_title.textColor = [UIColor colorFromHexRGB:GangColor_lists_title];
    [self.label_sort setTextColor:[UIColor colorFromHexRGB:GangColor_lists_rankNum]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(float)computeTheCellHeight:(id)obj{
    return 44;
}

-(void)setTheObj:(GangInfoBeanData*)obj{
    [super setTheObj:obj];
    [self.iv_head setImageWithURLString:obj.iconurl];
    self.label_level.text = [NSString stringWithFormat:@"%ld级",(long)obj.buildlevel];
    self.label_name.text = obj.consortianame;
    switch (self.type) {
        case 1:
            self.label_title.text = [GangTools getLocalizationOfKey:@"等级"];
            self.label_num.text = [NSString stringWithFormat:@"%ld",(long)obj.buildlevel];
            break;
        case 2:
            self.label_title.text = [GangTools getLocalizationOfKey:@"人数"];
            self.label_num.text = [NSString stringWithFormat:@"%ld",(long)obj.nownum];
            break;
        case 3:
            self.label_title.text = [GangTools getLocalizationOfKey:@"财富"];
            self.label_num.text = [NSString stringWithFormat:@"%ld",(long)obj.moneynum];
            break;
            
        default:
            break;
    }
    self.label_dreamWord.text = obj.declaration;
}
@end
