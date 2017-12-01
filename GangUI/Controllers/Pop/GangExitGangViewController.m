//
//  GangDissolvedViewController.m
//  GangSDK
//
//  Created by codone on 2017/8/11.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangExitGangViewController.h"


@interface GangExitGangViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_content;
@property (weak, nonatomic) IBOutlet UILabel *label_info;
@property (weak, nonatomic) IBOutlet UIButton *btn_sure;
@property (weak, nonatomic) IBOutlet UIButton *btn_cancel;

@end

@implementation GangExitGangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.label_title.textColor = [UIColor colorFromHexRGB:GangColor_pop_exitGang_title];
    [self.btn_sure setTitle:[GangTools getLocalizationOfKey:@"确认"] forState:UIControlStateNormal];
    [self.btn_sure setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_confirmButton] forState:UIControlStateNormal];
    [self.btn_cancel setTitle:[GangTools getLocalizationOfKey:@"取消"] forState:UIControlStateNormal];
    [self.btn_cancel setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_cancelButton] forState:UIControlStateNormal];
    
    self.label_content.text = [NSString stringWithFormat:[GangTools getLocalizationOfKey:@"确认退出当前%@？"],GangSDKInstance.settingBean.data.gamevariable.gangname];
    self.label_content.textColor = [UIColor colorFromHexRGB:GangColor_pop_exitGang_content];
    self.label_info.attributedText = [GangTools getshowContent:[GangSDKInstance.settingBean.data.gameprompt.left_consortia stringByReplacingOccurrencesOfString:@"{$gangname$}" withString:GangSDKInstance.settingBean.data.gamevariable.gangname] textColor:[UIColor colorFromHexRGB:GangColor_pop_exitGang_info] font:[UIFont systemFontOfSize:13] lineSpace:4 paraSpace:0];
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

- (IBAction)btn_dissolved_click:(id)sender {
    if (self.delegate&&[self.delegate respondsToSelector:@selector(exitGang)]) {
        [self dismissViewController];
        [self.delegate exitGang];
    }
}
@end
