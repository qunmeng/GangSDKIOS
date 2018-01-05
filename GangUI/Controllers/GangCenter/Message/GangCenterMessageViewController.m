//
//  GangCenterMessageViewController.m
//  Demo
//
//  Created by codone on 2017/12/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangCenterMessageViewController.h"
#import "GangBaseLoadMoreTableView.h"
#import "GangGangInviteTableViewCell.h"
#import "GangGangInfoViewController.h"
#import "GangInViewController.h"
#import "GangMessageNotifyTableViewCell.h"
#import "GangNotifyDefaultTableViewCell.h"
#import "GangMessageNotificationViewController.h"
@interface GangCenterMessageViewController ()<UITableViewDataSource,UITableViewDelegate,TableViewRefreshDelegate,TableViewLoadMoreDelegate,GangBaseTableViewCellDelegate,GangMessageNotificationDelegate>{
    NSMutableArray *dataArray;
    int pageIndex;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_statusBar;
@property (weak, nonatomic) IBOutlet UILabel *label_titleView;
@property (weak, nonatomic) IBOutlet GangBaseLoadMoreTableView *tableView;

@end

@implementation GangCenterMessageViewController

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
    
    self.tableView.refreshDelegate = self;
    self.tableView.loadMoreDelegate = self;
    self.tableView.parentController = self;
    [self.tableView startRefresh];
}

- (IBAction)btn_back_click:(UIButton *)sender {
    [self popViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 主动刷新
- (void)refreshTheControllerNoJudge:(BOOL)noJudge{
    if (noJudge) {
        if (self.tableView.contentOffset.y>0) {
            [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
        }
        [self.tableView startRefresh];
    }else if (!self.hasRefreshed) {
        [self.tableView startRefresh];
    }
}
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GangMessageBean *bean = dataArray[indexPath.row];
    switch (bean.msgtype) {
        case 1:{
            GangGangInviteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InviteCell"];
            if (!cell) {
                [tableView registerNib:[UINib nibWithNibName:@"GangGangInviteTableViewCell" bundle:nil] forCellReuseIdentifier:@"InviteCell"];
                cell = [tableView dequeueReusableCellWithIdentifier:@"InviteCell"];
            }
            cell.baseCellDelegate = self;
            [cell setTheObj:bean];
            return cell;
        }
            break;
        case 2:
        case 3:
        case 4:{
                GangMessageNotifyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"notifyCell"];
                if (!cell) {
                    [tableView registerNib:[UINib nibWithNibName:@"GangMessageNotifyTableViewCell" bundle:nil] forCellReuseIdentifier:@"notifyCell"];
                    cell = [tableView dequeueReusableCellWithIdentifier:@"notifyCell"];
                }
            cell.baseCellDelegate = self;
            [cell setTheObj:bean];
            return cell;
        }
            break;
        default:{
            GangNotifyDefaultTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NotifyDefaultCell"];
            if (!cell) {
                [tableView registerNib:[UINib nibWithNibName:@"GangNotifyDefaultTableViewCell" bundle:nil] forCellReuseIdentifier:@"NotifyDefaultCell"];
                cell = [tableView dequeueReusableCellWithIdentifier:@"NotifyDefaultCell"];
            }
            return cell;
        }
            break;
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73;
}

#pragma mark - refreshDelegate

- (void)refreshDatas:(id)sender{
    [GangSDKInstance.userManager getMessageNotificationList:1 pageSize:GangPageSize success:^(GangMessageListBean *result) {
        self.hasRefreshed = YES;
        //取消红点
        GangSDKInstance.userBean.data.hasmessage = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:Gang_notify_receiveGangNotifyMessage object:nil];
        [self.tableView endRefresh];
        dataArray = [NSMutableArray arrayWithArray:result.data];
        [self.tableView reloadData];
        if (GangPageSize==result.data.count) {
            [self.tableView endLoadMoreDatas:NO];
            pageIndex=2;
        }
    } failure:^(NSError * _Nullable error) {
        [self.tableView endRefresh];
        if (error) {
            [self gang_toast:error.domain];
        }
    }];
}

-(void)loadMoreDatas:(id)sender{
    [GangSDKInstance.userManager getMessageNotificationList:pageIndex pageSize:GangPageSize success:^(GangMessageListBean *result) {
        [self.tableView endRefresh];
        [dataArray addObjectsFromArray:result.data];
        [self.tableView reloadData];
        if (result.data.count==GangPageSize) {
            [self.tableView endLoadMoreDatas:NO];
            pageIndex++;
        }else{
            [self.tableView endLoadMoreDatas:YES];
        }
    } failure:^(NSError * _Nullable error) {
        [self.tableView endLoadMoreDatas:NO];
        if (error) {
            [self gang_toast:error.domain];
        }
    }];
}

#pragma mark - basecelldelegate
- (void)selector1:(GangMessageBean *)obj{
    switch (obj.data.status) {
        case 1:{
            [[UIApplication sharedApplication].keyWindow showLoadingWithInfo:@"正在加载数据"];
            [GangSDKInstance.userManager dealGangInvitationWithVisitid:obj.data.visitid messageid:obj.messageid status:1 success:^(GangInfoBean *result) {
                [[UIApplication sharedApplication].keyWindow removeLoading];
                if (result) {
                    int index = (int)[dataArray indexOfObject:obj];
                    [self.tableView beginUpdates];
                    [dataArray removeObjectAtIndex:index];
                    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                    [self.tableView endUpdates];
                    [self pushViewController:[[GangInViewController alloc] init]];
                } else {
                    [[UIApplication sharedApplication].keyWindow toastTheMsg:[NSString stringWithFormat:@"该%@需要审批",GangSDKInstance.settingBean.data.gamevariable.gangname]];
                }
            } fail:^(NSError * _Nullable error) {
                if (error) {
                    [[UIApplication sharedApplication].keyWindow toastTheMsg:error.domain];
                }
            }];
        }
            break;
        case 2:{
            [[UIApplication sharedApplication].keyWindow showLoadingWithInfo:@"正在加载数据"];
            [GangSDKInstance.userManager dealGangInvitationWithVisitid:obj.data.visitid messageid:obj.messageid status:2 success:^(GangInfoBean *result) {
                [[UIApplication sharedApplication].keyWindow removeLoading];
                [[UIApplication sharedApplication].keyWindow toastTheMsg:@"已拒绝加入"];
                int index = (int)[dataArray indexOfObject:obj];
                [self.tableView beginUpdates];
                [dataArray removeObjectAtIndex:index];
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                [self.tableView endUpdates];
            } fail:^(NSError * _Nullable error) {
                if (error) {
                    [[UIApplication sharedApplication].keyWindow toastTheMsg:error.domain];
                }
            }];
        }
            break;
        case 3:{
            [[UIApplication sharedApplication].keyWindow showLoadingWithInfo:@"正在加载数据"];
            [GangSDKInstance.userManager deleteMessageNotification:obj.messageid success:^(GangBaseBean * _Nullable data) {
                [[UIApplication sharedApplication].keyWindow removeLoading];
                int index = (int)[dataArray indexOfObject:obj];
                [self.tableView beginUpdates];
                [dataArray removeObjectAtIndex:index];
                [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                [self.tableView endUpdates];
            } failure:^(NSError * _Nullable error) {
                if (error) {
                    [[UIApplication sharedApplication].keyWindow toastTheMsg:error.domain];
                }
            }];
        }
            break;
        case 4:{
            GangMessageNotificationViewController *notifyVC = [[GangMessageNotificationViewController alloc] init];
            notifyVC.obj = obj;
            notifyVC.delegate = self;
            [self presentViewController:notifyVC animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}

#pragma mark - notificationDelegate
-(void)update:(id)obj{
    [self.tableView reloadData];
}

@end
