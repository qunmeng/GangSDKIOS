//
//  GangManageViewController.m
//  GangSDK
//
//  Created by codone on 2017/7/31.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangManageViewController.h"
#import "GangManageApplyViewController.h"
#import <GangSupport/MGWebImage.h>
#import "GangUpdateGangNameViewController.h"
#import "GangImproveLevelViewController.h"
#import "GangEditGangTipsViewController.h"
#import "GangDissolvedViewController.h"
#import "GangEditDeclarationViewController.h"

#import "GangManageRoleAccessViewController.h"
#import "GangMakesureViewController.h"
#import "GangOutViewController.h"
#import "GangNormalRefreshScrollView.h"

@interface GangManageViewController ()<GangMakeSureDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,GangDissolvedViewControllerDelegate,ScrollViewRefreshDelegate>{
    BOOL isNeedApply;
    GangInfoBeanData *gangInfo;
}
@property (weak, nonatomic) IBOutlet UIButton *btn_applyList;
@property (weak, nonatomic) IBOutlet UIButton *btn_positionManage;
@property (weak, nonatomic) IBOutlet GangNormalRefreshScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btn_reload;
@property (weak, nonatomic) IBOutlet UIImageView *iv_gangIcon;
@property (weak, nonatomic) IBOutlet UILabel *label_title_gangName;
@property (weak, nonatomic) IBOutlet UILabel *label_gangName;
@property (weak, nonatomic) IBOutlet UILabel *label_title_gangLevel;
@property (weak, nonatomic) IBOutlet UILabel *label_gangLevel;
@property (weak, nonatomic) IBOutlet UILabel *label_gangTips;
@property (weak, nonatomic) IBOutlet UILabel *label_dreamWord;
@property (weak, nonatomic) IBOutlet UIButton *sb_gangApply;
@property (weak, nonatomic) IBOutlet UILabel *label_title_tips;
@property (weak, nonatomic) IBOutlet UILabel *label_title_dreamWord;
@property (weak, nonatomic) IBOutlet UILabel *label_title_gangApply;
@property (weak, nonatomic) IBOutlet UIButton *btn_gangApply;
@property (weak, nonatomic) IBOutlet UIButton *btn_disoveGang;

@property (weak, nonatomic) IBOutlet UIButton *btn_editName;
@property (weak, nonatomic) IBOutlet UIButton *btn_upLevel;
@property (weak, nonatomic) IBOutlet UIButton *btn_editTips;
@property (weak, nonatomic) IBOutlet UIButton *btn_editWord;
@property (weak, nonatomic) IBOutlet UIButton *btn_apply;
@property (weak, nonatomic) IBOutlet UIButton *btn_exitGang;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_tips;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_dreamWord;

@end

@implementation GangManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)setTheDatas{
    [super setTheDatas];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshGangInfo) name:Gang_notify_infoChanged object:nil];
}

-(void)setTheSubviews{
    [super setTheSubviews];
    [self.btn_applyList setTitleColor:[UIColor colorFromHexRGB:GangColor_gangManage_btn_applyList] forState:UIControlStateNormal];
    [self.btn_applyList setTitle:[GangTools getLocalizationOfKey:@"申请列表"] forState:UIControlStateNormal];
    
    [self.btn_positionManage setTitleColor:[UIColor colorFromHexRGB:GangColor_gangManage_btn_positionManager] forState:UIControlStateNormal];
    [self.btn_positionManage setTitle:[GangTools getLocalizationOfKey:@"职位管理"] forState:UIControlStateNormal];
    
    self.label_title_gangName.textColor = [UIColor colorFromHexRGB:GangColor_gangManage_name];
    self.label_gangName.textColor = [UIColor colorFromHexRGB:GangColor_gangManage_name];
    self.label_title_gangName.text = [NSString stringWithFormat:@"%@：",[GangTools getLocalizationOfKey:@"名称"]];
    
    self.label_title_gangLevel.textColor = [UIColor colorFromHexRGB:GangColor_gangManage_level];
    self.label_title_gangLevel.text = [NSString stringWithFormat:@"%@：",[GangTools getLocalizationOfKey:@"等级"]];
    self.label_gangLevel.textColor = [UIColor colorFromHexRGB:GangColor_gangManage_level];
    
    self.label_gangTips.textColor = [UIColor colorFromHexRGB:GangColor_gangManage_tips];
    self.label_dreamWord.textColor = [UIColor colorFromHexRGB:GangColor_gangManage_declaration];
    
    self.label_title_tips.textColor = [UIColor colorFromHexRGB:GangColor_gangManage_tipsTitle];
    self.label_title_tips.text = [GangTools getLocalizationOfKey:@"公告"];
    self.label_title_dreamWord.textColor = [UIColor colorFromHexRGB:GangColor_gangManage_declarationTitle];
    self.label_title_dreamWord.text = [GangTools getLocalizationOfKey:@"宣言"];
    
    self.label_title_gangApply.textColor = [UIColor colorFromHexRGB:GangColor_gangManage_apply_title];
    self.label_title_gangApply.text = [GangTools getLocalizationOfKey:@"入会审批"];
    
    [self.btn_editName setTitleColor:[UIColor colorFromHexRGB:GangColor_gangManage_editName] forState:UIControlStateNormal];
    [self.btn_editName setTitle:[GangTools getLocalizationOfKey:@"改名"] forState:UIControlStateNormal];
    
    [self.btn_upLevel setTitleColor:[UIColor colorFromHexRGB:GangColor_gangManage_levelUp] forState:UIControlStateNormal];
    [self.btn_upLevel setTitle:[GangTools getLocalizationOfKey:@"升级"] forState:UIControlStateNormal];
    
    [self.btn_editTips setTitleColor:[UIColor colorFromHexRGB:GangColor_gangManage_btn_editTip] forState:UIControlStateNormal];
    [self.btn_editTips setTitle:[GangTools getLocalizationOfKey:@"编辑"] forState:UIControlStateNormal];
    
    [self.btn_editWord setTitleColor:[UIColor colorFromHexRGB:GangColor_gangManage_btn_editDeclaration] forState:UIControlStateNormal];
    [self.btn_editWord setTitle:[GangTools getLocalizationOfKey:@"编辑"] forState:UIControlStateNormal];
   
    [self.btn_disoveGang setTitleColor:[UIColor colorFromHexRGB:GangColor_gangManage_btn_disove] forState:UIControlStateNormal];
    [self.btn_disoveGang setTitle:[NSString stringWithFormat:@"%@%@",[GangTools getLocalizationOfKey:@"解散"],GangSDKInstance.settingBean.data.gamevariable.gangname] forState:UIControlStateNormal];
    
    self.scrollView.refreshDelegate = self;
}

-(void)refreshGangInfo{
    [self.scrollView startRefresh];
}

- (IBAction)btn_reload_click:(id)sender {
    [self refreshGangInfo];
}

-(void)refreshTheControllerNoJudge:(BOOL)noJudge{
    if (noJudge) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        [self.scrollView startRefresh];
    }else if (!self.hasRefreshed) {
        [self.scrollView startRefresh];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//申请列表
- (IBAction)btn_invents_click:(id)sender {
    [self pushViewController:[[GangManageApplyViewController alloc] init]];
}
//职位管理
- (IBAction)btn_manage_click:(id)sender {
    [self pushViewController:[[GangManageRoleAccessViewController alloc] init]];
}

//修改图标
- (IBAction)iv_gangIcon_tap:(id)sender {
    GangMakesureViewController *vc = [[GangMakesureViewController alloc] init];
    NSMutableAttributedString *ats = [[NSMutableAttributedString alloc] init];
    NSString *info = GangSDKInstance.settingBean.data.gameprompt.modify_consortia_icon;
    if (info) {
        NSArray *array_info = [info componentsSeparatedByString:@"{$gangname$}"];
        [array_info enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *array_info2 = [obj componentsSeparatedByString:@"{$moneyname$}"];
            [array_info2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [ats appendAttributedString:[GangTools getshowContent:obj textColor:[UIColor colorFromHexRGB:GangColor_pop_alert_content] font:[UIFont systemFontOfSize:14] lineSpace:12 paraSpace:0]];
                if (idx!=array_info2.count-1) {
                    [ats appendAttributedString:[GangTools getshowContent:GangSDKInstance.settingBean.data.gamevariable.moneyname textColor:[UIColor colorFromHexRGB:GangColor_pop_alert_content] font:[UIFont systemFontOfSize:14] lineSpace:4 paraSpace:0]];
                }
            }];
            if (idx!=array_info.count-1) {
                [ats appendAttributedString:[GangTools getshowContent:GangSDKInstance.settingBean.data.gamevariable.gangname textColor:[UIColor colorFromHexRGB:GangColor_pop_alert_content] font:[UIFont systemFontOfSize:14] lineSpace:4 paraSpace:0]];
            }
        }];
    }
    vc.info = ats;
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma makesure delegate
-(void)makeSureClick{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"修改头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机拍摄",@"相册选取", nil];
    [sheet showInView:self.view];
}

#pragma ActionSheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([@"相机拍摄" isEqualToString:[actionSheet buttonTitleAtIndex:buttonIndex]]) {
        UIImagePickerController *vc = [[UIImagePickerController alloc] init];
        vc.sourceType = UIImagePickerControllerSourceTypeCamera;
        vc.delegate = self;
        vc.allowsEditing = YES;
        [self presentViewController:vc animated:YES completion:nil];
    }else if ([@"相册选取" isEqualToString:[actionSheet buttonTitleAtIndex:buttonIndex]]) {
        UIImagePickerController *vc = [[UIImagePickerController alloc] init];
        vc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        vc.delegate = self;
        vc.allowsEditing = YES;
        [self presentViewController:vc animated:YES completion:nil];
    }
}

#pragma picker delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self uploadImageData:UIImageJPEGRepresentation([(UIImage*)info[UIImagePickerControllerEditedImage] imageCompressForSize:CGSizeMake(120, 120)], 0.8)];
}


-(void)uploadImageData:(id)data{
    [self gang_loading:@"正在提交数据"];
    [GangSDKInstance.groupManager updateGangIcon:data success:^(GangUploadBean * _Nullable data) {
        [self gang_removeLoading];
        [self.iv_gangIcon setImageWithURLString:data.data.iconurl];
    } fail:^(NSError * _Nullable error) {
        [self gang_removeLoading];
        if (error){
            [self gang_toast:error.domain];
        }
    } progress:^(double percent) {
        [self gang_updataLoading:[NSString stringWithFormat:@"已提交:%d%%",(int)(percent*100)]];
    }];
}

//改名
- (IBAction)btn_changeName_click:(id)sender {
    [self presentViewController:[[GangUpdateGangNameViewController alloc] init] animated:YES completion:nil];
}
//升级
- (IBAction)btn_upLevel_click:(id)sender {
    GangImproveLevelViewController *vc = [[GangImproveLevelViewController alloc] init];
    vc.levelNow = gangInfo.buildlevel;
    GangLevelListBean *level = [GangSDKInstance.settingBean.data.consortialevellist lastObject];
    if (level.buildlevel==gangInfo.buildlevel) {
        [self gang_toast:[GangTools getLocalizationOfKey:@"已经是最高等级!"]];
    }else{
        [self presentViewController:vc animated:YES completion:nil];
    }
}
//编辑公告
- (IBAction)btn_editGangTips_click:(id)sender {
    [self presentViewController:[[GangEditGangTipsViewController alloc] init] animated:YES completion:nil];
}
//编辑宣言
- (IBAction)btn_editDreamWord_click:(id)sender {
    [self presentViewController:[[GangEditDeclarationViewController alloc] init] animated:YES completion:nil];
}
//入会审批
- (IBAction)btn_joinGangSwitch_click:(id)sender {
    [self gang_loading:@"正在提交数据"];
    [GangSDKInstance.groupManager changeGangApplySwitch:!isNeedApply success:^(id  _Nullable data) {
        [self gang_removeLoading];
        [self changeSwitch:!isNeedApply];
    } failure:^(NSError * _Nullable error) {
        [self gang_removeLoading];
        if (error){
            [self gang_toast:error.domain];
        }
    }];
}

-(void)changeSwitch:(BOOL)on{
    isNeedApply = on;
    if (isNeedApply) {
        [self.btn_gangApply setBackgroundImage:[UIImage imageNamed:@"qm_btn_manager_open_approve"] forState:UIControlStateNormal];
    }else{
        [self.btn_gangApply setBackgroundImage:[UIImage imageNamed:@"qm_btn_manager_close_approve"] forState:UIControlStateNormal];
    }
}

#pragma refreshDelegate
-(void)refreshDatas:(id)sender{
    self.btn_reload.hidden = YES;
    [GangSDKInstance.groupManager getGangInfoWithConsortiaid:GangSDKInstance.userBean.data.consortiaid success:^(GangInfoBean *data) {
        self.hasRefreshed = YES;
        [self.scrollView endRefresh];
        gangInfo = data.data;
        [self.iv_gangIcon setImageWithURLString:data.data.iconurl];
        self.label_gangName.text =data.data.consortianame;
        self.label_gangLevel.text = [NSString stringWithFormat:@"%ld",(long)data.data.buildlevel];
        if (data.data.announcements.count>0) {
            self.label_gangTips.text = [(GangTipsBean*)data.data.announcements[0] content];
            CGSize size = [self.label_gangTips sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width-(320-48), 0)];
            self.constraint_height_tips.constant = size.height>40?size.height:40;
        }
        self.label_dreamWord.text = data.data.declaration;
        CGSize size = [self.label_dreamWord sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width-(320-48), 0)];
        self.constraint_height_dreamWord.constant = size.height>40?size.height:40;
        [self changeSwitch:data.data.isneedapprove];
    } fail:^(NSError * _Nullable error) {
        [self.scrollView endRefresh];
        self.btn_reload.hidden = NO;
        if (error) {
            [self gang_toast:error.domain];
        }
    }];
}

//解散社群
- (IBAction)btn_offGang_click:(id)sender {
    GangDissolvedViewController *vc = [[GangDissolvedViewController alloc] init];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma delegate
-(void)deletedGang{
    [self gang_loading:@"正在提交数据"];
    [GangSDKInstance.groupManager dissolvedGang:^(id  _Nullable data) {
        [self gang_removeLoading];
        [self pushViewController:[[GangOutViewController alloc] init]];
    } failure:^(NSError * _Nullable error) {
        [self gang_removeLoading];
        if (error){
            [self gang_toast:error.domain];
        }
    }];
}

@end
