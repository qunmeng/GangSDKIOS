//
//  GangChatTipsTableViewCell.m
//  GangSDK
//
//  Created by codone on 2017/8/29.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangChatTipsTableViewCell.h"

@implementation GangChatTipsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(float)computeTheCellHeight:(id)obj{
    NSMutableAttributedString *ats = [[NSMutableAttributedString alloc] init];
    [ats appendAttributedString:[GangTools getshowContent:[NSString stringWithFormat:@"%@：",[GangTools getLocalizationOfKey:@"公告"]] textColor:[UIColor colorFromHexRGB:GangColor_gangChat_tipTitle] font:[UIFont systemFontOfSize:12] lineSpace:0 paraSpace:0]];
    [ats appendAttributedString:[GangTools getshowContent:obj textColor:[UIColor colorFromHexRGB:GangColor_gangChat_tipContent] font:[UIFont systemFontOfSize:11] lineSpace:0 paraSpace:0]];
    self.label_tips.attributedText = ats;
    float h = [self.label_tips sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width-70, 0)].height+16;
    return h+11;
}

-(void)setTheObj:(id)obj{
    [super setTheObj:obj];
    NSMutableAttributedString *ats = [[NSMutableAttributedString alloc] init];
    [ats appendAttributedString:[GangTools getshowContent:[NSString stringWithFormat:@"%@：",[GangTools getLocalizationOfKey:@"公告"]] textColor:[UIColor colorFromHexRGB:GangColor_gangChat_tipTitle] font:[UIFont systemFontOfSize:12] lineSpace:0 paraSpace:0]];
    [ats appendAttributedString:[GangTools getshowContent:obj textColor:[UIColor colorFromHexRGB:GangColor_gangChat_tipContent] font:[UIFont systemFontOfSize:11] lineSpace:0 paraSpace:0]];
    self.label_tips.attributedText = ats;
}

@end
