//
//  GangRecruitLeftVoiceTableViewCell.m
//  GangSDK
//
//  Created by xd on 2017/8/17.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangRecruitLeftVoiceTableViewCell.h"
#import <GangSupport/MGWebImage.h>
#import <GangSupport/XLAudioClient.h>
#import "GangGangInfoViewController.h"
#import "GangBaseViewController.h"
@implementation GangRecruitLeftVoiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopPlay:) name:Gang_notify_playAVoice object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stopPlay) name:UIApplicationDidEnterBackgroundNotification object:nil];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHead)];
    self.iv_head.userInteractionEnabled = YES;
    [self.iv_head addGestureRecognizer:recognizer];
    self.btn_voice.imageView.animationImages = @[[UIImage imageNamed:@"qm_record_volume_left1"],[UIImage imageNamed:@"qm_record_volume_left2"],[UIImage imageNamed:@"qm_record_volume_left3"]];
    self.btn_voice.imageView.animationDuration = 1;
    [self.btn_voice setAdjustsImageWhenHighlighted:NO];
    //setTheSubviews
    [self.label_nickname setTextColor:[UIColor colorFromHexRGB:GangColor_recruit_message_nickName]];
    [self.label_voiceTime setTextColor:[UIColor colorFromHexRGB:GangColor_recruit_message_voiceTime]];
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

- (float)computeTheCellHeight:(GangChatMessageBean*)obj{
    return 65+8;
}

- (void)setTheObj:(GangChatMessageBean*)obj{
    [super setTheObj:obj];
    self.consortiaid = obj.consortiaid;
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

- (void)clickHead{
    if ([self.consortiaid integerValue] > 0) {
        GangGangInfoViewController *infoVC = [[GangGangInfoViewController alloc] init];
        infoVC.consortiaid = self.consortiaid;
        [self.parentTableView.parentController presentViewController:infoVC animated:YES completion:nil];
    } else {
        [(GangBaseViewController *)self.parentTableView.parentController gang_toast:[NSString stringWithFormat:@"他还没有加入%@",GangSDKInstance.settingBean.data.gamevariable.gangname]];
    }
}

- (IBAction)btn_voice_click:(UIButton *)sender {
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
