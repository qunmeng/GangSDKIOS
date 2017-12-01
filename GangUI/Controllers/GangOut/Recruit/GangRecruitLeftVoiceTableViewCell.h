//
//  GangRecruitLeftVoiceTableViewCell.h
//  GangSDK
//
//  Created by xd on 2017/8/17.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseTableViewCell.h"
@interface GangRecruitLeftVoiceTableViewCell : GangBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIView *view_time;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_time;
@property (weak, nonatomic) IBOutlet UILabel *label_time;
@property (weak, nonatomic) IBOutlet UIImageView *iv_head;
@property (weak, nonatomic) IBOutlet UILabel *label_nickname;
@property (weak, nonatomic) IBOutlet UIButton *btn_voice;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_width_btn_voice;
@property (weak, nonatomic) IBOutlet UILabel *label_voiceTime;
@property (weak, nonatomic) IBOutlet UIImageView *iv_flag;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_width_flag;

@property (strong) NSString *consortiaid;
@property (strong) NSString *userid;

-(void)showTime:(BOOL)showOrHide;

@end
