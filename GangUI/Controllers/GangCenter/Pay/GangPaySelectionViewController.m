//
//  GangPaySelectionViewController.m
//  Demo
//
//  Created by xd on 2017/12/7.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangPaySelectionViewController.h"

@interface GangPaySelectionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_content;
@property (weak, nonatomic) IBOutlet UILabel *label_tips;
@property (weak, nonatomic) IBOutlet UIButton *btn_aliPay;
@property (weak, nonatomic) IBOutlet UIButton *btn_weixinPay;

@end

@implementation GangPaySelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)setTheSubviews{
    [super setTheSubviews];
    [self.label_title setTextColor:[UIColor colorFromHexRGB:GangColor_pop_gangPay_title]];
    [self.label_content setTextColor:[UIColor colorFromHexRGB:GangColor_pop_gangPay_content]];
    [self.label_tips setTextColor:[UIColor colorFromHexRGB:GangColor_pop_gangPay_tip]];
    
    [self.btn_aliPay setTitle:@"支付宝" forState:UIControlStateNormal];
    [self.btn_aliPay setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_gangPay_btn_aliPay] forState:UIControlStateNormal];
    
    [self.btn_weixinPay setTitle:@"微信" forState:UIControlStateNormal];
    [self.btn_weixinPay setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_gangPay_btn_weixinPay] forState:UIControlStateNormal];
    
}


#pragma mark -buttonAction
- (IBAction)btn_close_click:(UIButton *)sender {
    [self dismissViewController];
}

- (IBAction)btn_aliPay_click:(UIButton *)sender {
    [self dismissViewController];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(aliPay:)]) {
        [self.delegate aliPay:self.obj];
    }
}

- (IBAction)btn_weixinPay_click:(UIButton *)sender {
    [self dismissViewController];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(wechatPay:)]) {
        [self.delegate wechatPay:self.obj];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
