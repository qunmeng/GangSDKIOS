//
//  GangChatSystemTableViewCell.m
//  GangSDK
//
//  Created by codone on 2017/8/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangChatSystemTableViewCell.h"

@implementation GangChatSystemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.label_time setTextColor:[UIColor colorFromHexRGB:GangColor_gangChat_timeLabel]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(float)computeTheCellHeight:(GangChatMessageBean*)obj{
    NSMutableAttributedString *ats = [[NSMutableAttributedString alloc] init];
    [ats appendAttributedString:[GangTools getshowContent:[NSString stringWithFormat:@"%@：",[GangTools getLocalizationOfKey:@"系统"]] textColor:[UIColor colorFromHexRGB:GangColor_gangChat_systemMessageTitle] font:[UIFont systemFontOfSize:12] lineSpace:0 paraSpace:0]];
    [ats appendAttributedString:[GangTools getshowContent:obj.message textColor:[UIColor colorFromHexRGB:GangColor_gangChat_systemMessage] font:[UIFont systemFontOfSize:11] lineSpace:0 paraSpace:0]];
    self.label.attributedText = ats;
    float h = [self.label sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width-(320-244), 0)].height+16+10;
    return h;
}

-(void)setTheObj:(GangChatMessageBean*)obj{
    [super setTheObj:obj];
    
    NSMutableAttributedString *ats = [[NSMutableAttributedString alloc] init];
    [ats appendAttributedString:[GangTools getshowContent:[NSString stringWithFormat:@"%@：",[GangTools getLocalizationOfKey:@"系统"]] textColor:[UIColor colorFromHexRGB:GangColor_gangChat_systemMessageTitle] font:[UIFont systemFontOfSize:12] lineSpace:0 paraSpace:0]];
    [ats appendAttributedString:[GangTools getshowContent:obj.message textColor:[UIColor colorFromHexRGB:GangColor_gangChat_systemMessage] font:[UIFont systemFontOfSize:11] lineSpace:0 paraSpace:0]];
    self.label.attributedText = ats;
}

-(void)showTime:(BOOL)showOrHide{
    if (showOrHide) {
        self.view_time.hidden = NO;
        self.constraint_height_time.constant = 40;
    }else{
        self.view_time.hidden = YES;
        self.constraint_height_time.constant = 10;
    }
}

@end
