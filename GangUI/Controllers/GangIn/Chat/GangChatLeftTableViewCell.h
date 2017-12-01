//
//  GangChatLeftTableViewCell.h
//  GangSDK
//
//  Created by codone on 2017/8/2.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseTableViewCell.h"
#import <GangSupport/CodoneLabel.h>

@interface GangChatLeftTableViewCell : GangBaseTableViewCell
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

@property(assign) BOOL isWorld;
-(void)showTime:(BOOL)showOrHide;
@end
