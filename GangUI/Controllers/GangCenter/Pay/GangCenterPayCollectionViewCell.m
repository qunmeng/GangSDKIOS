//
//  GangCenterPayCollectionViewCell.m
//  Demo
//
//  Created by xd on 2017/12/7.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangCenterPayCollectionViewCell.h"
#import <GangSupport/MGWebImage.h>
@implementation GangCenterPayCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.label_itemTitle setTextColor:[UIColor colorFromHexRGB:GangColor_payCenter_itemTitle]];
    [self.label_payNum setTextColor:[UIColor colorFromHexRGB:GangColor_payCenter_payNum]];
}

- (void)setTheObj:(GangGoodsBean *)obj{
    [super setTheObj:obj];
    self.label_itemTitle.text = obj.goldname;
    self.label_payNum.text = [NSString stringWithFormat:@"￥%@元",obj.goldcostnum];
    [self.iv_gold setImageWithURLString:obj.goldpicurl];
}

@end
