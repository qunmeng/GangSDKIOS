//
//  GangChatRightVoiceTableViewCell.m
//  GangSDK
//
//  Created by codone on 2017/8/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangChatRightLinkTableViewCell.h"
#import <GangSupport/MGWebImage.h>
#import <GangSupport/XLAudioClient.h>

@implementation GangChatRightLinkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.label_nickname.textColor = [UIColor colorFromHexRGB:GangColor_gangChat_message_nickName];
    self.iv_head.userInteractionEnabled = YES;
    [self.iv_head addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headClick)]];
    [self.label_time setTextColor:[UIColor colorFromHexRGB:GangColor_gangChat_timeLabel]];
    self.label_title.textColor = [UIColor colorFromHexRGB:GangColor_gangChat_message_title_right];
    self.label_subTitle.textColor = [UIColor colorFromHexRGB:GangColor_gangChat_message_content_right];
}

-(void)headClick{
    if (self.baseCellDelegate&&[self.baseCellDelegate respondsToSelector:@selector(selector1:)]) {
        GangChatMessageBean *bean = self.obj_hold;
        CGPoint point = [self.view_all convertPoint:self.iv_head.frame.origin toView:[UIApplication sharedApplication].keyWindow];
        bean.x = point.x;
        bean.y = point.y;
        [self.baseCellDelegate selector1:self.obj_hold];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(float)computeTheCellHeight:(GangChatMessageBean*)obj{
    return 122;
}

-(void)setTheObj:(GangChatMessageBean*)obj{
    [super setTheObj:obj];
    self.label_time.text = [CodoneTools getTimeStringFromScends:[obj.createtime integerValue]/1000];
    [self.iv_head setImageWithURLString:obj.iconurl];
    if (self.isSingle) {
        NSMutableAttributedString *ats = [[NSMutableAttributedString alloc] init];
        [ats appendAttributedString:[GangTools getshowContent:@"我对 " textColor:[UIColor colorFromHexRGB:GangColor_gangChat_message_selfNickName] font:[UIFont systemFontOfSize:11] lineSpace:4 paraSpace:0]];
        [ats appendAttributedString:[GangTools getshowContent:[NSString stringWithFormat:@"%@ ",obj.tonickname] textColor:[UIColor colorFromHexRGB:GangColor_gangChat_message_friendNickName] font:[UIFont systemFontOfSize:11] lineSpace:4 paraSpace:0]];
        [ats appendAttributedString:[GangTools getshowContent:@"说：" textColor:[UIColor colorFromHexRGB:GangColor_gangChat_message_selfNickName] font:[UIFont systemFontOfSize:11] lineSpace:4 paraSpace:0]];
        self.label_nickname.attributedText = ats;
    }else{
        NSString *str_nick = obj.nickname;
        if (!self.isWorld&&obj.rolename.length>0) {
            str_nick = [NSString stringWithFormat:@"%@<%@>",str_nick,obj.rolename];
        }
        self.label_nickname.text = str_nick;
    }
    float width_flag = 0;
    if (self.isWorld&&obj.consortiaiconurl) {
        width_flag = 19;
        self.iv_flag.hidden = NO;
        [self.iv_flag setImageWithURLString:obj.consortiaiconurl];
    }else{
        self.iv_flag.hidden = YES;
    }
    self.constraint_width_flag.constant = width_flag;
    CGSize size_name = [self.label_nickname sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width-(23+50+5+20+5+width_flag+9), 0)];
    size_name.width += 20+5+width_flag+9;
    
    if (obj.specialBean) {
        [self.iv_image setImageWithURLString:obj.specialBean.icon];
        self.label_title.text = obj.specialBean.title;
        self.label_subTitle.text = obj.specialBean.content;
    }
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
- (IBAction)btn_voice_click:(id)sender {
    GangChatMessageBean *msg = self.obj_hold;
    [[NSNotificationCenter defaultCenter] postNotificationName:Gang_notify_clickedASpecialCell object:nil userInfo:@{@"data":msg.specialBean,@"pushVc":self.navigationController}];
}

@end
