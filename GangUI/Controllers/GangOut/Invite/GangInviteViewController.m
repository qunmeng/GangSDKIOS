//
//  GangInviteViewController.m
//  GangSDK
//
//  Created by 雪狼 on 2017/7/31.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangInviteViewController.h"
#import "GangBaseLoadMoreTableView.h"
#import "GangNormalRefreshTableView.h"
#import "GangInviteTableViewCell.h"
#import "GangGangInfoViewController.h"
#import "GangInViewController.h"
@interface GangInviteViewController ()<UITableViewDataSource,UITableViewDelegate,TableViewRefreshDelegate,GangBaseTableViewCellDelegate>{
    NSMutableArray *dataArray;
}

@property (weak, nonatomic) IBOutlet GangNormalRefreshTableView *tableView;

@end

@implementation GangInviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)setTheDatas{
    [super setTheDatas];
}

- (void)setTheSubviews{
    [super setTheSubviews];
    self.tableView.refreshDelegate = self;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setUpHideInputTap:YES];
}

#pragma mark - 主动刷新
- (void)refreshTheControllerNoJudge:(BOOL)noJudge{
    if (noJudge) {
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
        [self.tableView startRefresh];
    }else if (!self.hasRefreshed) {
        [self.tableView startRefresh];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GangInviteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inviteCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"GangInviteTableViewCell" bundle:nil] forCellReuseIdentifier:@"inviteCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"inviteCell"];
    }
    GangQueryListItemBean *infoData = dataArray[indexPath.row];
    [cell setTheObj:infoData];
    cell.baseCellDelegate = self;
    if (infoData.visitid != nil) {
        cell.visitid = infoData.visitid;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GangQueryListItemBean *infoData = dataArray[indexPath.row];
    
    if (infoData.visitid != nil) {
        GangGangInfoViewController *infoVC = [[GangGangInfoViewController alloc] init];
        infoVC.consortiaid = infoData.consortiaid;
        [self presentViewController:infoVC animated:YES completion:nil];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - refreshDelegate

- (void)refreshDatas:(id)sender{
    [GangSDKInstance.userManager getGangInviteList:^(GangQueryListBean *result) {
        if (result.data.count>0) {
            self.hasRefreshed = YES;
        }
        //取消红点
        GangSDKInstance.userBean.data.hasvisited = NO;
        [[NSNotificationCenter defaultCenter] postNotificationName:Gang_notify_receiveGangInvite object:nil];
        
        [self.tableView endRefresh];
        dataArray = [NSMutableArray arrayWithArray:result.data];
        [self.tableView reloadData];
    } failure:^(NSError * _Nullable error) {
        [self.tableView endRefresh];
        if (error) {
            [self gang_toast:error.domain];
        }
    }];
}

#pragma mark - basecelldelegate
- (void)selector1:(GangQueryListItemBean *)obj{
    if (obj.status==1) {
        [[UIApplication sharedApplication].keyWindow showLoadingWithInfo:@"正在加载数据"];
        [GangSDKInstance.userManager dealGangInvitationWithVisitid:obj.visitid status:1 success:^(GangInfoBean *result) {
            [[UIApplication sharedApplication].keyWindow removeLoading];
            [[UIApplication sharedApplication].keyWindow toastTheMsg:@"加入成功"];
            if (result) {
                [self pushViewController:[[GangInViewController alloc] init]];
            } else {
                [[UIApplication sharedApplication].keyWindow toastTheMsg:[NSString stringWithFormat:@"该%@需要审批",GangSDKInstance.settingBean.data.gamevariable.gangname]];
            }
        } fail:^(NSError * _Nullable error) {
            [[UIApplication sharedApplication].keyWindow removeLoading];
            [[UIApplication sharedApplication].keyWindow toastTheMsg:@"加入失败"];
            if (error) {
                [[UIApplication sharedApplication].keyWindow toastTheMsg:error.domain];
            }
        }];
    }else{
        [[UIApplication sharedApplication].keyWindow showLoadingWithInfo:@"正在加载数据"];
        [GangSDKInstance.userManager dealGangInvitationWithVisitid:obj.visitid status:2 success:^(GangInfoBean *result) {
            [[UIApplication sharedApplication].keyWindow removeLoading];
            [[UIApplication sharedApplication].keyWindow toastTheMsg:@"已拒绝加入"];
            int index = (int)[dataArray indexOfObject:obj];
            [self.tableView beginUpdates];
            [dataArray removeObjectAtIndex:index];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
        } fail:^(NSError * _Nullable error) {
            [[UIApplication sharedApplication].keyWindow removeLoading];
            [[UIApplication sharedApplication].keyWindow toastTheMsg:@"拒绝失败"];
            if (error) {
                [[UIApplication sharedApplication].keyWindow toastTheMsg:error.domain];
            }
        }];
    }
}
@end
