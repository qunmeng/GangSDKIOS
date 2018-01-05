//
//  GangCenterGameTableViewCell.h
//  Demo
//
//  Created by xd on 2017/12/5.
//  Copyright © 2017年 qm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GangBaseTableViewCell.h"

@interface GangCenterGameTableViewCell : GangBaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iv_head;
@property (weak, nonatomic) IBOutlet UILabel *label_gameName;
@property (weak, nonatomic) IBOutlet UILabel *label_gameDescription;
@property (weak, nonatomic) IBOutlet UIButton *btn_download;

@end
