//
//  GangMemberInfoViewController.h
//  GangSDK
//
//  Created by codone on 2017/8/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseViewController.h"

@interface GangMemberInfoViewController : GangBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *label_titleView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *iv_head;
@property (weak, nonatomic) IBOutlet UILabel *label_nickname;
@property (weak, nonatomic) IBOutlet UILabel *label_role;
@property (weak, nonatomic) IBOutlet UIImageView *iv_bg_position;
@property (weak, nonatomic) IBOutlet UILabel *label_position;
@property (weak, nonatomic) IBOutlet UILabel *label_contributeNum;
@property (weak, nonatomic) IBOutlet UILabel *label_activeNum;
@property (weak, nonatomic) IBOutlet UILabel *label_weekContribute;
@property (weak, nonatomic) IBOutlet UIButton *btn_reload;
@property (weak, nonatomic) IBOutlet UILabel *label_title_mute;
@property (weak, nonatomic) IBOutlet UILabel *label_title_position;
@property (weak, nonatomic) IBOutlet UILabel *label_title_gameName;

@property (weak, nonatomic) IBOutlet UIButton *btn_kickOut;
@property (weak, nonatomic) IBOutlet UIButton *btn_setChairman;

@property (weak, nonatomic) IBOutlet UIView *view_mute;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_view_mute;
@property (weak, nonatomic) IBOutlet UIView *view_position;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_view_position;
@property (weak, nonatomic) IBOutlet UIView *view_level;
@property (weak, nonatomic) IBOutlet UILabel *label_level;
@property (weak, nonatomic) IBOutlet UIButton *btn_dynamic;
@property (weak, nonatomic) IBOutlet UIButton *btn_details;
@property (weak, nonatomic) IBOutlet UIView *view_gangName;
@property (weak, nonatomic) IBOutlet UILabel *label_gangName;
@property (weak, nonatomic) IBOutlet UIView *view_userPosition;

@property (weak, nonatomic) IBOutlet UIView *view_settingBtn;
@property (weak, nonatomic) IBOutlet UIView *view_settingMute;
@property (weak, nonatomic) IBOutlet UIView *view_settingPosition;
@property (weak, nonatomic) IBOutlet UIView *view_userInfo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_spacing_view_mute;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_spacing_view_position;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_collectionview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_spacing_view_settingBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_view_muteTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_view_positionTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_view_userinfo;


@property(strong) NSString *userid;
@property(strong) NSString *consortiaid;

@end
