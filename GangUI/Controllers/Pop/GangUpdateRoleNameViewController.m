//
//  GangUpdateNicknameViewController.m
//  GangSDK
//
//  Created by codone on 2017/8/11.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangUpdateRoleNameViewController.h"


@interface GangUpdateRoleNameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_centerY_view;
@property (weak, nonatomic) IBOutlet UIButton *btn_sure;
@property (weak, nonatomic) IBOutlet UIButton *btn_cancel;

@end

@implementation GangUpdateRoleNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.label_title.text = [GangTools getLocalizationOfKey:@"昵称设置"];
    self.label_title.textColor = [UIColor colorFromHexRGB:GangColor_pop_editNickname_title];
    [self.textfield setTextColor:[UIColor colorFromHexRGB:GangColor_pop_editeditNickname_inputMessage]];
    [self.textfield setTintColor:[UIColor colorFromHexRGB:GangColor_pop_editeditNickname_inputMessage]];
    NSString *holderText = [GangTools getLocalizationOfKey:@"请输入昵称"];
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:[UIColor colorFromHexRGB:GangColor_pop_editeditNickname_placeHolder]
                        range:NSMakeRange(0, holderText.length)];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:16]
                        range:NSMakeRange(0, holderText.length)];
    self.textfield.attributedPlaceholder = placeholder;
    [self.btn_sure setTitle:[GangTools getLocalizationOfKey:@"确认"] forState:UIControlStateNormal];
    [self.btn_cancel setTitle:[GangTools getLocalizationOfKey:@"取消"] forState:UIControlStateNormal];
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

- (IBAction)btn_updata_click:(id)sender {
    NSString *str_name = self.textfield.text;
    if ([GangTools stringFromString:str_name deleteCharSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        if ([self.textfield isFirstResponder]) {
            [self.view toastTheMsg:@"请输入昵称!" atPosition:POSITION_TOP duration:1.5];
        }else{
            [self gang_toast:@"请输入昵称!"];
        }
        return;
    }else if ([CodoneTools countTheStrLength:str_name]>6) {
        if ([self.textfield isFirstResponder]) {
            [self.view toastTheMsg:@"昵称太长!" atPosition:POSITION_TOP duration:1.5];
        }else{
            [self gang_toast:@"昵称太长!"];
        }
        return;
    }
    [self.textfield resignFirstResponder];
    self.btn_sure.enabled = NO;
    [self gang_loading:@"正在提交数据"];
    [GangSDKInstance.userManager updateNickname:str_name success:^(id  _Nullable data) {
        GangSDKInstance.userBean.data.nickname = str_name;
        [self gang_removeLoading];
        [self dismissViewControllerAnimated:YES completion:^{
            if (self.delegate&&[self.delegate respondsToSelector:@selector(updated)]) {
                [self.delegate updated];
            }
        }];
    } failure:^(NSError * _Nullable error) {
        self.btn_sure.enabled = YES;
        [self gang_removeLoading];
        if (error) {
            [self gang_toast:error.domain];
        }
    }];
}
@end
