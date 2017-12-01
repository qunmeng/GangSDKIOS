//
//  GangGameViewController.m
//  GangSDK
//
//  Created by codone on 2017/9/8.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangWaterTreeViewController.h"
#import <GangSupport/MGWebImage.h>

@interface GangWaterTreeViewController ()
@end

@implementation GangWaterTreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.label_title.textColor = [UIColor colorFromHexRGB:GangColor_pop_tree_title];
    self.label_title.text = [GangTools getLocalizationOfKey:@"树苗浇水"];
    [self.btn_action setTitle:[GangTools getLocalizationOfKey:@"点击浇水"] forState:UIControlStateNormal];
    [self.iv_image setImageWithURLString:self.bean.taskiconurl];
    [self.btn_action setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_tree_waterButton] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_close_click:(id)sender {
    [self dismissViewController];
}

- (IBAction)btn_action_click:(id)sender {
    self.btn_action.enabled = NO;
    [[UIApplication sharedApplication].keyWindow showLoadingWithInfo:@"正在请求数据"];
    [GangSDKInstance.groupManager dealTask:self.bean.tasktype taskid:self.bean.taskid success:^(id  _Nullable data) {
        [[UIApplication sharedApplication].keyWindow removeLoading];
        [self dismissViewControllerAfterAnimation];
        [GangSDKInstance.chatManager.messages_gangTips removeObject:self.bean];
        [[NSNotificationCenter defaultCenter] postNotificationName:Gang_notify_receiveGangAttack object:nil];
    } fail:^(NSError * _Nullable error) {
        self.btn_action.enabled = YES;
        [[UIApplication sharedApplication].keyWindow removeLoading];
        if (error) {
            [[UIApplication sharedApplication].keyWindow toastTheMsg:error.domain];
        }
    }];
}
@end
