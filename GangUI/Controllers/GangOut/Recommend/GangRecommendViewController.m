//
//  GangRecommendViewController.m
//  GangSDK
//
//  Created by 雪狼 on 2017/7/31.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangRecommendViewController.h"
#import "GangBaseLoadMoreTableView.h"
#import "GangNormalRefreshTableView.h"
#import "GangRecommendTableViewCell.h"
#import "GangGangInfoViewController.h"
#import "GangInViewController.h"

@interface GangRecommendViewController ()<UITableViewDataSource,UITableViewDelegate,TableViewRefreshDelegate,GangBaseTableViewCellDelegate>{
    NSMutableArray *dataArray;
}
@property (weak, nonatomic) IBOutlet GangNormalRefreshTableView *tableView;

@end

@implementation GangRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GangRecommendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"recommendCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"GangRecommendTableViewCell" bundle:nil] forCellReuseIdentifier:@"recommendCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"recommendCell"];
    }
    GangInfoBeanData *infoData = dataArray[indexPath.row];
    cell.baseCellDelegate = self;
    [cell setTheObj:infoData];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GangInfoBeanData *infoData = dataArray[indexPath.row];
    if (infoData.consortiaid != nil) {
        GangGangInfoViewController *infoVC = [[GangGangInfoViewController alloc] init];
        infoVC.consortiaid = infoData.consortiaid;
        [self presentViewController:infoVC animated:YES completion:nil];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - refreshDelegate
- (void)refreshDatas:(id)sender{
    [GangSDKInstance.groupManager getGangRecommendList:^(GangListBean *result) {
        if (result.data.count>0) {
            self.hasRefreshed = YES;
        }
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
- (void)selector1:(GangInfoBeanData*)obj{
    [[UIApplication sharedApplication].keyWindow showLoadingWithInfo:@"正在请求数据"];
    [GangSDKInstance.userManager applyJoinGangWithConsortiaid:obj.consortiaid success:^(GangInfoBean *result) {
        [[UIApplication sharedApplication].keyWindow removeLoading];
        if (result.data) {
            [self pushViewController:[[GangInViewController alloc] init]];
        } else {
            [[UIApplication sharedApplication].keyWindow toastTheMsg:@"已发送申请"];
        }
    } fail:^(NSError * _Nullable error) {
        [[UIApplication sharedApplication].keyWindow removeLoading];
        [[UIApplication sharedApplication].keyWindow toastTheMsg:[NSString stringWithFormat:@"加入%@失败",GangSDKInstance.settingBean.data.gamevariable.gangname]];
        if (error) {
            [[UIApplication sharedApplication].keyWindow toastTheMsg:error.domain];
        }
    }];
}

@end
