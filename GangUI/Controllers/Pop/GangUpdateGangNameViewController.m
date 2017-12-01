//
//  GangUpdateGangNameViewController.m
//  GangSDK
//
//  Created by codone on 2017/8/11.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangUpdateGangNameViewController.h"


@interface GangUpdateGangNameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_centerY_view;
@property (weak, nonatomic) IBOutlet UIButton *btn_sure;
@property (weak, nonatomic) IBOutlet UIButton *btn_cancel;
@property (weak, nonatomic) IBOutlet UILabel *label_info;

@end

@implementation GangUpdateGangNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.label_title.text = [GangTools getLocalizationOfKey:@"修改名称"];
    self.label_title.textColor = [UIColor colorFromHexRGB:GangColor_pop_editGangName_title];
    NSString *holderText = [GangTools getLocalizationOfKey:@"输入新的名称"];
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:[UIColor colorFromHexRGB:GangColor_pop_editGangName_placeHolder]
                        range:NSMakeRange(0, holderText.length)];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:16]
                        range:NSMakeRange(0, holderText.length)];
    self.textfield.attributedPlaceholder = placeholder;
    [self.textfield setTextColor:[UIColor colorFromHexRGB:GangColor_pop_editGangName_inputMessage]];
    [self.textfield setTintColor:[UIColor colorFromHexRGB:GangColor_pop_editGangName_inputMessage]];
    [self.btn_sure setTitle:[GangTools getLocalizationOfKey:@"确认"] forState:UIControlStateNormal];
    [self.btn_sure setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_confirmButton] forState:UIControlStateNormal];
    [self.btn_cancel setTitle:[GangTools getLocalizationOfKey:@"取消"] forState:UIControlStateNormal];
    [self.btn_cancel setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_cancelButton] forState:UIControlStateNormal];
    
    NSMutableAttributedString *ats = [[NSMutableAttributedString alloc] init];
    NSString *info = GangSDKInstance.settingBean.data.gameprompt.modify_consortia_name;
    if (info) {
        NSArray *array_info = [info componentsSeparatedByString:@"{$gangname$}"];
        [array_info enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *array_info2 = [obj componentsSeparatedByString:@"{$moneyname$}"];
            [array_info2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [ats appendAttributedString:[GangTools getshowContent:obj textColor:[UIColor colorFromHexRGB:GangColor_pop_alert_content] font:[UIFont systemFontOfSize:11] lineSpace:4 paraSpace:0]];
                if (idx!=array_info2.count-1) {
                    [ats appendAttributedString:[GangTools getshowContent:GangSDKInstance.settingBean.data.gamevariable.moneyname textColor:[UIColor colorFromHexRGB:GangColor_pop_alert_content] font:[UIFont systemFontOfSize:11] lineSpace:4 paraSpace:0]];
                }
            }];
            if (idx!=array_info.count-1) {
                [ats appendAttributedString:[GangTools getshowContent:GangSDKInstance.settingBean.data.gamevariable.gangname textColor:[UIColor colorFromHexRGB:GangColor_pop_alert_content] font:[UIFont systemFontOfSize:11] lineSpace:4 paraSpace:0]];
            }
        }];
    }
    self.label_info.attributedText = ats;
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
            [self.view toastTheMsg:[NSString stringWithFormat:@"请输入新的%@名称!",GangSDKInstance.settingBean.data.gamevariable.gangname] atPosition:POSITION_TOP duration:1.5];
        }else{
            [self gang_toast:[NSString stringWithFormat:@"请输入新的%@名称!",GangSDKInstance.settingBean.data.gamevariable.gangname]];
        }
        return;
    }else if ([CodoneTools countTheStrLength:str_name]>6) {
        if ([self.textfield isFirstResponder]) {
            [self.view toastTheMsg:[NSString stringWithFormat:@"%@名称太长!",GangSDKInstance.settingBean.data.gamevariable.gangname] atPosition:POSITION_TOP duration:1.5];
        }else{
            [self gang_toast:[NSString stringWithFormat:@"%@名称太长!",GangSDKInstance.settingBean.data.gamevariable.gangname]];
        }
        return;
    }
    [self.textfield resignFirstResponder];
    self.btn_sure.enabled = NO;
    [self gang_loading:@"正在提交数据"];
    [GangSDKInstance.groupManager updateGangName:str_name success:^(id  _Nullable data) {
        [self gang_removeLoading];
        [[NSNotificationCenter defaultCenter] postNotificationName:Gang_notify_infoChanged object:nil];
        [self dismissViewControllerAfterAnimation];
    } failure:^(NSError * _Nullable error) {
        self.btn_sure.enabled = YES;
        [self gang_removeLoading];
        if (error) {
            [self gang_toast:error.domain];
        }
    }];
}

@end
