//
//  GangInViewController.m
//  GangSDK
//
//  Created by codone on 2017/7/31.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangInViewController.h"
#import "GangInTopScrollViewItem.h"
#import "GangChatViewController.h"
#import "GangInfoViewController.h"
#import "GangMembersViewController.h"
#import "GangManageViewController.h"
#import "GangTasksViewController.h"
#import "GangRankViewController.h"
#import "GangOutViewController.h"

@interface GangInViewController ()<MoreListViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *view_titleView;
@property (weak, nonatomic) IBOutlet UILabel *label_titleView;
@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView_holder;
@property (weak, nonatomic) IBOutlet UIScrollView *bottomScrollView_holder;

@end

@implementation GangInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beKickout) name:Gang_notify_receiveKickOut object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gangDissolved) name:Gang_notify_receiveGangDissolved object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshWorksPoint:) name:Gang_notify_receiveGangTask object:nil];
}

//被踢出社群了
-(void)beKickout{
    if (self.navigationController.presentedViewController) {
        [self.navigationController.presentedViewController dismissViewControllerAnimated:YES completion:^{
            [[UIApplication sharedApplication].keyWindow toastTheMsg:[GangTools getLocalizationOfKey:@"您被踢出了!"]];
            [self pushViewController:[[GangOutViewController alloc] init]];
        }];
    }else{
        [[UIApplication sharedApplication].keyWindow toastTheMsg:[GangTools getLocalizationOfKey:@"您被踢出了!"]];
        [self pushViewController:[[GangOutViewController alloc] init]];
    }
}

//社群被销毁了
-(void)gangDissolved{
    if (self.navigationController.presentedViewController) {
        [self.navigationController.presentedViewController dismissViewControllerAnimated:YES completion:^{
            [[UIApplication sharedApplication].keyWindow toastTheMsg:[NSString stringWithFormat:@"您所在的%@被解散了!",GangSDKInstance.settingBean.data.gamevariable.gangname]];
            [self pushViewController:[[GangOutViewController alloc] init]];
        }];
    }else{
        [[UIApplication sharedApplication].keyWindow toastTheMsg:[NSString stringWithFormat:@"您所在的%@被解散了!",GangSDKInstance.settingBean.data.gamevariable.gangname]];
        [self pushViewController:[[GangOutViewController alloc] init]];
    }
}

//任务红点控制
-(void)refreshWorksPoint:(NSNotification*)sender{
    GangInTopScrollViewItem *workItem = [self.array_items lastObject];
    if (sender.userInfo) {
        workItem.iv_point.hidden = NO;
    }else{
        workItem.iv_point.hidden = YES;
    }
}

-(void)setTheSubviews{
    [super setTheSubviews];
    self.noScrollAnimation = YES;
    self.label_titleView.font = [UIFont fontWithName:GangFont_title size:GangFontSize_title];
    self.label_titleView.textColor = [UIColor colorFromHexRGB:GangColor_title];
    self.label_titleView.text = GangSDKInstance.settingBean.data.gamevariable.gangname;
    //设置各个选项卡
    self.topScrollView = self.topScrollView_holder;
    self.bottomScrollView = self.bottomScrollView_holder;
    self.delegate = self;
    
    GangBaseViewController *vc = [[GangChatViewController alloc] init];
    vc.title = [GangTools getLocalizationOfKey:@"聊天"];
    [self addAnChildActivity:vc];
    vc = [[GangInfoViewController alloc] init];
    vc.title = [GangTools getLocalizationOfKey:@"信息"];
    [self addAnChildActivity:vc];
    vc = [[GangMembersViewController alloc] init];
    vc.title = [GangTools getLocalizationOfKey:@"成员"];
    [self addAnChildActivity:vc];
    vc = [[GangManageViewController alloc] init];
    vc.title = [GangTools getLocalizationOfKey:@"管理"];
    [self addAnChildActivity:vc];
    vc = [[GangTasksViewController alloc] init];
    vc.title = [GangTools getLocalizationOfKey:@"任务"];
    [self addAnChildActivity:vc];
}

-(void)setTheSubviewsAfterLayout{
    [super setTheSubviewsAfterLayout];
    [self showAllViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma override
-(CodoneTopScrollViewItem *)getTopScrollViewItemWithTitle:(NSString *)title index:(int)index{
    GangInTopScrollViewItem *item = [GangInTopScrollViewItem createATopScrollItem];
    [item.btn setTitle:title forState:UIControlStateNormal];
    [item.btn setTitleColor:[UIColor colorFromHexRGB:GangColor_tab_normal] forState:UIControlStateNormal];
    [item.btn setBackgroundImage:[UIImage imageNamed:@"qm_btn_tab_normal"] forState:UIControlStateNormal];
    if (self.pageIndex==index) {
        [item.btn setTitleColor:[UIColor colorFromHexRGB:GangColor_tab_selected] forState:UIControlStateNormal];
        [item.btn setBackgroundImage:[UIImage imageNamed:@"qm_btn_tab_selected"] forState:UIControlStateNormal];
    }
    if (index==4) {
        if (!GangSDKInstance.userBean.data.taskfinished) {
            item.iv_point.hidden = NO;
        }
    }
    return item;
}

#pragma MoreListViewControllerDelegate
-(void)hasShowTheController:(CodoneViewController *)controller{
    if ([controller isKindOfClass:[GangTasksViewController class]]) {
        GangInTopScrollViewItem *workItem = [self.array_items lastObject];
        if (!workItem.iv_point.hidden) {
            [controller refreshTheControllerNoJudge:YES];
        }else{
            [controller refreshTheControllerNoJudge:NO];
        }
    }else{
        [controller refreshTheControllerNoJudge:NO];
    }
}
-(void)clickTheSelectedItemOfController:(CodoneViewController *)controller{
    [controller refreshTheControllerNoJudge:YES];
}

- (IBAction)btn_back_click:(id)sender {
    if (self.navigationController.viewControllers.count==1) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self popViewController];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeNavigationBarHidden" object:nil];
}

- (IBAction)btn_showTheLists_click:(id)sender {
    [self pushViewController:[[GangRankViewController alloc] init]];
}

@end
