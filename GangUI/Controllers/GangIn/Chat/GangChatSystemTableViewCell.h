//
//  GangChatSystemTableViewCell.h
//  GangSDK
//
//  Created by codone on 2017/8/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseTableViewCell.h"

@interface GangChatSystemTableViewCell : GangBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIView *view_time;
@property (weak, nonatomic) IBOutlet UILabel *label_time;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_time;
@property (weak, nonatomic) IBOutlet UILabel *label;

-(void)showTime:(BOOL)showOrHide;
@end
