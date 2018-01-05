//
//  GangNetStatesHintViewController.h
//  Demo
//
//  Created by xd on 2017/12/15.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBasePresentViewController.h"

@interface GangNetStatesHintViewController : GangBasePresentViewController
@property (weak, nonatomic) IBOutlet UILabel *label_titleView;
@property (weak, nonatomic) IBOutlet UILabel *label_content;
@property (weak, nonatomic) IBOutlet UIButton *btn_confirm;
@property (weak, nonatomic) IBOutlet UIButton *btn_cancel;
@property(strong) NSString *iosdownloadurl;
@property(strong) NSString *info;
@end
