//
//  GangChatRightTableViewCell.h
//  GangSDK
//
//  Created by codone on 2017/8/2.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseTableViewCell.h"
#import <GangSupport/CodoneLabel.h>

@interface GangChatRightTableViewCell : GangBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIView *view_all;
@property (weak, nonatomic) IBOutlet UIView *view_time;
@property (weak, nonatomic) IBOutlet UILabel *label_time;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_time;
@property (weak, nonatomic) IBOutlet UIImageView *iv_head;
@property (weak, nonatomic) IBOutlet UILabel *label_nickname;
@property (weak, nonatomic) IBOutlet CodoneLabel *label_content;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_width_label_content;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_label_content;
@property (weak, nonatomic) IBOutlet UIImageView *iv_flag;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_width_flag;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_width;

@property(assign) BOOL isWorld;/**<是否是世界消息，世界消息要显示社群图标*/
@property(assign) BOOL isSingle;/**<是否是私聊消息*/
-(void)showTime:(BOOL)showOrHide;
@end
