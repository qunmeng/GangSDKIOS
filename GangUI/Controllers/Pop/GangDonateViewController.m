//
//  GangDonateViewController.m
//  GangSDK
//
//  Created by codone on 2017/8/11.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangDonateViewController.h"


@interface GangDonateViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UILabel *label_info;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_centerY_view;
@property (weak, nonatomic) IBOutlet UIButton *btn_sure;
@property (weak, nonatomic) IBOutlet UIButton *btn_cancel;

@end

@implementation GangDonateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.label_title.text = [GangTools getLocalizationOfKey:@"捐献"];
    self.label_title.textColor = [UIColor colorFromHexRGB:GangColor_pop_contribute_title];
    NSString *holderText = [GangTools getLocalizationOfKey:[NSString stringWithFormat:@"输入%@数量",GangSDKInstance.settingBean.data.gamevariable.moneyname]];
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:[UIColor colorFromHexRGB:GangColor_pop_contribute_placeHolder]
                        range:NSMakeRange(0, holderText.length)];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:16]
                        range:NSMakeRange(0, holderText.length)];
    self.textfield.attributedPlaceholder = placeholder;
    self.label_info.textColor = [UIColor colorFromHexRGB:GangColor_pop_contribute_info];
    NSString *info = GangSDKInstance.settingBean.data.gameprompt.consortia_contribute;
    if (info) {
        info = [info stringByReplacingOccurrencesOfString:@"{$moneyname$}" withString:GangSDKInstance.settingBean.data.gamevariable.moneyname];
        info = [info stringByReplacingOccurrencesOfString:@"{$gangname$}" withString:GangSDKInstance.settingBean.data.gamevariable.gangname];
        self.label_info.text = info;
    }
    [self.textfield setTextColor:[UIColor colorFromHexRGB:GangColor_pop_contribute_inputMessage]];
    [self.textfield setTintColor:[UIColor colorFromHexRGB:GangColor_pop_contribute_inputMessage]];
    [self.btn_sure setTitle:[GangTools getLocalizationOfKey:@"确认"] forState:UIControlStateNormal];
    [self.btn_sure setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_confirmButton] forState:UIControlStateNormal];
    [self.btn_cancel setTitle:[GangTools getLocalizationOfKey:@"取消"] forState:UIControlStateNormal];
    [self.btn_cancel setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_cancelButton] forState:UIControlStateNormal];
}

-(void)setTheSubviews{
    [super setTheSubviews];
    [self setUpHideInputTap];
    [self setupKeyboardManageForHeight:260 atCenterY:self.constraint_centerY_view];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.textfield becomeFirstResponder];
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

- (IBAction)btn_donate_click:(id)sender {
    if ([self.textfield.text integerValue]<=0) {
        if ([self.textfield isFirstResponder]) {
            [self.view toastTheMsg:@"捐献数量必须大于0!" atPosition:POSITION_TOP duration:1.5];
        }else{
            [self gang_toast:@"捐献数量必须大于0!"];
        }
        return;
    }
    [self.textfield resignFirstResponder];
    self.btn_sure.enabled = NO;
    [self gang_loading:@"正在提交数据"];
    [GangSDKInstance.groupManager donateToGangWithContributeNum:[self.textfield.text integerValue] success:^(id  _Nullable data) {
        [self gang_removeLoading];
        [self gang_toast:@"捐献成功"];
        [[NSNotificationCenter defaultCenter] postNotificationName:Gang_notify_infoChanged object:nil];
        [self dismissViewControllerAfterAnimation];
    } fail:^(NSError * _Nullable error) {
        self.btn_sure.enabled = YES;
        [self gang_removeLoading];
        if (error) {
            [self gang_toast:error.domain];
        }
    }];
}
@end
