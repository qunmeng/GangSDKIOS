//
//  GangRecruitSystemTableViewCell.m
//  GangSDK
//
//  Created by xd on 2017/8/17.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangRecruitSystemTableViewCell.h"

@implementation GangRecruitSystemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTheObj:(GangChatMessageBean *)obj{
    [super setTheObj:obj];
    
    NSMutableAttributedString *ats = [[NSMutableAttributedString alloc] init];
    [ats appendAttributedString:[GangTools getshowContent:[NSString stringWithFormat:@"%@:",[GangTools getLocalizationOfKey:@"系统"]] textColor:[UIColor redColor] font:[UIFont systemFontOfSize:12] lineSpace:0 paraSpace:0]];
    [ats appendAttributedString:[GangTools getshowContent:obj.message textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:11] lineSpace:0 paraSpace:0]];
    self.label_systemMessage.attributedText = ats;
}

- (float)computeTheCellHeight:(GangChatMessageBean *)obj{
    NSMutableAttributedString *ats = [[NSMutableAttributedString alloc] init];
    [ats appendAttributedString:[GangTools getshowContent:[NSString stringWithFormat:@"%@:",[GangTools getLocalizationOfKey:@"系统"]] textColor:[UIColor redColor] font:[UIFont systemFontOfSize:12] lineSpace:0 paraSpace:0]];
    [ats appendAttributedString:[GangTools getshowContent:obj.message textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:11] lineSpace:0 paraSpace:0]];
    self.label_systemMessage.attributedText = ats;
    float h = [self.label_systemMessage sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width-(320-244), 0)].height+16+10;
    return h;
}

@end
