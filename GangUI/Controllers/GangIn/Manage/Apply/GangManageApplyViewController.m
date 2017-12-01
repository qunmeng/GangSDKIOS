//
//  GangForbidsViewController.m
//  GangSDK
//
//  Created by codone on 2017/8/3.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangManageApplyViewController.h"
#import "GangBaseLoadMoreTableView.h"
#import "GangManageApplyTableViewCell.h"


@interface GangManageApplyViewController ()<UITableViewDataSource,UITableViewDelegate,TableViewRefreshDelegate,TableViewLoadMoreDelegate,GangBaseTableViewCellDelegate>{
    NSMutableArray *datas;
}
@property (weak, nonatomic) IBOutlet UILabel *label_titleView;
@property (weak, nonatomic) IBOutlet GangBaseLoadMoreTableView *tableView;

@end

@implementation GangManageApplyViewController

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
    GangManageApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inventsCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"GangManageApplyTableViewCell" bundle:nil] forCellReuseIdentifier:@"inventsCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"inventsCell"];
    }
    cell.baseCellDelegate = self;
    [cell setTheObj:datas[indexPath.row]];
    return cell;
}
#pragma delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73;
}

#pragma refreshDelegate
-(void)refreshDatas:(id)sender{
    [GangSDKInstance.groupManager getMemberApplicationList:@"" pageSize:GangPageSize success:^(GangUserListBean *data) {
        [self.tableView endRefresh];
        datas = [NSMutableArray arrayWithArray:data.data];
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        [self.tableView endRefresh];
        if (error) {
            [self gang_toast:error.domain];
        }
    }];
}

-(void)loadMoreDatas:(id)sender{
    [GangSDKInstance.groupManager getMemberApplicationList:[(GangUserBeanData*)[datas lastObject] createtime] pageSize:GangPageSize success:^(GangUserListBean *data) {
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

-(void)selector1:(id)obj{
    int index = (int)[datas indexOfObject:obj];
    [self.tableView beginUpdates];
    [datas removeObjectAtIndex:index];
    [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForItem:index inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    [self.tableView endUpdates];
}

- (IBAction)btn_back_click:(id)sender {
    [self popViewController];
}
@end
