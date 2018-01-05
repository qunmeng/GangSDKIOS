//
//  GangOutViewController.m
//  GangSDK
//
//  Created by codone on 2017/7/31.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangOutViewController.h"
#import "GangOutTopScrollItem.h"
#import "GangListViewController.h"
#import "GangRecruitViewController.h"
#import "GangRecommendViewController.h"
#import "GangApplyViewController.h"
#import "GangCreateViewController.h"
#import "GangInViewController.h"
#import "GangCenterMessageViewController.h"
#import "GangCenterGameViewController.h"
#import "GangCenterUserViewController.h"

@interface GangOutViewController ()<MoreListViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView_holder;
@property (weak, nonatomic) IBOutlet UIScrollView *bottomScrollView_holder;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_statusBar;
@property (weak, nonatomic) IBOutlet UILabel *label_titleView;
@property (weak, nonatomic) IBOutlet UIButton *btn_messageCenter;
@property (weak, nonatomic) IBOutlet UIButton *btn_gameCenter;
@property (weak, nonatomic) IBOutlet UIButton *btn_userCenter;
@property (weak, nonatomic) IBOutlet UIView *view_createGang;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_margin_bottom_viewCreateGang;
@property (weak, nonatomic) IBOutlet UIImageView *iv_messageCenter_redPoint;

@end

@implementation GangOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    GangSDKInstance.chatManager.messages_gang = nil;
    NSArray *array = self.navigationController.childViewControllers;
    for (UIViewController *vc in array) {
        if ([vc isKindOfClass:[GangBaseViewController class]]||[vc isKindOfClass:[GangMoreListViewController class]]) {
            if (vc!=self) {
                [vc removeFromParentViewController];
            }
        }
    }
}

-(void)setTheDatas{
    [super setTheDatas];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMessagePoint) name:Gang_notify_receiveGangNotifyMessage object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applyAccept:) name:Gang_notify_receiveGangAgree object:nil];
}

//邀请红点控制
-(void)refreshMessagePoint{
    if (GangSDKInstance.userBean.data.hasmessage) {
        self.iv_messageCenter_redPoint.hidden = NO;
    } else {
        self.iv_messageCenter_redPoint.hidden = YES;
    }
}
//同意加入
-(void)applyAccept:(NSNotification*)sender{
    GangSDKInstance.userBean.data.hasmessage = YES;
    [self pushViewController:[[GangInViewController alloc] init]];
}

- (void)setTheSubviews{
    [super setTheSubviews];
    if (GangUIInstance.needFitIphoneX) {
        self.constraint_height_statusBar.constant += 10;
    }
    
    self.noScrollAnimation = YES;
    //设置标题的字体 大小 颜色
    self.label_titleView.font = [UIFont fontWithName:GangFont_title size:GangFontSize_title];
    [self.label_titleView setTextColor:[UIColor colorFromHexRGB:GangColor_title]];
    self.label_titleView.text = [NSString stringWithFormat:@"%@",GangSDKInstance.settingBean.data.gamevariable.gangname];
    //设置各个选项卡
    self.topScrollView = self.topScrollView_holder;
    self.bottomScrollView = self.bottomScrollView_holder;
    self.delegate = self;
    GangBaseViewController *vc = [[GangListViewController alloc] init];
    vc.title = [NSString stringWithFormat:@"%@%@",GangSDKInstance.settingBean.data.gamevariable.gangname,[GangTools getLocalizationOfKey:@"排行"]];
    [self addAnChildActivity:vc];
    vc = [[GangRecruitViewController alloc] init];
    vc.title = [GangTools getLocalizationOfKey:@"招募"];
    [self addAnChildActivity:vc];
    vc = [[GangRecommendViewController alloc] init];
    vc.title = [NSString stringWithFormat:@"%@%@",GangSDKInstance.settingBean.data.gamevariable.gangname,[GangTools getLocalizationOfKey:@"推荐"]];
    [self addAnChildActivity:vc];
    vc = [[GangApplyViewController alloc] init];
    vc.title = [GangTools getLocalizationOfKey:@"已申请"];
    [self addAnChildActivity:vc];
    
    [self.view_createGang addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)]];
    
    [self refreshMessagePoint];
}

- (void)setTheSubviewsAfterLayout{
    [super setTheSubviewsAfterLayout];
    [self showAllViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//拖动
- (void) handlePan:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translatedPoint = [recognizer translationInView:self.view];
    CGFloat y = self.view_createGang.frame.origin.y + translatedPoint.y;
    
    if (y>106&&y<self.view.bounds.size.height-self.view_createGang.bounds.size.height-52) {
        self.constraint_margin_bottom_viewCreateGang.constant = self.view.bounds.size.height-y-self.view_createGang.bounds.size.height;
    }
    
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
}

#pragma mark - override
- (CodoneTopScrollViewItem *)getTopScrollViewItemWithTitle:(NSString *)title index:(int)index{
    GangOutTopScrollItem *item = [GangOutTopScrollItem createATopScrollItem];
    //设置标题的字体大小 字体颜色
    [item.btn setTitle:title forState:UIControlStateNormal];
    item.btn.titleLabel.font = [UIFont systemFontOfSize:GangFontSize_tab_title];
    [item.btn setTitleColor:[UIColor colorFromHexRGB:GangColor_tab_normal] forState:UIControlStateNormal];
    [item.btn setBackgroundImage:[UIImage imageNamed:@"qm_btn_tab_normal"] forState:UIControlStateNormal];
    //选中状态
    if (index==self.pageIndex) {
        [item.btn setBackgroundImage:[UIImage imageNamed:@"qm_btn_tab_selected"]forState:UIControlStateNormal];
        [item.btn setTitleColor:[UIColor colorFromHexRGB:GangColor_tab_selected] forState:UIControlStateNormal];
    }
    return item;
}

#pragma mark - MoreListViewControllerDelegate
- (void)hasShowTheController:(CodoneViewController *)controller{
    [controller refreshTheControllerNoJudge:NO];
}
- (void)clickTheSelectedItemOfController:(CodoneViewController *)controller{
    [controller refreshTheControllerNoJudge:YES];
}

#pragma mark - buttonAction
- (IBAction)btn_back_click:(UIButton *)sender {
    if (self.navigationController.viewControllers.count==1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self popViewController];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:Gang_notify_exitGangUI object:nil];
}

- (IBAction)btn_creatGangClick:(UIButton *)sender {
    GangCreateViewController *createVC = [[GangCreateViewController alloc] init];
    [self pushViewController:createVC];
}

- (IBAction)btn_messageCenter_click:(UIButton *)sender {
    GangCenterMessageViewController *messageVC = [[GangCenterMessageViewController alloc] init];
    [self pushViewController:messageVC];
}

- (IBAction)btn_gameCenter_click:(UIButton *)sender {
    GangCenterGameViewController *gameVC = [[GangCenterGameViewController alloc] init];
    [self pushViewController:gameVC];
}

- (IBAction)btn_userCenter_click:(UIButton *)sender {
    GangCenterUserViewController *userVC = [[GangCenterUserViewController alloc] init];
    [self pushViewController:userVC];
}


@end
