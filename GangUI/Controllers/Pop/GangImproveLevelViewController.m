//
//  GangImproveLevelViewController.m
//  GangSDK
//
//  Created by codone on 2017/8/11.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangImproveLevelViewController.h"


@interface GangImproveLevelViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_content_level;
@property (weak, nonatomic) IBOutlet UILabel *label_content_num;
@property (weak, nonatomic) IBOutlet UILabel *label_info;
@property (weak, nonatomic) IBOutlet UIButton *btn_sure;
@property (weak, nonatomic) IBOutlet UIButton *btn_cancel;

@end

@implementation GangImproveLevelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.label_title.text = [GangTools getLocalizationOfKey:@"升级"];
    self.label_title.textColor = [UIColor colorFromHexRGB:GangColor_pop_upLevel_title];
    [self.btn_sure setTitle:[GangTools getLocalizationOfKey:@"确认"] forState:UIControlStateNormal];
    [self.btn_sure setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_confirmButton] forState:UIControlStateNormal];
    [self.btn_cancel setTitle:[GangTools getLocalizationOfKey:@"取消"] forState:UIControlStateNormal];
    [self.btn_cancel setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_cancelButton] forState:UIControlStateNormal];
    
    
    NSMutableAttributedString *ats = [[NSMutableAttributedString alloc] init];
    [ats appendAttributedString:[GangTools getshowContent:[NSString stringWithFormat:@"%@等级：",GangSDKInstance.settingBean.data.gamevariable.gangname] textColor:[UIColor colorFromHexRGB:GangColor_pop_upLevel_content] font:[UIFont systemFontOfSize:13] lineSpace:4 paraSpace:0]];
    [ats appendAttributedString:[GangTools getshowContent:[NSString stringWithFormat:@"L%ld>>>L%ld",(long)self.levelNow,(long)self.levelNow+1] textColor:[UIColor colorFromHexRGB:GangColor_pop_upLevel_contentKey] font:[UIFont systemFontOfSize:13] lineSpace:4 paraSpace:0]];
    self.label_content_num.attributedText = ats;
    
    ats = [[NSMutableAttributedString alloc] init];
    [ats appendAttributedString:[GangTools getshowContent:@"人数提升：" textColor:[UIColor colorFromHexRGB:GangColor_pop_upLevel_content] font:[UIFont systemFontOfSize:13] lineSpace:4 paraSpace:0]];
    [ats appendAttributedString:[GangTools getshowContent:[NSString stringWithFormat:@"%d>>>%d",((GangLevelListBean*)GangSDKInstance.settingBean.data.consortialevellist[self.levelNow-1]).maxnum,((GangLevelListBean*)GangSDKInstance.settingBean.data.consortialevellist[self.levelNow]).maxnum] textColor:[UIColor colorFromHexRGB:GangColor_pop_upLevel_contentKey] font:[UIFont systemFontOfSize:13] lineSpace:4 paraSpace:0]];
    self.label_content_level.attributedText = ats;
    
    ats = [[NSMutableAttributedString alloc] init];
    NSString *info = GangSDKInstance.settingBean.data.gameprompt.consortia_up_level;
    if (info) {
        NSArray *array_info = [info componentsSeparatedByString:@"{$gangname$}"];
        [array_info enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *array_info2 = [obj componentsSeparatedByString:@"{$moneyname$}"];
            [array_info2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [ats appendAttributedString:[GangTools getshowContent:obj textColor:[UIColor colorFromHexRGB:GangColor_pop_upLevel_info] font:[UIFont systemFontOfSize:11] lineSpace:0 paraSpace:0]];
                if (idx!=array_info2.count-1) {
                    [ats appendAttributedString:[GangTools getshowContent:GangSDKInstance.settingBean.data.gamevariable.moneyname textColor:[UIColor colorFromHexRGB:GangColor_pop_upLevel_info] font:[UIFont systemFontOfSize:11] lineSpace:0 paraSpace:0]];
                }
            }];
            if (idx!=array_info.count-1) {
                [ats appendAttributedString:[GangTools getshowContent:GangSDKInstance.settingBean.data.gamevariable.gangname textColor:[UIColor colorFromHexRGB:GangColor_pop_upLevel_info] font:[UIFont systemFontOfSize:11] lineSpace:0 paraSpace:0]];
            }
        }];
    }
    self.label_info.attributedText = ats;
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

- (IBAction)btn_upLevel_click:(id)sender {
    self.btn_sure.enabled = NO;
    [self gang_loading:@"正在提交数据"];
    [GangSDKInstance.groupManager improveGangLevel:^(id  _Nullable data) {
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
