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
#import "GangInviteViewController.h"
#import "GangCreateViewController.h"
#import "GangInViewController.h"

@interface GangOutViewController ()<MoreListViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView_holder;
@property (weak, nonatomic) IBOutlet UIScrollView *bottomScrollView_holder;
@property (weak, nonatomic) IBOutlet UILabel *label_titleView;

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshInventPoint:) name:Gang_notify_receiveGangInvite object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applyAccept:) name:Gang_notify_receiveGangAgree object:nil];
}

//邀请红点控制
-(void)refreshInventPoint:(NSNotification*)sender{
    GangOutTopScrollItem *inventItem = [self.array_items lastObject];
    if (sender.userInfo) {
        inventItem.iv_point.hidden = NO;
    }else{
        inventItem.iv_point.hidden = YES;
    }
}
//同意加入
-(void)applyAccept:(NSNotification*)sender{
    [self pushViewController:[[GangInViewController alloc] init]];
}

- (void)setTheSubviews{
    [super setTheSubviews];
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
    vc.title = [GangTools getLocalizationOfKey:@"招募频道"];
    [self addAnChildActivity:vc];
    vc = [[GangRecommendViewController alloc] init];
    vc.title = [NSString stringWithFormat:@"%@%@",GangSDKInstance.settingBean.data.gamevariable.gangname,[GangTools getLocalizationOfKey:@"推荐"]];
    [self addAnChildActivity:vc];
    vc = [[GangApplyViewController alloc] init];
    vc.title = [GangTools getLocalizationOfKey:@"已申请"];
    [self addAnChildActivity:vc];
    vc = [[GangInviteViewController alloc] init];
    vc.title = [GangTools getLocalizationOfKey:@"邀请加入"];
    [self addAnChildActivity:vc];
}

- (void)setTheSubviewsAfterLayout{
    [super setTheSubviewsAfterLayout];
    [self showAllViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if (index==4) {
        if (GangSDKInstance.userBean.data.hasvisited) {
            item.iv_point.hidden = NO;
        }
    }
    return item;
}

#pragma mark - MoreListViewControllerDelegate
- (void)hasShowTheController:(CodoneViewController *)controller{
    if ([controller isKindOfClass:[GangInviteViewController class]]) {
        GangOutTopScrollItem *workItem = [self.array_items lastObject];
        if (!workItem.iv_point.hidden) {
            [controller refreshTheControllerNoJudge:YES];
        }else{
            [controller refreshTheControllerNoJudge:NO];
        }
    }else{
        [controller refreshTheControllerNoJudge:NO];
    }
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeNavigationBarHidden" object:nil];
}
- (IBAction)btn_creatGangClick:(UIButton *)sender {
    GangCreateViewController *createVC = [[GangCreateViewController alloc] init];
    [self pushViewController:createVC];
}

@end
