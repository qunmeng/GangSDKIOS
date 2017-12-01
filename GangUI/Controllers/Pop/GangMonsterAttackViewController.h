//
//  GangGameViewController.h
//  GangSDK
//
//  Created by codone on 2017/9/8.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBasePresentViewController.h"
#import <GangSDK/GangAttackBean.h>

@interface GangMonsterAttackViewController : GangBasePresentViewController
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UIImageView *iv_image;
@property (weak, nonatomic) IBOutlet UIButton *btn_action;
@property(strong) GangAttackBean *bean;
@end
