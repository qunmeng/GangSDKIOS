//
//  GangNetStatesHintViewController.m
//  Demo
//
//  Created by xd on 2017/12/15.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangNetStatesHintViewController.h"
@interface GangNetStatesHintViewController ()

@end

@implementation GangNetStatesHintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)setTheSubviews{
    [super setTheSubviews];
    [self.label_titleView setTextColor:[UIColor colorFromHexRGB:GangColor_pop_alert_title]];
    [self.label_content setTextColor:[UIColor colorFromHexRGB:GangColor_pop_alert_content]];
    [self.btn_confirm setTitle:@"确认" forState:UIControlStateNormal];
    [self.btn_confirm setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_alert_confirmButton] forState:UIControlStateNormal];
    [self.btn_cancel setTitle:@"取消" forState:UIControlStateNormal];
    [self.btn_cancel setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_alert_cancelButton] forState:UIControlStateNormal];
    
    self.label_content.text = self.info;
    
}

- (IBAction)btn_close_click:(UIButton *)sender {
    [self dismissViewController];
}

- (IBAction)btn_confirm_click:(UIButton *)sender {
    [self dismissViewController];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.iosdownloadurl]];
}

- (IBAction)btn_cancel_click:(UIButton *)sender {
    [self dismissViewController];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
