//
//  GangMakesureViewController.m
//  GangSDK
//
//  Created by codone on 2017/8/14.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangMakesureViewController.h"

@interface GangMakesureViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *btn_sure;
@property (weak, nonatomic) IBOutlet UIButton *btn_cancel;

@end

@implementation GangMakesureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.label_title.text = [GangTools getLocalizationOfKey:@"提示"];
    self.label_title.textColor = [UIColor colorFromHexRGB:GangColor_pop_alert_title];
    [self.btn_sure setTitle:[GangTools getLocalizationOfKey:@"确认"] forState:UIControlStateNormal];
    [self.btn_sure setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_alert_confirmButton] forState:UIControlStateNormal];
    [self.btn_cancel setTitle:[GangTools getLocalizationOfKey:@"取消"] forState:UIControlStateNormal];
    [self.btn_cancel setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_alert_cancelButton] forState:UIControlStateNormal];
}

-(void)setTheSubviews{
    [super setTheSubviews];
    self.label.attributedText = self.info;
    self.label.textAlignment = NSTextAlignmentCenter;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */

- (IBAction)btn_close_click:(id)sender {
    [self dismissViewController];
}

- (IBAction)btn_makesure_click:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.delegate&&[self.delegate respondsToSelector:@selector(makeSureClick)]) {
            [self.delegate makeSureClick];
        }
    }];
}

@end
