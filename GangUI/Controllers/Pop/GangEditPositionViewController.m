//
//  GangEditPositionViewController.m
//  GangSDK
//
//  Created by codone on 2017/8/21.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangEditPositionViewController.h"
#import <GangSDK/GangPositionListBean.h>


@interface GangEditPositionViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_centerY_view;
@property (weak, nonatomic) IBOutlet UIButton *btn_sure;
@property (weak, nonatomic) IBOutlet UIButton *btn_cancel;
@end

@implementation GangEditPositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.label_title.text = [GangTools getLocalizationOfKey:@"修改职位名称"];
    self.label_title.textColor = [UIColor colorFromHexRGB:GangColor_pop_editPositionName_title];
    NSString *holderText = [GangTools getLocalizationOfKey:@"输入新的名称"];
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:[UIColor colorFromHexRGB:GangColor_pop_editPositionName_placeHolder]
                        range:NSMakeRange(0, holderText.length)];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:14]
                        range:NSMakeRange(0, holderText.length)];
    self.textfield.attributedPlaceholder = placeholder;
    [self.textfield setTextColor:[UIColor colorFromHexRGB:GangColor_pop_editPositionName_inputMessage]];
    [self.textfield setTintColor:[UIColor colorFromHexRGB:GangColor_pop_editPositionName_inputMessage]];
    [self.btn_sure setTitle:[GangTools getLocalizationOfKey:@"确认"] forState:UIControlStateNormal];
    [self.btn_sure setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_confirmButton] forState:UIControlStateNormal];
    [self.btn_cancel setTitle:[GangTools getLocalizationOfKey:@"取消"] forState:UIControlStateNormal];
    [self.btn_cancel setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_cancelButton] forState:UIControlStateNormal];
}

-(void)setTheSubviews{
    [super setTheSubviews];
    [self setUpHideInputTap];
    [self setupKeyboardManageForHeight:128 atCenterY:self.constraint_centerY_view];
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
    NSString *str_position = self.textfield.text;
    if ([GangTools stringFromString:str_position deleteCharSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        if ([self.textfield isFirstResponder]) {
            [self.view toastTheMsg:@"请输入职位!" atPosition:POSITION_TOP duration:1.5];
        }else{
            [self gang_toast:@"请输入职位!"];
        }
        return;
    }else if ([CodoneTools countTheStrLength:str_position]>6) {
        if ([self.textfield isFirstResponder]) {
            [self.view toastTheMsg:@"职位名称最多六个字!" atPosition:POSITION_TOP duration:1.5];
        }else{
            [self gang_toast:@"职位名称最多六个字!"];
        }
        return;
    }
    [self.textfield resignFirstResponder];
    self.btn_sure.enabled = NO;
    [self gang_loading:@"正在提交数据"];
    [GangSDKInstance.groupManager updateGangRoleName:str_position roleid:[(GangPositionListBeanDataItem*)self.role roleid] success:^(GangBaseBean * _Nullable data) {
        [self gang_removeLoading];
        [self dismissViewControllerAfterAnimation];
        GangPositionListBeanDataItem *role = self.role;
        role.rolename = str_position;
        if (self.delegate&&[self.delegate respondsToSelector:@selector(updateSuccess)]) {
            [self.delegate updateSuccess];
        }
    } fail:^(NSError * _Nullable error) {
        self.btn_sure.enabled = YES;
        [self gang_removeLoading];
        if (error) {
            [self gang_toast:error.domain];
        }
    }];
}

@end
