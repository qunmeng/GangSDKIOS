//
//  GangIconCollectionViewCell.m
//  GangSDK
//
//  Created by xd on 2017/9/7.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangIconCollectionViewCell.h"

@implementation GangIconCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)btn_click:(UIButton *)sender {
    if (self.baseCellDelegate&&[self.baseCellDelegate respondsToSelector:@selector(selector1:)]) {
        [self.baseCellDelegate selector1:self.obj_hold];
    }
}

@end
