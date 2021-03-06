//
//  GangMemberInfoViewController.m
//  GangSDK
//
//  Created by codone on 2017/8/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangMemberInfoViewController.h"
#import "GangMakesureViewController.h"
#import "GangMuteView.h"
#import <GangSupport/MGWebImage.h>
#import "GangGangInfoViewController.h"
#import "GangMembersGamesCollectionViewCell.h"
#import "GangGameDownloadOrStartViewController.h"
@interface GangMemberInfoViewController ()<GangMakeSureDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>{
    int actionType;
    GangUserBean *userInfo;
    NSInteger muteType;
    NSInteger positionType;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_statusBar;

@end

@implementation GangMemberInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)setTheDatas{
    [super setTheDatas];
    [self getData];
}

-(void)setTheSubviews{
    [super setTheSubviews];
    if (GangUIInstance.needFitIphoneX) {
        self.constraint_height_statusBar.constant += 10;
    }
    
    self.label_titleView.font = [UIFont fontWithName:GangFont_title size:GangFontSize_title];
    self.label_titleView.textColor = [UIColor colorFromHexRGB:GangColor_title];
    self.label_titleView.text = [GangTools getLocalizationOfKey:@"玩家信息"];
    
    [self.label_gangName setTextColor:[UIColor colorFromHexRGB:GangColor_userinfo_gangName]];
    [self.label_level setTextColor:[UIColor colorFromHexRGB:GangColor_userinfo_level]];
    self.label_nickname.textColor = [UIColor colorFromHexRGB:GangColor_userinfo_name];
    self.label_role.textColor = [UIColor colorFromHexRGB:GangColor_userinfo_role];
    self.label_position.textColor = [UIColor colorFromHexRGB:GangColor_userinfo_position];
    [self.btn_kickOut setTitleColor:[UIColor colorFromHexRGB:GangColor_userinfo_btn_kickout] forState:UIControlStateNormal];
    [self.btn_kickOut setTitle:[NSString stringWithFormat:@"%@%@",[GangTools getLocalizationOfKey:@"踢出"],GangSDKInstance.settingBean.data.gamevariable.gangname] forState:UIControlStateNormal];
    [self.btn_setChairman setTitleColor:[UIColor colorFromHexRGB:GangColor_userinfo_btn_transfer_owner] forState:UIControlStateNormal];
    [self.btn_setChairman setTitle:[NSString stringWithFormat:@"%@%@",GangSDKInstance.settingBean.data.gamevariable.gangname,[GangTools getLocalizationOfKey:@"转让"]]forState:UIControlStateNormal];
    
    [self.btn_dynamic setTitle:@"动态" forState:UIControlStateNormal];
    [self.btn_dynamic setTitleColor:[UIColor colorFromHexRGB:GangColor_userinfo_btn_dynamic] forState:UIControlStateNormal];
    
    [self.btn_details setTitleColor:[UIColor colorFromHexRGB:GangColor_userinfo_btn_details] forState:UIControlStateNormal];
    
    self.label_weekContribute.textColor = [UIColor colorFromHexRGB:GangColor_userinfo_contributeNum];
    self.label_contributeNum.textColor = [UIColor colorFromHexRGB:GangColor_userinfo_contributeNum];
    self.label_activeNum.textColor = [UIColor colorFromHexRGB:GangColor_userinfo_activeNum];

    self.label_title_mute.textColor = [UIColor colorFromHexRGB:GangColor_userinfo_itemTitle];
    self.label_title_position.textColor = [UIColor colorFromHexRGB:GangColor_userinfo_itemTitle];
    self.label_title_gameName.textColor = [UIColor colorFromHexRGB:GangColor_userinfo_itemTitle];
    
    [self.iv_head addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap_changeHeadIcon:)]];
    
    //注册单元格 设置背景图片
    [self.collectionView registerNib:[UINib nibWithNibName:@"GangMembersGamesCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"gangMembersGamesCollectionViewCell"];
}

-(void)getData{
    self.btn_reload.hidden = YES;
    [self gang_loading:@"正在获取数据"];
    [GangSDKInstance.memberManager getGangMemeberInfoWithTargetUserid:self.userid success:^(GangUserBean  *_Nullable data) {
        [self gang_removeLoading];
        userInfo = data;
        float itemWidth = ([UIScreen mainScreen].bounds.size.width - 34*2-17*3)/4;
        float itemHeight = (65/48)*itemWidth;
        if (userInfo.data.playgamelist.count == 0) {
            self.constraint_height_collectionview.constant = itemHeight+26;
        } else if (userInfo.data.playgamelist.count %4 == 0) {
            self.constraint_height_collectionview.constant = (userInfo.data.playgamelist.count/4)*itemHeight+26+((userInfo.data.playgamelist.count/4)-1)*10;
        } else {
            self.constraint_height_collectionview.constant = ceil((float)userInfo.data.playgamelist.count/4)*itemHeight+26+(ceil((float)userInfo.data.playgamelist.count/4)-1)*10;
        }
        if (self.consortiaid.integerValue >0 &&[GangSDKInstance.userBean.data.consortiaid isEqualToString:self.consortiaid]) {
            [self.btn_details setTitle:@"详情" forState:UIControlStateNormal];
            [self.iv_head setImageWithURLString:userInfo.data.iconurl];
            self.label_nickname.text = userInfo.data.nickname;
            self.view_level.hidden = userInfo.data.gamelevel==0;
            self.label_level.text = [NSString stringWithFormat:@"Lv.%ld",(long)userInfo.data.gamelevel];
            switch (userInfo.data.rolelevel) {
                case 1:
                    self.iv_bg_position.image = [UIImage imageNamed:@"qm_bg_role1"];
                    break;
                case 10:
                    self.iv_bg_position.image = [UIImage imageNamed:@"qm_bg_role3"];
                    break;
                default:
                    self.iv_bg_position.image = [UIImage imageNamed:@"qm_bg_role2"];
                    break;
            }
            self.label_gangName.text = userInfo.data.consortianame;
            self.label_position.text = userInfo.data.rolename;
            self.label_role.text = userInfo.data.gamerole;
            self.label_contributeNum.text = [NSString stringWithFormat:@"%@:%ld",[GangTools getLocalizationOfKey:@"总贡献"],(long)userInfo.data.contributenum];
            self.label_activeNum.text = [NSString stringWithFormat:@"%@:%ld",[GangTools getLocalizationOfKey:@"活跃度"],(long)userInfo.data.activenum];
            self.label_weekContribute.text = [NSString stringWithFormat:@"%@:%ld",[GangTools getLocalizationOfKey:@"周贡献"],(long)userInfo.data.weekcontributenum];
            [self setupMuteView];
            [self setupPositionView];
            self.scrollView.hidden = NO;
        } else if (self.consortiaid.integerValue ==0){
            self.btn_details.hidden = YES;
            [self.iv_head setImageWithURLString:userInfo.data.iconurl];
            self.label_nickname.text = userInfo.data.nickname;
            self.view_level.hidden = userInfo.data.gamelevel==0;
            self.label_level.text = [NSString stringWithFormat:@"Lv.%ld",(long)userInfo.data.gamelevel];
            self.label_role.text = userInfo.data.gamerole;
            self.label_position.text = userInfo.data.rolename;
            self.label_contributeNum.text = [NSString stringWithFormat:@"%@:%ld",[GangTools getLocalizationOfKey:@"总贡献"],(long)userInfo.data.contributenum];
            self.label_activeNum.text = [NSString stringWithFormat:@"%@:%ld",[GangTools getLocalizationOfKey:@"活跃度"],(long)userInfo.data.activenum];
            self.label_weekContribute.text = [NSString stringWithFormat:@"%@:%ld",[GangTools getLocalizationOfKey:@"周贡献"],(long)userInfo.data.weekcontributenum];
            self.view_userPosition.hidden = YES;
            self.view_gangName.hidden = YES;
            [self hiddenView];
            self.scrollView.hidden = NO;
        } else {
            [self.btn_details setTitle:@"详情" forState:UIControlStateNormal];
            [self.iv_head setImageWithURLString:userInfo.data.iconurl];
            self.label_nickname.text = userInfo.data.nickname;
            self.view_level.hidden = userInfo.data.gamelevel==0;
            self.label_level.text = [NSString stringWithFormat:@"Lv.%ld",(long)userInfo.data.gamelevel];
            switch (userInfo.data.rolelevel) {
                case 1:
                    self.iv_bg_position.image = [UIImage imageNamed:@"qm_bg_role1"];
                    break;
                case 10:
                    self.iv_bg_position.image = [UIImage imageNamed:@"qm_bg_role3"];
                    break;
                default:
                    self.iv_bg_position.image = [UIImage imageNamed:@"qm_bg_role2"];
                    break;
            }
            self.label_gangName.text = userInfo.data.consortianame;
            self.label_position.text = userInfo.data.rolename;
            self.label_role.text = userInfo.data.gamerole;
            self.label_contributeNum.text = [NSString stringWithFormat:@"%@:%ld",[GangTools getLocalizationOfKey:@"总贡献"],(long)userInfo.data.contributenum];
            self.label_activeNum.text = [NSString stringWithFormat:@"%@:%ld",[GangTools getLocalizationOfKey:@"活跃度"],(long)userInfo.data.activenum];
            self.label_weekContribute.text = [NSString stringWithFormat:@"%@:%ld",[GangTools getLocalizationOfKey:@"周贡献"],(long)userInfo.data.weekcontributenum];
            [self hiddenView];
            self.scrollView.hidden = NO;
        }
        [self.collectionView reloadData];
    } fail:^(NSError * _Nullable error) {
        [self gang_removeLoading];
        self.btn_reload.hidden = NO;
        if (error) {
            [self gang_toast:error.domain];
        }
    }];
}

- (void)hiddenView{
    self.constraint_height_view_userinfo.constant = 120;
    self.view_settingBtn.hidden = YES;
    self.constraint_spacing_view_settingBtn.constant = 0;
    self.view_settingMute.hidden = YES;
    self.constraint_height_view_muteTitle.constant = 0;
    self.constraint_spacing_view_mute.constant = 0;
    self.constraint_height_view_mute.constant = 0;
    self.view_settingPosition.hidden = YES;
    self.constraint_height_view_positionTitle.constant = 0;
    self.constraint_spacing_view_position.constant = 0;
    self.constraint_height_view_position.constant = 0;
}

-(void)setupMuteView{
    NSMutableArray *array_muteSetting = [NSMutableArray arrayWithObject:@(0)];
    [array_muteSetting addObjectsFromArray:GangSDKInstance.settingBean.data.gameconfig.speak_forbbiden_time_list];
    [array_muteSetting enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (userInfo.data.keeptime==[obj integerValue]) {
            *stop = YES;
        }else if (array_muteSetting.count-1==idx) {
            [array_muteSetting addObject:@(userInfo.data.keeptime)];
            *stop = YES;
        }
    }];
    
    [self.view_mute removeAllSubViews];
    float widthMax = [UIScreen mainScreen].bounds.size.width-48;
    float x = 0;
    float y = 13;
    for (int i=0; i<array_muteSetting.count; i++) {
        GangMuteView *v = [GangMuteView createAGangMuteView];
        v.frame = CGRectMake(0, 0, 56, 24);
        [v.btn setBackgroundImage:[UIImage imageNamed:@"qm_btn_memberinfo_mute_normal"] forState:UIControlStateNormal];
        [v.btn setTitleColor:[UIColor colorFromHexRGB:GangColor_userinfo_mute_normal] forState:UIControlStateNormal];
        v.btn.tag = i;
        if (userInfo.data.keeptime==[self getMuteSecondsFormMuteIndex:i]) {
            [v.btn setBackgroundImage:[UIImage imageNamed:@"qm_btn_memberinfo_mute_selected"] forState:UIControlStateNormal];
            [v.btn setTitleColor:[UIColor colorFromHexRGB:GangColor_userinfo_mute_selected] forState:UIControlStateNormal];
        }
        [v.btn setTitle:[self getMuteTimeStringFromIndex:i] forState:UIControlStateNormal];
        [v.btn addTarget:self action:@selector(muteClick:) forControlEvents:UIControlEventTouchUpInside];
        if (x+v.bounds.size.width>widthMax) {
            x = 0;
            y += v.bounds.size.height+8;
        }
        CGRect frame = v.frame;
        frame.origin.x = x;
        frame.origin.y = y;
        v.frame = frame;
        [self.view_mute addSubview:v];
        x += v.bounds.size.width;
        x += 11.5;
    }
    self.constraint_height_view_mute.constant = 37+y;
}

-(NSString*)getMuteTimeStringFromIndex:(NSInteger)index{
    NSInteger seconds = [self getMuteSecondsFormMuteIndex:index];
    NSString *overString = @"";
    if (0==seconds) {
        overString = @"解禁";
    }else if (-1==seconds) {
        overString = @"永久";
    }else{
        NSInteger day = 24*60*60;
        if (seconds>=day) {
            overString = [overString stringByAppendingString:[NSString stringWithFormat:@"%ld天",(long)seconds/day]];
        }
        seconds = seconds%day;
        NSInteger hour = 60*60;
        if (seconds>=hour) {
            overString = [overString stringByAppendingString:[NSString stringWithFormat:@"%ld小时",(long)seconds/hour]];
        }
        seconds = seconds%hour;
        NSInteger minute = 60;
        if (seconds>=minute) {
            overString = [overString stringByAppendingString:[NSString stringWithFormat:@"%ld分钟",(long)seconds/minute]];
        }
        seconds = seconds%minute;
        if (seconds>0) {
            overString = [overString stringByAppendingString:[NSString stringWithFormat:@"%ld秒",(long)seconds]];
        }
    }
    return overString;
}
-(NSInteger)getMuteSecondsFormMuteIndex:(NSInteger)index{
    NSMutableArray *array_muteSetting = [NSMutableArray arrayWithObject:@(0)];
    [array_muteSetting addObjectsFromArray:GangSDKInstance.settingBean.data.gameconfig.speak_forbbiden_time_list];
    [array_muteSetting enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (userInfo.data.keeptime==[obj integerValue]) {
            *stop = YES;
        }else if (array_muteSetting.count-1==idx) {
            [array_muteSetting addObject:@(userInfo.data.keeptime)];
            *stop = YES;
        }
    }];
    return [array_muteSetting[index] integerValue];
}

-(void)muteClick:(UIButton*)button{
    muteType = button.tag;
    GangMakesureViewController *vc = [[GangMakesureViewController alloc] init];
    NSMutableAttributedString *ats = [[NSMutableAttributedString alloc] init];
    NSString *info = GangSDKInstance.settingBean.data.gameprompt.stop_speak;
    if (info) {
        NSArray *array_info = [info componentsSeparatedByString:@"{$nickname$}"];
        [array_info enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [ats appendAttributedString:[GangTools getshowContent:obj textColor:[UIColor colorFromHexRGB:GangColor_pop_alert_content] font:[UIFont systemFontOfSize:16] lineSpace:12 paraSpace:0]];
            if (idx!=array_info.count-1) {
                [ats appendAttributedString:[GangTools getshowContent:userInfo.data.nickname textColor:[UIColor colorFromHexRGB:GangColor_pop_alert_contentKey] font:[UIFont systemFontOfSize:16] lineSpace:4 paraSpace:0]];
            }
        }];
    }
    [ats appendAttributedString:[GangTools getshowContent:0==muteType?@"\n解禁":[NSString stringWithFormat:@"\n%@",[self getMuteTimeStringFromIndex:muteType]] textColor:[UIColor  colorFromHexRGB:GangColor_pop_alert_contentKey] font:[UIFont systemFontOfSize:16] lineSpace:4 paraSpace:0]];
    [ats appendAttributedString:[GangTools getshowContent:@"?" textColor:[UIColor colorFromHexRGB:GangColor_pop_alert_content] font:[UIFont systemFontOfSize:16] lineSpace:13 paraSpace:0]];
    vc.info = ats;
    vc.delegate = self;
    actionType = 0==muteType?4:5;
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)setupPositionView{
    [self.view_position removeAllSubViews];
    float widthMax = [UIScreen mainScreen].bounds.size.width-50;
    float x = 0;
    float y = 13;
    for (int i=0; i<userInfo.data.rolelist.count; i++) {
        GangMuteView *v = [GangMuteView createAGangMuteView];
        v.frame = CGRectMake(0, 0, 69, 24);
        v.btn.tag = i;
        [v.btn setBackgroundImage:[UIImage imageNamed:@"qm_btn_memberinfo_position_normal"] forState:UIControlStateNormal];
        [v.btn setTitleColor:[UIColor colorFromHexRGB:GangColor_userinfo_position_normal] forState:UIControlStateNormal];
        if ([userInfo.data.rolename isEqualToString:[self getPositonNameFromType:i]]) {
            [v.btn setBackgroundImage:[UIImage imageNamed:@"qm_btn_memberinfo_position_selected"] forState:UIControlStateNormal];
            [v.btn setTitleColor:[UIColor colorFromHexRGB:GangColor_userinfo_position_selected] forState:UIControlStateNormal];
        }
        [v.btn setTitle:[self getPositonNameFromType:i] forState:UIControlStateNormal];
        [v.btn addTarget:self action:@selector(positionClick:) forControlEvents:UIControlEventTouchUpInside];
        if (x+v.bounds.size.width>widthMax) {
            x = 0;
            y += v.bounds.size.height+8;
        }
        CGRect frame = v.frame;
        frame.origin.x = x;
        frame.origin.y = y;
        v.frame = frame;
        [self.view_position addSubview:v];
        x += v.bounds.size.width;
        x += 16;
    }
    self.constraint_height_view_position.constant = 37+y;
}

-(NSInteger)getPositonIdFromType:(NSInteger)type{
    NSArray *array_mute = userInfo.data.rolelist;
    GangPositionListBeanDataItem *p = array_mute[type];
    return p.roleid;
}

-(NSString*)getPositonNameFromType:(NSInteger)type{
    NSArray *array_mute = userInfo.data.rolelist;
    GangPositionListBeanDataItem *p = array_mute[type];
    return p.rolename;
}

-(void)positionClick:(UIButton*)button{
    actionType = 6;
    positionType = button.tag;
    GangMakesureViewController *vc = [[GangMakesureViewController alloc] init];
    NSMutableAttributedString *ats = [[NSMutableAttributedString alloc] init];
    NSString *info = GangSDKInstance.settingBean.data.gameprompt.modify_position;
    if (info) {
        NSArray *array_info = [info componentsSeparatedByString:@"{$nickname$}"];
        [array_info enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [ats appendAttributedString:[GangTools getshowContent:obj textColor:[UIColor colorFromHexRGB:GangColor_pop_alert_content] font:[UIFont systemFontOfSize:16] lineSpace:12 paraSpace:0]];
            if (idx!=array_info.count-1) {
                [ats appendAttributedString:[GangTools getshowContent:userInfo.data.nickname textColor:[UIColor colorFromHexRGB:GangColor_pop_alert_contentKey] font:[UIFont systemFontOfSize:16] lineSpace:4 paraSpace:0]];
            }
        }];
    }
    [ats appendAttributedString:[GangTools getshowContent:[NSString stringWithFormat:@"%@",[self getPositonNameFromType:positionType]] textColor:[UIColor colorFromHexRGB:GangColor_pop_alert_contentKey] font:[UIFont systemFontOfSize:16] lineSpace:13 paraSpace:0]];
    [ats appendAttributedString:[GangTools getshowContent:@"?" textColor:[UIColor colorFromHexRGB:GangColor_pop_alert_content] font:[UIFont systemFontOfSize:16] lineSpace:13 paraSpace:0]];
    vc.info = ats;
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)btn_reload_click:(id)sender {
    [self getData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma delegate
-(void)makeSureClick{
    switch (actionType) {
        case 1://修改头像
        {
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"修改头像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相机拍摄",@"相册选取", nil];
            [sheet showInView:self.view];
        }
        break;
        case 2://踢出社群
        {
            [self gang_loading:@"正在请求数据"];
            [GangSDKInstance.memberManager kickOutMemberWithTargetUserid:userInfo.data.userid success:^(id  _Nullable data) {
                [self gang_removeLoading];
                [self popViewController];
                [[NSNotificationCenter defaultCenter] postNotificationName:Gang_notify_MembersChanged object:nil];
            } failure:^(NSError * _Nullable error) {
                [self gang_removeLoading];
                if (error) {
                    [self gang_toast:error.domain];
                }
            }];
        }
        break;
        case 3://管理转让
        {
            [self gang_loading:@"正在请求数据"];
            [GangSDKInstance.memberManager transferGangOwnerWithTargetUserid:userInfo.data.userid success:^(id  _Nullable data) {
                [self gang_removeLoading];
                [self getData];
            } failure:^(NSError * _Nullable error) {
                [self gang_removeLoading];
                if (error) {
                    [self gang_toast:error.domain];
                }
            }];
        }
        break;
        case 4://解禁
        {
            [self gang_loading:@"正在请求数据"];
            [GangSDKInstance.memberManager cancelMuteMemberWithTargetUserid:userInfo.data.userid success:^(id  _Nullable data) {
                [self gang_removeLoading];
                [self getData];
                [[NSNotificationCenter defaultCenter] postNotificationName:Gang_notify_MembersChanged object:nil];
            } fail:^(NSError * _Nullable error) {
                [self gang_removeLoading];
                if (error) {
                    [self gang_toast:error.domain];
                }
            }];
        }
            break;
        case 5://禁言
        {
            [self gang_loading:@"正在请求数据"];
            [GangSDKInstance.memberManager muteMemberWithTargetUserid:userInfo.data.userid withReason:@"" keepTime:[self getMuteSecondsFormMuteIndex:muteType] success:^(id  _Nullable data) {
                [self gang_removeLoading];
                [self getData];
                [[NSNotificationCenter defaultCenter] postNotificationName:Gang_notify_MembersChanged object:nil];
            } fail:^(NSError * _Nullable error) {
                [self gang_removeLoading];
                if (error) {
                    [self gang_toast:error.domain];
                }
            }];
        }
            break;
        case 6://更改职位
        {
            [self gang_loading:@"正在请求数据"];
            [GangSDKInstance.memberManager modifyMemberRoleWithTargetUserid:userInfo.data.userid roleid:[self getPositonIdFromType:positionType] success:^(id  _Nullable data) {
                [self gang_removeLoading];
                [self getData];
                [[NSNotificationCenter defaultCenter] postNotificationName:Gang_notify_MembersChanged object:nil];
            } fail:^(NSError * _Nullable error) {
                [self gang_removeLoading];
                if (error) {
                    [self gang_toast:error.domain];
                }
            }];
        }
        break;
        
        default:
        break;
    }
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
    [GangSDKInstance.userManager updateHeadIcon:data success:^(GangUploadBean * _Nullable data) {
        [self gang_removeLoading];
        [self.iv_head setImageWithURLString:data.data.iconurl];
    } fail:^(NSError * _Nullable error) {
        [self gang_removeLoading];
        if (error){
            [self gang_toast:error.domain];
        }
    } progress:^(double percent) {
        [self gang_updataLoading:[NSString stringWithFormat:@"已提交:%d%%",(int)(percent*100)]];
    }];
}

- (void)tap_changeHeadIcon:(id)sender {
    if (GangSDKInstance.settingBean.data.gameconfig.user_icon_is_allow_update&&[userInfo.data.userid isEqualToString:GangSDKInstance.userBean.data.userid]) {
        actionType = 1;
        GangMakesureViewController *vc = [[GangMakesureViewController alloc] init];
        NSMutableAttributedString *ats = [[NSMutableAttributedString alloc] init];
        NSString *info = GangSDKInstance.settingBean.data.gameprompt.modify_user_icon;
        if (info) {
            NSArray *array_info = [info componentsSeparatedByString:@"{$moneyname$}"];
            [array_info enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [ats appendAttributedString:[GangTools getshowContent:obj textColor:[UIColor colorFromHexRGB:GangColor_pop_alert_content] font:[UIFont systemFontOfSize:16] lineSpace:12 paraSpace:0]];
                if (idx!=array_info.count-1) {
                    [ats appendAttributedString:[GangTools getshowContent:GangSDKInstance.settingBean.data.gamevariable.moneyname textColor:[UIColor colorFromHexRGB:GangColor_pop_alert_alertKey] font:[UIFont systemFontOfSize:16] lineSpace:4 paraSpace:0]];
                }
            }];
        }
        vc.info = ats;
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (IBAction)btn_kickOut_click:(id)sender {
    actionType = 2;
    GangMakesureViewController *vc = [[GangMakesureViewController alloc] init];
    NSMutableAttributedString *ats = [[NSMutableAttributedString alloc] init];
    NSString *info = GangSDKInstance.settingBean.data.gameprompt.kick_user;
    if (info) {
        NSArray *array_info = [info componentsSeparatedByString:@"{$nickname$}"];
        [array_info enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *array_info2 = [obj componentsSeparatedByString:@"{$gangname$}"];
            [array_info2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [ats appendAttributedString:[GangTools getshowContent:obj textColor:[UIColor colorFromHexRGB:GangColor_pop_alert_content] font:[UIFont systemFontOfSize:16] lineSpace:12 paraSpace:0]];
                if (idx!=array_info2.count-1) {
                    [ats appendAttributedString:[GangTools getshowContent:GangSDKInstance.settingBean.data.gamevariable.gangname textColor:[UIColor colorFromHexRGB:GangColor_pop_alert_content] font:[UIFont systemFontOfSize:16] lineSpace:4 paraSpace:0]];
                }
            }];
            if (idx!=array_info.count-1) {
                [ats appendAttributedString:[GangTools getshowContent:userInfo.data.nickname textColor:[UIColor colorFromHexRGB:GangColor_pop_alert_contentKey] font:[UIFont systemFontOfSize:16] lineSpace:4 paraSpace:0]];
            }
        }];
    }
    vc.info = ats;
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)btn_beLeader_click:(id)sender {
    actionType = 3;
    GangMakesureViewController *vc = [[GangMakesureViewController alloc] init];
    NSMutableAttributedString *ats = [[NSMutableAttributedString alloc] init];
    NSString *info = GangSDKInstance.settingBean.data.gameprompt.change_master;
    if (info) {
        NSArray *array_info = [info componentsSeparatedByString:@"{$nickname$}"];
        [array_info enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *array_info2 = [obj componentsSeparatedByString:@"{$gangowner$}"];
            [array_info2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [ats appendAttributedString:[GangTools getshowContent:obj textColor:[UIColor colorFromHexRGB:GangColor_pop_alert_content] font:[UIFont systemFontOfSize:16] lineSpace:12 paraSpace:0]];
                if (idx!=array_info2.count-1) {
                    [ats appendAttributedString:[GangTools getshowContent:GangSDKInstance.settingBean.data.gamevariable.gangowner textColor:[UIColor colorFromHexRGB:GangColor_pop_alert_content] font:[UIFont systemFontOfSize:16] lineSpace:4 paraSpace:0]];
                }
            }];
            if (idx!=array_info.count-1) {
                [ats appendAttributedString:[GangTools getshowContent:userInfo.data.nickname textColor:[UIColor colorFromHexRGB:GangColor_pop_alert_contentKey] font:[UIFont systemFontOfSize:16] lineSpace:4 paraSpace:0]];
            }
        }];
    }
    vc.info = ats;
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)btn_back_click:(id)sender {
    [self popViewController];
}

- (IBAction)btn_dynamic_click:(UIButton *)sender {
    
}

- (IBAction)btn_details_click:(UIButton *)sender {
    if ([@"详情" isEqualToString:self.btn_details.titleLabel.text]) {
        GangGangInfoViewController *infoVC = [[GangGangInfoViewController alloc] init];
            infoVC.consortiaid = userInfo.data.consortiaid;
        [self presentViewController:infoVC animated:YES completion:nil];
    } else {
        NSString *str_name = userInfo.data.nickname;
        [self gang_loading:@"正在提交数据"];
        [GangSDKInstance.memberManager inviteMemberWithNickname:str_name success:^(id  _Nullable data) {
            [self gang_removeLoading];
            [self gang_toast:@"邀请成功"];
        } fail:^(NSError * _Nullable error) {
            [self gang_removeLoading];
            if (error) {
                [self gang_toast:error.domain];
            }
        }];
    }
}

#pragma mark - collectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return userInfo.data.playgamelist.count;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    float width = ([UIScreen mainScreen].bounds.size.width - 34*2-17*3)/4;
    return CGSizeMake(width,(65/48)*width);
}
//设置水平间距 (同一行的cell的左右间距）
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 17;
}
//垂直间距 (同一列cell上下间距)
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

#pragma mark - collectionViewDataSource

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    GangMembersGamesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"gangMembersGamesCollectionViewCell" forIndexPath:indexPath];
    [cell setTheObj:userInfo.data.playgamelist[indexPath.item]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GangGameBean *bean = userInfo.data.playgamelist[indexPath.item];
    if ([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:bean.iospackage]) {
        [self gang_toast:@"您已在当前游戏中"];
        return;
    } else  {
        GangGameDownloadOrStartViewController *gameVC = [[GangGameDownloadOrStartViewController alloc] init];
        gameVC.iosscheme = bean.iosscheme;
        gameVC.iosdownloadurl = bean.iosdownloadurl;
        gameVC.pushVc = self;
        [self presentViewController:gameVC animated:NO completion:nil];
    }
}

@end
