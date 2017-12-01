//
//  GangChatRightVoiceTableViewCell.h
//  GangSDK
//
//  Created by codone on 2017/8/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseTableViewCell.h"

@interface GangChatRightVoiceTableViewCell : GangBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIView *view_time;
@property (weak, nonatomic) IBOutlet UILabel *label_time;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_time;
@property (weak, nonatomic) IBOutlet UIImageView *iv_head;
@property (weak, nonatomic) IBOutlet UILabel *label_nickname;
@property (weak, nonatomic) IBOutlet UIButton *btn_voice;
@property (weak, nonatomic) IBOutlet UILabel *label_voiceTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_width_btn_voice;
@property (weak, nonatomic) IBOutlet UIImageView *iv_flag;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_width_flag;

@property(assign) BOOL isWorld;

-(void)showTime:(BOOL)showOrHide;
@end
