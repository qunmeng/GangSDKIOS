//
//  GangApplyViewController.m
//  GangSDK
//
//  Created by 雪狼 on 2017/7/31.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangApplyViewController.h"
#import "GangBaseLoadMoreTableView.h"
#import "GangNormalRefreshTableView.h"
#import "GangApplyTableViewCell.h"
#import "GangGangInfoViewController.h"
@interface GangApplyViewController ()<UITableViewDataSource,UITableViewDelegate,TableViewRefreshDelegate,GangBaseTableViewCellDelegate>{
    NSMutableArray *dataArray;
}
@property (weak, nonatomic) IBOutlet GangNormalRefreshTableView *tableView;

@end

@implementation GangApplyViewController

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
    GangApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"applyCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"GangApplyTableViewCell" bundle:nil] forCellReuseIdentifier:@"applyCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"applyCell"];
    }
    GangQueryListItemBean *infoData = dataArray[indexPath.row];
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
    GangQueryListItemBean *infoData = dataArray[indexPath.row];
    
    if (infoData.consortiaid != nil) {
        GangGangInfoViewController *infoVC = [[GangGangInfoViewController alloc] init];
        infoVC.consortiaid = infoData.consortiaid;
        [self presentViewController:infoVC animated:YES completion:nil];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - refreshDelegate
- (void)refreshDatas:(id)sender{
    [GangSDKInstance.userManager getGangApplyList:^(GangQueryListBean *result) {
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
- (void)selector1:(GangQueryListItemBean *)obj{
    [[UIApplication sharedApplication].keyWindow showLoadingWithInfo:@"正在加载数据"];
    [GangSDKInstance.userManager cancelApplyJoinGangWithApplicationid:[NSString stringWithFormat:@"%ld",(long)obj.applicationid] success:^(GangQueryListBean *result) {
        [[UIApplication sharedApplication].keyWindow removeLoading];
        [[UIApplication sharedApplication].keyWindow toastTheMsg:@"已取消申请"];
        int index = (int)[dataArray indexOfObject:obj];
        [self.tableView beginUpdates];
        [dataArray removeObjectAtIndex:index];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
    } fail:^(NSError * _Nullable error) {
        [[UIApplication sharedApplication].keyWindow removeLoading];
        [[UIApplication sharedApplication].keyWindow toastTheMsg:@"取消申请失败"];
        if (error) {
            [[UIApplication sharedApplication].keyWindow toastTheMsg:error.domain];
        }
    }];
}
@end
