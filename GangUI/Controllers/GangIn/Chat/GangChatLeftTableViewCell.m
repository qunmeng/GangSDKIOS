//
//  GangChatLeftTableViewCell.m
//  GangSDK
//
//  Created by codone on 2017/8/2.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangChatLeftTableViewCell.h"
#import <GangSupport/MGWebImage.h>

@implementation GangChatLeftTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.label_nickname.textColor = [UIColor colorFromHexRGB:GangColor_gangChat_message_nickName];
    self.iv_head.userInteractionEnabled = YES;
    [self.iv_head addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headClick)]];
    [self.label_time setTextColor:[UIColor colorFromHexRGB:GangColor_gangChat_timeLabel]];
}

-(void)headClick{
    if (self.baseCellDelegate&&[self.baseCellDelegate respondsToSelector:@selector(selector1:)]) {
        [self.baseCellDelegate selector1:self.obj_hold];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(float)computeTheCellHeight:(GangChatMessageBean*)obj{
    self.label_content.attributedText =  [CodoneTools getshowContent:obj.message textColor:[UIColor colorFromHexRGB:GangColor_gangChat_messageColor] font:[UIFont systemFontOfSize:11] lineSpace:4 paraSpace:0];
    return 8+22+7+[self.label_content sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width-(23+50+5+20+9+60), 0)].height+10+6;
}

-(void)setTheObj:(GangChatMessageBean*)obj{
    [super setTheObj:obj];
    self.label_time.text = [CodoneTools getTimeStringFromScends:[obj.createtime integerValue]/1000];
    [self.iv_head setImageWithURLString:obj.iconurl];
    self.label_content.attributedText = [[NSAttributedString alloc] initWithString:obj.message];
    float width_flag = 0;
    NSString *str_nick = obj.nickname;
    if (!self.isWorld&&obj.rolename.length>0) {
        str_nick = [NSString stringWithFormat:@"%@<%@>",str_nick,obj.rolename];
    }
    self.label_nickname.text = str_nick;
    if (self.isWorld&&obj.consortiaiconurl) {
        width_flag = 19;
        self.iv_flag.hidden = NO;
        [self.iv_flag setImageWithURLString:obj.consortiaiconurl];
    }else{
        self.iv_flag.hidden = YES;
    }
    self.constraint_width_flag.constant = width_flag;
    CGSize size_name = [self.label_nickname sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width-(23+50+5+20+5+width_flag+9+60), 0)];
    size_name.width += 20+5+width_flag+9;
    self.label_content.attributedText = [CodoneTools getshowContent:obj.message textColor:[UIColor colorFromHexRGB:GangColor_gangChat_messageColor] font:[UIFont systemFontOfSize:11] lineSpace:4 paraSpace:0];
    CGSize size = [self.label_content sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width-(23+50+5+20+9+60)+width_flag, 0)];
    self.constraint_width_label_content.constant = size.width;
    self.constraint_height_label_content.constant = size.height;
    size.width += 20+9;
    self.constraint_width.constant = size.width>size_name.width?size.width:size_name.width;
}

-(void)showTime:(BOOL)showOrHide{
    if (showOrHide) {
        self.view_time.hidden = NO;
        self.constraint_height_time.constant = 40;
    }else{
        self.view_time.hidden = YES;
        self.constraint_height_time.constant = 8;
    }
}

@end
