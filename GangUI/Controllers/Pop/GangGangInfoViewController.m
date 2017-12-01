//
//  GangGangInfoViewController.m
//  GangSDK
//
//  Created by 雪狼 on 2017/8/3.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangGangInfoViewController.h"
#import <GangSupport/MGWebImage.h>
@interface GangGangInfoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UILabel *label_gangName;
@property (weak, nonatomic) IBOutlet UILabel *label_consortiaId;
@property (weak, nonatomic) IBOutlet UILabel *label_gangChairman;
@property (weak, nonatomic) IBOutlet UILabel *label_gangLevel;
@property (weak, nonatomic) IBOutlet UILabel *label_buildLevel;
@property (weak, nonatomic) IBOutlet UILabel *label_gangMember;
@property (weak, nonatomic) IBOutlet UILabel *label_activityNum;
@property (weak, nonatomic) IBOutlet UILabel *label_wealthNum;
@property (weak, nonatomic) IBOutlet UIImageView *iv_gangAvatar;
@property (weak, nonatomic) IBOutlet UILabel *label_gangDeclaration;
@property (weak, nonatomic) IBOutlet UILabel *label_declaration;


@end

@implementation GangGangInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)setTheSubviews{
    [super setTheSubviews];
    //标题字体颜色
    [self.label_title setTextColor:[UIColor colorFromHexRGB:GangColor_pop_gangInfo_title]];
    //社群名称ID字体颜色
    [self.label_gangName setTextColor:[UIColor colorFromHexRGB:GangColor_pop_gangInfo_name]];
    [self.label_consortiaId setTextColor:[UIColor colorFromHexRGB:GangColor_pop_gangInfo_name]];
   
    [self.label_gangChairman setTextColor:[UIColor colorFromHexRGB:GangColor_pop_gangInfo_content]];
    [self.label_gangLevel setTextColor:[UIColor colorFromHexRGB:GangColor_pop_gangInfo_content]];
    [self.label_buildLevel setTextColor:[UIColor colorFromHexRGB:GangColor_pop_gangInfo_content]];
    [self.label_gangMember setTextColor:[UIColor colorFromHexRGB:GangColor_pop_gangInfo_content]];
    [self.label_activityNum setTextColor:[UIColor colorFromHexRGB:GangColor_pop_gangInfo_content]];
    [self.label_wealthNum setTextColor:[UIColor colorFromHexRGB:GangColor_pop_gangInfo_content]];
    [self.label_gangDeclaration setTextColor:[UIColor colorFromHexRGB:GangColor_pop_gangInfo_content]];
    [self.label_declaration setTextColor:[UIColor colorFromHexRGB:GangColor_pop_gangInfo_content]];
    [self getData];
}

-(void)getData{
    [[UIApplication sharedApplication].keyWindow showLoadingWithInfo:[GangTools getLocalizationOfKey:@"正在获取信息"]];
    [GangSDKInstance.groupManager getGangInfoWithConsortiaid:self.consortiaid success:^(GangInfoBean *result) {
        [[UIApplication sharedApplication].keyWindow removeLoading];
        self.label_gangName.text = [NSString stringWithFormat:@"%@:%@",GangSDKInstance.settingBean.data.gamevariable.gangname,result.data.consortianame];
        self.label_consortiaId.text = [NSString stringWithFormat:@"ID:%@",result.data.consortiaid];
        self.label_gangChairman.text = [NSString stringWithFormat:@"管理:%@",result.data.chairman];
        self.label_gangLevel.text = [NSString stringWithFormat:@"等级:%ld级",(long)result.data.buildlevel];
        self.label_wealthNum.text = [NSString stringWithFormat:@"财富:%ld",(long)result.data.moneynum];
        self.label_buildLevel.text = [NSString stringWithFormat:@"建设:%ld",(long)result.data.buildnum];
        self.label_gangMember.text = [NSString stringWithFormat:@"成员:%ld/%ld",(long)result.data.nownum,(long)result.data.maxnum];
        self.label_activityNum.text = [NSString stringWithFormat:@"活跃:%ld",(long)result.data.activelevel];
        self.label_declaration.text = result.data.declaration;
        [self.iv_gangAvatar setImageWithURLString:result.data.iconurl];
    } fail:^(NSError * _Nullable error) {
        [[UIApplication sharedApplication].keyWindow removeLoading];
        [self gang_toast:[GangTools getLocalizationOfKey:@"获取信息失败!"]];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - buttonAction
- (IBAction)btn_closeClick:(UIButton *)sender {
    [self dismissViewController];
}

@end
