//
//  GangAddMemberViewController.m
//  GangSDK
//
//  Created by codone on 2017/8/3.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangAddMemberViewController.h"


@interface GangAddMemberViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UILabel *label_info;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_centerY_view;
@property (weak, nonatomic) IBOutlet UIButton *btn_add;
@property (weak, nonatomic) IBOutlet UIButton *btn_cancel;

@end

@implementation GangAddMemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.label_title.textColor = [UIColor colorFromHexRGB:GangColor_pop_addMember_title];
    NSString *holderText = [GangTools getLocalizationOfKey:@"输入昵称"];
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:[UIColor colorFromHexRGB:GangColor_pop_addMember_placeHolder]
                        range:NSMakeRange(0, holderText.length)];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:16]
                        range:NSMakeRange(0, holderText.length)];
    self.textfield.attributedPlaceholder = placeholder;
    [self.textfield setTextColor:[UIColor colorFromHexRGB:GangColor_pop_addMember_inputMessage]];
    [self.textfield setTintColor:[UIColor colorFromHexRGB:GangColor_pop_addMember_inputMessage]];
    self.label_info.textColor = [UIColor colorFromHexRGB:GangColor_pop_addMember_info];
    self.label_info.text = [GangSDKInstance.settingBean.data.gameprompt.add_member stringByReplacingOccurrencesOfString:@"{$gangname$}" withString:GangSDKInstance.settingBean.data.gamevariable.gangname];
    [self.btn_add setTitle:[GangTools getLocalizationOfKey:@"确认"] forState:UIControlStateNormal];
    [self.btn_add setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_confirmButton] forState:UIControlStateNormal];
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

- (IBAction)btn_add_click:(id)sender {
    NSString *str_name = self.textfield.text;
    if ([GangTools stringFromString:str_name deleteCharSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        if ([self.textfield isFirstResponder]) {
            [self.view toastTheMsg:@"请输入用户昵称!" atPosition:POSITION_TOP duration:1.5];
        }else{
            [self gang_toast:@"请输入用户昵称!"];
        }
        return;
    }
    [self.textfield resignFirstResponder];
    [self gang_loading:@"正在提交数据"];
    [GangSDKInstance.memberManager inviteMemberWithNickname:str_name success:^(id  _Nullable data) {
        [self gang_removeLoading];
        [[NSNotificationCenter defaultCenter] postNotificationName:Gang_notify_infoChanged object:nil];
        [self dismissViewControllerAfterAnimation];
    } fail:^(NSError * _Nullable error) {
        [self gang_removeLoading];
        if (error) {
            [self gang_toast:error.domain];
        }
    }];
}
@end
