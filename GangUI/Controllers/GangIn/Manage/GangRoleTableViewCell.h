//
//  GangRoleTableViewCell.h
//  GangSDK
//
//  Created by codone on 2017/8/14.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseTableViewCell.h"

@protocol GangRoleTableViewCellDelegate <NSObject>

-(void)clickEdit:(id)obj;

@end

@interface GangRoleTableViewCell : GangBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iv_bg;
@property (weak, nonatomic) IBOutlet UILabel *label_position;
@property (weak, nonatomic) IBOutlet UIButton *btn_edit;
@property(weak) id<GangRoleTableViewCellDelegate> delegate;

@end
