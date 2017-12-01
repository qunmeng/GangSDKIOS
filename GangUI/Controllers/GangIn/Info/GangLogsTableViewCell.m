//
//  GangLogsTableViewCell.m
//  GangSDK
//
//  Created by codone on 2017/8/2.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangLogsTableViewCell.h"

@implementation GangLogsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.label_log.textColor = [UIColor colorFromHexRGB:GangColor_gangInfo_content];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(float)computeTheCellHeight:(GangLogsBean *)obj{
    self.label_log.text = [NSString stringWithFormat:@"%@  %@",[CodoneTools getTimeStringFromScends:[obj.createtime integerValue]/1000],obj.content];
    return 16+[self.label_log sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width-(320-296)-16, 0)].height;
}

-(void)setTheObj:(GangLogListBeanData*)obj{
    [super setTheObj:obj];
    self.label_log.text = [NSString stringWithFormat:@"%@  %@",[CodoneTools getTimeStringFromScends:[obj.createtime integerValue]/1000],obj.content];
}

@end
