//
//  GangChatLeftVoiceTableViewCell.h
//  GangSDK
//
//  Created by codone on 2017/8/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseTableViewCell.h"

@interface GangChatLeftLinkTableViewCell : GangBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIView *view_all;
@property (weak, nonatomic) IBOutlet UIView *view_time;
@property (weak, nonatomic) IBOutlet UILabel *label_time;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_time;
@property (weak, nonatomic) IBOutlet UIImageView *iv_head;
@property (weak, nonatomic) IBOutlet UILabel *label_nickname;
@property (weak, nonatomic) IBOutlet UIImageView *iv_flag;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_width_flag;
@property (weak, nonatomic) IBOutlet UIImageView *iv_image;
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_subTitle;

@property(assign) BOOL isWorld;/**<是否是世界消息，世界消息要显示社群图标*/
@property(assign) BOOL isSingle;/**<是否是私聊消息*/
@property(weak) UINavigationController *navigationController;

-(void)showTime:(BOOL)showOrHide;
@end
