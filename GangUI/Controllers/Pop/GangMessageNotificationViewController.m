//
//  GangMessageNotificationViewController.m
//  Demo
//
//  Created by xd on 2017/12/11.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangMessageNotificationViewController.h"

@interface GangMessageNotificationViewController ()


@end

@implementation GangMessageNotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTheSubviews{
    [super setTheSubviews];
    [self.label_titleView setTextColor:[UIColor colorFromHexRGB:GangColor_pop_messageNotify_title]];
    [self.label_content setTextColor:[UIColor colorFromHexRGB:GangColor_pop_messageNotify_content]];
    [self.label_date setTextColor:[UIColor colorFromHexRGB:GangColor_pop_messageNotify_content]];
    [self.label_sender setTextColor:[UIColor colorFromHexRGB:GangColor_pop_messageNotify_content]];
    [self.btn_status setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_messageNotify_btn_ignore] forState:UIControlStateNormal];
    [self.btn_status setTitle:@"忽略" forState:UIControlStateNormal];

}

- (void)setTheDatas{
    [super setTheDatas];
    self.label_content.text = ((GangMessageBean*)self.obj).data.content;
    self.label_sender.text = @"官方团队";
    NSString *str_date = [CodoneTools getTimeStringFromScends:[((GangMessageBean *)self.obj).createtime integerValue]/1000];
    if (str_date) {
        str_date = [str_date substringToIndex:10];
    }
    self.label_date.text = str_date;
}

#pragma mark - buttonAction
- (IBAction)bn_close_click:(UIButton *)sender {
    [self dismissViewController];
}

- (IBAction)btn_status_click:(UIButton *)sender {
    if (!((GangMessageBean*)self.obj).isread) {
        [self gang_loading:@"正在提交数据"];
        [[GangSDKInstance userManager] updateMessageNotificationStateRead:((GangMessageBean*)self.obj).messageid success:^(GangBaseBean * _Nullable data) {
            [self gang_removeLoading];
            ((GangMessageBean*)self.obj).isread = YES;
            if (self.delegate&&[self.delegate respondsToSelector:@selector(update:)]) {
                [self.delegate update:self.obj];
            }
            [self dismissViewControllerAfterAnimation];
        } failure:^(NSError * _Nullable error) {
            [self gang_removeLoading];
            [self gang_toast:@"提交失败"];
            if (error) {
                [self gang_toast:error.domain];
            }
        }];
    } else {
        [self dismissViewController];
    }
}

@end
