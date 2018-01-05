//
//  GangCenterUserViewController.m
//  Demo
//
//  Created by codone on 2017/12/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangCenterUserViewController.h"
#import <GangSupport/MGWebImage.h>
#import "GangGangInfoViewController.h"
#import "GangCenterUserCollectionViewCell.h"
#import "GangGameDownloadOrStartViewController.h"
@interface GangCenterUserViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate>{
    GangUserBean *userInfo;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_statusBar;
@property (weak, nonatomic) IBOutlet UILabel *label_titleView;
@property (weak, nonatomic) IBOutlet UILabel *label_goldNum;
@property (weak, nonatomic) IBOutlet UIView *view_showProduct;

@property (weak, nonatomic) IBOutlet UIView *view_level;
@property (weak, nonatomic) IBOutlet UIImageView *iv_head;
@property (weak, nonatomic) IBOutlet UILabel *label_nickname;
@property (weak, nonatomic) IBOutlet UILabel *label_level;
@property (weak, nonatomic) IBOutlet UILabel *label_role;
@property (weak, nonatomic) IBOutlet UILabel *label_gangName;
@property (weak, nonatomic) IBOutlet UILabel *label_position;
@property (weak, nonatomic) IBOutlet UILabel *label_activityNum;
@property (weak, nonatomic) IBOutlet UILabel *label_contributionNum;
@property (weak, nonatomic) IBOutlet UILabel *label_weekContribution;
@property (weak, nonatomic) IBOutlet UIButton *btn_details;
@property (weak, nonatomic) IBOutlet UIButton *btn_dynamic;
@property (weak, nonatomic) IBOutlet UIImageView *iv_bg_position;
@property (weak, nonatomic) IBOutlet UIView *view_gangName;
@property (weak, nonatomic) IBOutlet UIView *view_position;
@property (weak, nonatomic) IBOutlet UILabel *label_gameTitle;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_collectionview;

@end

@implementation GangCenterUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)setTheSubviews{
    [super setTheSubviews];
    if (GangUIInstance.needFitIphoneX) {
        self.constraint_height_statusBar.constant += 10;
    }
    //设置标题的字体 大小 颜色
    self.label_titleView.font = [UIFont fontWithName:GangFont_title size:GangFontSize_title];
    [self.label_titleView setTextColor:[UIColor colorFromHexRGB:GangColor_title]];
    
    if (NSClassFromString(@"GangCenterPayViewController")&&GangSDKInstance.settingBean.data.gameconfig.is_use_pay_module) {
        self.view_showProduct.hidden = NO;
    }
    
    //设置个人信息字体颜色
    [self.label_goldNum setTextColor:[UIColor colorFromHexRGB:GangColor_userCenter_goldNum]];
    [self.label_level setTextColor:[UIColor colorFromHexRGB:GangColor_userCenter_level]];
    [self.label_nickname setTextColor:[UIColor colorFromHexRGB:GangColor_userCenter_nickName]];
    [self.label_role setTextColor:[UIColor colorFromHexRGB:GangColor_userCenter_roleName]];
    [self.label_gangName setTextColor:[UIColor colorFromHexRGB:GangColor_userCenter_gangName]];
    [self.label_position setTextColor:[UIColor colorFromHexRGB:GangColor_userCenter_position]];
    
    [self.btn_dynamic setTitle:@"动态" forState:UIControlStateNormal];
    [self.btn_dynamic setTitleColor:[UIColor colorFromHexRGB:GangColor_userCenter_btn_dynamic] forState:UIControlStateNormal];
    [self.btn_details setTitle:@"详情" forState:UIControlStateNormal];
    [self.btn_details setTitleColor:[UIColor colorFromHexRGB:GangColor_userCenter_btn_details] forState:UIControlStateNormal];
    [self.label_weekContribution setTextColor:[UIColor colorFromHexRGB:GangColor_userCenter_contributeNum]];
    [self.label_contributionNum setTextColor:[UIColor colorFromHexRGB:GangColor_userCenter_contributeNum]];
    [self.label_activityNum setTextColor:[UIColor colorFromHexRGB:GangColor_userCenter_activeNum]];
    [self.label_gameTitle setTextColor:[UIColor colorFromHexRGB:GangColor_userCenter_itemTitle]];
    //注册单元格
    [self.collectionView registerNib:[UINib nibWithNibName:@"GangCenterUserCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"gangCenterUserCollectionViewCell"];
    
    if ([GangSDKInstance.userBean.data.consortiaid integerValue]>0) {
        self.view_gangName.hidden = NO;
        self.view_position.hidden = NO;
        self.btn_details.hidden = NO;
    } else {
        self.view_gangName.hidden = YES;
        self.view_position.hidden = YES;
        self.btn_details.hidden = YES;
    }
    [self getData];
}

- (void)setTheDatas{
    [super setTheDatas];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getData) name:Gang_notify_userInfoChanged object:nil];
}

- (void)getData{
    [self gang_loading:@"正在获取数据"];
    [GangSDKInstance.memberManager getGangMemeberInfoWithTargetUserid:GangSDKInstance.userBean.data.userid success:^(GangUserBean  *_Nullable data) {
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

        if ([GangSDKInstance.userBean.data.consortiaid integerValue] > 0) {
            [self.iv_head setImageWithURLString:userInfo.data.iconurl];
            self.label_nickname.text = userInfo.data.nickname;
            self.view_level.hidden = userInfo.data.gamelevel==0;
            self.label_level.text = [NSString stringWithFormat:@"Lv.%ld",(long)userInfo.data.gamelevel];
            self.label_gangName.text = userInfo.data.consortianame;
            self.label_position.text = userInfo.data.rolename;
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
            self.label_role.text = userInfo.data.gamerole;
            self.label_contributionNum.text = [NSString stringWithFormat:@"%@:%ld",[GangTools getLocalizationOfKey:@"总贡献"],(long)userInfo.data.contributenum];
            self.label_activityNum.text = [NSString stringWithFormat:@"%@:%ld",[GangTools getLocalizationOfKey:@"活跃度"],(long)userInfo.data.activenum];
            self.label_weekContribution.text = [NSString stringWithFormat:@"%@:%ld",[GangTools getLocalizationOfKey:@"周贡献"],(long)userInfo.data.weekcontributenum];
            self.label_goldNum.text = [NSString stringWithFormat:@"%ld",(long)userInfo.data.goldnum];
            self.btn_details.hidden = NO;
        } else {
            [self.iv_head setImageWithURLString:userInfo.data.iconurl];
            self.label_nickname.text = userInfo.data.nickname;
            self.view_level.hidden = userInfo.data.gamelevel==0;
            self.label_level.text = [NSString stringWithFormat:@"Lv.%ld",(long)userInfo.data.gamelevel];
            self.label_role.text = userInfo.data.gamerole;
            self.label_contributionNum.text = @"总贡献:0";
            self.label_activityNum.text = @"活跃值:0";
            self.label_weekContribution.text = @"周贡献:0";
            self.view_gangName.hidden = YES;
            self.view_position.hidden = YES;
            self.label_goldNum.text = [NSString stringWithFormat:@"%ld",(long)userInfo.data.goldnum];
            self.btn_details.hidden = YES;
        }
        [self.collectionView reloadData];
    } fail:^(NSError * _Nullable error) {
        [self gang_removeLoading];
        if (error) {
            [self gang_toast:error.domain];
        }
    }];
}

- (IBAction)btn_pay_click:(UIButton *)sender {
    if (NSClassFromString(@"GangCenterPayViewController")) {
        UIViewController *vc = [[NSClassFromString(@"GangCenterPayViewController") alloc] init];
        if (vc) {
            [self pushViewController:vc];
        }
    }
}

- (IBAction)btn_gangDetails_click:(UIButton *)sender {
    GangGangInfoViewController *infoVC = [[GangGangInfoViewController alloc] init];
    infoVC.consortiaid = GangSDKInstance.userBean.data.consortiaid;
    [self presentViewController:infoVC animated:YES completion:nil];
}

- (IBAction)btn_dynamic_click:(UIButton *)sender {
}


- (IBAction)btn_back_click:(UIButton *)sender {
    [self popViewController];
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
    GangCenterUserCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"gangCenterUserCollectionViewCell" forIndexPath:indexPath];
    [cell setTheObj:userInfo.data.playgamelist[indexPath.item]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GangGameBean *bean =userInfo.data.playgamelist[indexPath.item];
    if ([[[NSBundle mainBundle] bundleIdentifier] isEqualToString:bean.iospackage]) {
        [self gang_toast:@"您已在当前游戏中"];
        return;
    } else {
        GangGameDownloadOrStartViewController *gameVC = [[GangGameDownloadOrStartViewController alloc] init];
        gameVC.iosdownloadurl = bean.iosdownloadurl;
        gameVC.iosscheme = bean.iosscheme;
        gameVC.pushVc = self;
        [self presentViewController:gameVC animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
