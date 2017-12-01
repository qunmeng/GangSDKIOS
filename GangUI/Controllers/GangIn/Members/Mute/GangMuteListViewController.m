//
//  GangForbidsViewController.m
//  GangSDK
//
//  Created by codone on 2017/8/3.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangMuteListViewController.h"
#import "GangBaseLoadMoreTableView.h"
#import "GangMuteTableViewCell.h"

#import "GangMemberInfoViewController.h"

@interface GangMuteListViewController ()<UITableViewDataSource,UITableViewDelegate,TableViewRefreshDelegate,TableViewLoadMoreDelegate,GangBaseTableViewCellDelegate>{
    NSMutableArray *datas;
}
@property (weak, nonatomic) IBOutlet UILabel *label_titleView;
@property (weak, nonatomic) IBOutlet GangBaseLoadMoreTableView *tableView;

@end

@implementation GangMuteListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)setTheDatas{
    [super setTheDatas];
}

-(void)setTheSubviews{
    [super setTheSubviews];
    self.label_titleView.font = [UIFont fontWithName:GangFont_title size:GangFontSize_title];
    self.label_titleView.textColor = [UIColor colorFromHexRGB:GangColor_title];
    self.tableView.refreshDelegate = self;
    self.tableView.loadMoreDelegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView startRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */

#pragma dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return datas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GangMuteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"forbidsCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"GangMuteTableViewCell" bundle:nil] forCellReuseIdentifier:@"forbidsCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"forbidsCell"];
    }
    [cell setTheObj:datas[indexPath.row]];
    cell.baseCellDelegate = self;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GangMemberInfoViewController *vc = [[GangMemberInfoViewController alloc] init];
    vc.userid = [(GangUserBeanData*)datas[indexPath.row] userid];
    [self pushViewController:vc];
}

#pragma delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73;
}

#pragma refreshDelegate
-(void)refreshDatas:(id)sender{
    [GangSDKInstance.groupManager getGangMuteMemberList:@"" pageSize:GangPageSize success:^(GangUserListBean *data) {
        [self.tableView endRefresh];
        datas = [NSMutableArray arrayWithArray:data.data];
        [self.tableView reloadData];
        if (GangPageSize==data.data.count) {
            [self.tableView hideTheRefreshFooter:NO];
        }
    } fail:^(NSError * _Nullable error) {
        [self.tableView endRefresh];
        if (error) {
            [self gang_toast:error.domain];
        }
    }];
}

-(void)loadMoreDatas:(id)sender{
    [GangSDKInstance.groupManager getGangMuteMemberList:[(GangUserBeanData*)[datas lastObject] createtime] pageSize:GangPageSize success:^(GangUserListBean *data) {
        [self.tableView endRefresh];
        [datas addObjectsFromArray:data.data];
        [self.tableView reloadData];
        if (GangPageSize==data.data.count) {
            [self.tableView endLoadMoreDatas:NO];
        }else{
            [self.tableView endLoadMoreDatas:YES];
        }
    } fail:^(NSError * _Nullable error) {
        [self.tableView endRefresh];
        if (error) {
            [self gang_toast:error.domain];
        }
    }];
}

#pragma basecelldelegate
-(void)selector1:(id)obj{
    GangUserBeanData *user = obj;
    [self gang_loading:@"正在请求数据"];
    [GangSDKInstance.memberManager cancelMuteMemberWithTargetUserid:user.userid success:^(id  _Nullable data) {
        [self gang_removeLoading];
        [self.tableView beginUpdates];
        NSInteger index = [datas indexOfObject:obj];
        [datas removeObject:obj];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView endUpdates];
        [[NSNotificationCenter defaultCenter] postNotificationName:Gang_notify_MembersChanged object:nil];
    } fail:^(NSError * _Nullable error) {
        [self gang_removeLoading];
        if (error) {
            [self gang_toast:error.domain];
        }
    }];
}

- (IBAction)btn_back_click:(id)sender {
    [self popViewController];
}
@end
