//
//  GangCenterUserCollectionViewCell.m
//  Demo
//
//  Created by xd on 2017/12/8.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangCenterUserCollectionViewCell.h"
#import <GangSupport/MGWebImage.h>
@implementation GangCenterUserCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.label_gameName setTextColor:[UIColor colorFromHexRGB:GangColor_userCenter_gameName]];
}
- (void)setTheObj:(GangGameBean *)obj{
    [super setTheObj:obj];
    self.label_gameName.text = obj.appname;
    [self.iv_gameIcon setImageWithURLString:obj.appicon];
}
@end
