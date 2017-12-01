//
//  GangChatRightVoiceTableViewCell.m
//  GangSDK
//
//  Created by codone on 2017/8/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangChatRightVoiceTableViewCell.h"
#import <GangSupport/MGWebImage.h>
#import <GangSupport/XLAudioClient.h>

@implementation GangChatRightVoiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.label_nickname.textColor = [UIColor colorFromHexRGB:GangColor_gangChat_message_nickName];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopPlay:) name:Gang_notify_playAVoice object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopPlay) name:UIApplicationDidEnterBackgroundNotification object:nil];
    self.btn_voice.imageView.animationImages = @[[UIImage imageNamed:@"qm_record_volume_right1"],[UIImage imageNamed:@"qm_record_volume_right2"],[UIImage imageNamed:@"qm_record_volume_right3"]];
    self.btn_voice.imageView.animationDuration = 1;
    self.iv_head.userInteractionEnabled = YES;
    [self.iv_head addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headClick)]];
    [self.label_time setTextColor:[UIColor colorFromHexRGB:GangColor_gangChat_timeLabel]];
    [self.label_voiceTime setTextColor:[UIColor colorFromHexRGB:GangColor_gangChat_message_voiceTime]];
}

-(void)headClick{
    if (self.baseCellDelegate&&[self.baseCellDelegate respondsToSelector:@selector(selector1:)]) {
        [self.baseCellDelegate selector1:self.obj_hold];
    }
}

-(void)stopPlay:(NSNotification*)notify{
    GangChatMessageBean *msg = self.obj_hold;
    if (msg==notify.object) {
        return;
    }
    [self stopPlaying];
}

//停止播放
-(void)stopPlay{
    GangChatMessageBean *msg = self.obj_hold;
    if (msg.isPlaying) {
        msg.isPlaying = NO;
        [self stopPlaying];
        if ([XLAudioClient sharedInstance].url_holder) {
            [[XLAudioClient sharedInstance] stop:[XLAudioClient sharedInstance].url_holder];
        }
    }
}

//播放动画
-(void)showPlaying{
    GangChatMessageBean *msg = self.obj_hold;
    msg.isPlaying = YES;
    [self.btn_voice.imageView startAnimating];
}

//停止动画
-(void)stopPlaying{
    GangChatMessageBean *msg = self.obj_hold;
    msg.isPlaying = NO;
    [self.btn_voice.imageView stopAnimating];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(float)computeTheCellHeight:(GangChatMessageBean*)obj{
    return 78;
}

-(void)setTheObj:(GangChatMessageBean*)obj{
    [super setTheObj:obj];
    self.label_time.text = [CodoneTools getTimeStringFromScends:[obj.createtime integerValue]/1000];
    [self.iv_head setImageWithURLString:obj.iconurl];
    NSString *str_nick = obj.nickname;
    if (!self.isWorld&&obj.rolename.length>0) {
        str_nick = [NSString stringWithFormat:@"%@<%@>",str_nick,obj.rolename];
    }
    self.label_nickname.text = str_nick;
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
    
    int minute = obj.voicetime/60;
    int second = obj.voicetime%60;
    NSString *str_time = @"";
    if (minute>0) {
        str_time = [NSString stringWithFormat:@"%d'",minute];
    }
    if (second>0) {
        str_time = [NSString stringWithFormat:@"%@%d\"",str_time,second];
    }
    self.label_voiceTime.text = str_time;
    
    float width = 0;
    if (obj.voicetime>10) {
        width = 140;
    }else if (obj.voicetime>5) {
        width = 120;
    }else{
        width = 100;
    }
    self.constraint_width_btn_voice.constant = width>size_name.width?width:size_name.width;
    
    if (obj.isPlaying) {
        [self showPlaying];
    }else{
        [self stopPlaying];
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
    msg.isPlaying = !msg.isPlaying;
    
    if ([XLAudioClient sharedInstance].url_holder) {
        [[XLAudioClient sharedInstance] stop:[XLAudioClient sharedInstance].url_holder];
    }
    if (msg.isPlaying) {
        [self showPlaying];
        [XLAudioClient sharedInstance].url_holder = msg.message;
        [[XLAudioClient sharedInstance] play:[XLAudioClient sharedInstance].url_holder finished:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                [self stopPlaying];
            });
        }];
        [[NSNotificationCenter defaultCenter] postNotificationName:Gang_notify_playAVoice object:msg];
    }else{
        [self stopPlaying];
    }
}

@end
