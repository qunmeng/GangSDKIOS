//
//  GangEditGangTipsViewController.m
//  GangSDK
//
//  Created by codone on 2017/8/11.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangEditGangTipsViewController.h"


@interface GangEditGangTipsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tv;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_centerY_view;
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UIButton *btn_sure;
@property (weak, nonatomic) IBOutlet UIButton *btn_cancel;
@property (weak, nonatomic) IBOutlet UILabel *label_holderText;

@end

@implementation GangEditGangTipsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.label_title.text = [GangTools getLocalizationOfKey:@"编辑公告"];
    self.label_title.textColor = [UIColor colorFromHexRGB:GangColor_pop_editGangTips_title];
    [self.tv setTextColor:[UIColor colorFromHexRGB:GangColor_pop_editGangTips_inputMessage]];
    [self.tv setTintColor:[UIColor colorFromHexRGB:GangColor_pop_editGangTips_inputMessage]];
    [self.btn_sure setTitle:[GangTools getLocalizationOfKey:@"确认"] forState:UIControlStateNormal];
    [self.btn_sure setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_confirmButton] forState:UIControlStateNormal];
    [self.btn_cancel setTitle:[GangTools getLocalizationOfKey:@"取消"] forState:UIControlStateNormal];
    [self.btn_cancel setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_cancelButton] forState:UIControlStateNormal];
    
    self.label_holderText.text = @"请输入内容";
    [self.label_holderText setTextColor:[UIColor colorFromHexRGB:GangColor_pop_editGangTips_placeHolder]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tvTextChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

-(void)tvTextChanged:(id)sender{
    if (self.tv.text.length==0) {
        self.label_holderText.hidden = NO;
    }else{
        self.label_holderText.hidden = YES;
    }
}


-(void)setTheSubviews{
    [super setTheSubviews];
    [self setUpHideInputTap];
    [self setupKeyboardManageForHeight:260 atCenterY:self.constraint_centerY_view];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tv becomeFirstResponder];
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

- (IBAction)btn_edit_click:(id)sender {
    NSString *str_tips = self.tv.text;
    if (str_tips.length==0) {
        if ([self.tv isFirstResponder]) {
            [self.view toastTheMsg:@"请输入公告内容!" atPosition:POSITION_TOP duration:1.5];
        }else{
            [self gang_toast:@"请输入公告内容!"];
        }
        return;
    }else if ([CodoneTools countTheStrLength:str_tips]>50){
        if ([self.tv isFirstResponder]) {
            [self.view toastTheMsg:@"公告最多50个汉字!" atPosition:POSITION_TOP duration:1.5];
        }else{
            [self gang_toast:@"公告最多50个汉字!"];
        }
        return;
    }
    [self.tv resignFirstResponder];
    self.btn_sure.enabled = NO;
    [self gang_loading:@"正在提交数据"];
    [GangSDKInstance.groupManager publishGangTips:str_tips success:^(id  _Nullable data) {
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
