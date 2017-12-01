//
//  GangRecruitRightTableViewCell.m
//  GangSDK
//
//  Created by xd on 2017/8/17.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangRecruitRightTableViewCell.h"
#import <GangSupport/MGWebImage.h>
#import "GangGangInfoViewController.h"
#import "GangBaseViewController.h"

@implementation GangRecruitRightTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHead)];
    self.iv_head.userInteractionEnabled = YES;
    [self.iv_head addGestureRecognizer:recognizer];
    //setTheSubviews
    [self.label_nickname setTextColor:[UIColor colorFromHexRGB:GangColor_recruit_message_nickName]];
    [self.label_content setTextColor:[UIColor colorFromHexRGB:GangColor_recruit_messageColor_right]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTheObj:(GangChatMessageBean*)obj{
    [super setTheObj:obj];
    self.label_time.text = [CodoneTools getTimeStringFromScends:[obj.createtime integerValue]/1000];
    if (obj.iconurl != nil) {
        [self.iv_head setImageWithURLString:obj.iconurl placeholder:nil];
    }
    if (obj.nickname != nil) {
        self.label_nickname.text = obj.nickname;
    }
    float width_flag = 0;
    if (obj.consortiaiconurl) {
        width_flag = 19;
        self.iv_flag.hidden = NO;
        [self.iv_flag setImageWithURLString:obj.consortiaiconurl];
    }else{
        self.iv_flag.hidden = YES;
    }
    self.constraint_width_flag.constant = width_flag;
    CGSize size_name = [self.label_nickname sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width-(23+50+5+20+5+width_flag+9+60), 0)];
    size_name.width += 20+5+width_flag+9;
    self.label_content.attributedText = [CodoneTools getshowContent:obj.message textColor:[UIColor colorFromHexRGB:GangColor_recruit_messageColor_right] font:[UIFont systemFontOfSize:11] lineSpace:4 paraSpace:0];
    CGSize size = [self.label_content sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width-(23+50+5+20+9+60)+width_flag, 0)];
    self.constraint_width_label_content.constant = size.width;
    self.constraint_height_label_content.constant = size.height;
    size.width += 20+9;
    self.constraint_width.constant = size.width>size_name.width?size.width:size_name.width;
}

- (void)clickHead{
    if ([GangSDKInstance.userBean.data.consortiaid integerValue] > 0) {
        GangGangInfoViewController *infoVC = [[GangGangInfoViewController alloc] init];
        infoVC.consortiaid = GangSDKInstance.userBean.data.consortiaid;
        [self.parentTableView.parentController presentViewController:infoVC animated:YES completion:nil];
    } else {
        [(GangBaseViewController *)self.parentTableView.parentController gang_toast:[NSString stringWithFormat:@"您还没有加入%@",GangSDKInstance.settingBean.data.gamevariable.gangname]];
    }
}

- (float)computeTheCellHeight:(GangChatMessageBean *)obj{
    self.label_content.attributedText = [CodoneTools getshowContent:obj.message textColor:[UIColor colorFromHexRGB:GangColor_recruit_messageColor_right] font:[UIFont systemFontOfSize:11] lineSpace:4 paraSpace:0];
    return 8+22+7+[self.label_content sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width-(23+50+5+20+9+60), 0)].height+10+6;
}

- (void)showTime:(BOOL)showOrHide{
    if (showOrHide) {
        self.view_time.hidden = NO;
        self.constraint_height_time.constant = 40;
    }else{
        self.view_time.hidden = YES;
        self.constraint_height_time.constant = 8;
    }
}
@end
