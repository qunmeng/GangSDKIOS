//
//  GangTheListsNormalItemViewController.m
//  GangSDK
//
//  Created by codone on 2017/8/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangTheListsNormalItemViewController.h"
#import "GangBaseLoadMoreTableView.h"
#import "GangLevelListTableViewCell.h"
#import "GangInViewController.h"
#import "GangGangInfoViewController.h"

@interface GangTheListsNormalItemViewController ()<UITableViewDataSource,UITableViewDelegate,TableViewRefreshDelegate,TableViewLoadMoreDelegate>{
    int pageIndex;
    NSMutableArray *datas;
}
@property (weak, nonatomic) IBOutlet GangBaseLoadMoreTableView *tableView;

@end

@implementation GangTheListsNormalItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)setTheDatas{
    [super setTheDatas];
}

-(void)setTheSubviews{
    [super setTheSubviews];
    
    self.tableView.refreshDelegate = self;
    self.tableView.loadMoreDelegate = self;
}

-(void)refreshTheControllerNoJudge:(BOOL)noJudge{
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
    GangLevelListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"levelListCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"GangLevelListTableViewCell" bundle:nil] forCellReuseIdentifier:@"levelListCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"levelListCell"];
    }
    if (indexPath.row<3) {
        cell.label_sort.hidden = YES;
        cell.iv_sort.hidden = NO;
        cell.iv_sort.image = [UIImage imageNamed:[NSString stringWithFormat:@"qm_icon_rank%ld",(long)indexPath.row+1]];
    }else{
        cell.label_sort.hidden = NO;
        cell.label_sort.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
        cell.iv_sort.hidden = YES;
    }
    cell.type = self.type;
    [cell setTheObj:datas[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GangInfoBeanData *infoData = datas[indexPath.row];
    if (infoData.consortiaid != nil) {
        GangGangInfoViewController *infoVC = [[GangGangInfoViewController alloc] init];
        infoVC.consortiaid = infoData.consortiaid;
        [self presentViewController:infoVC animated:YES completion:nil];
    }
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73;
}

#pragma refreshDelegate
-(void)refreshDatas:(id)sender{
    [GangSDKInstance.groupManager getGangList:self.type atPage:1 pageSize:GangPageSize success:^(GangListBean * _Nullable data) {
        self.hasRefreshed = YES;
        [self.tableView endRefresh];
        datas = [NSMutableArray arrayWithArray:data.data];
        [self.tableView reloadData];
        if (GangPageSize==data.data.count) {
            [self.tableView hideTheRefreshFooter:NO];
            pageIndex = 2;
        }
    } fail:^(NSError * _Nullable error) {
        [self.tableView endRefresh];
        if (error) {
            [self gang_toast:error.domain];
        }
    }];
}

-(void)loadMoreDatas:(id)sender{
    [GangSDKInstance.groupManager getGangList:self.type atPage:pageIndex pageSize:GangPageSize success:^(GangListBean * _Nullable data) {
        [self.tableView endRefresh];
        [datas addObjectsFromArray:data.data];
        [self.tableView reloadData];
        if (GangPageSize==data.data.count) {
            [self.tableView endLoadMoreDatas:NO];
            pageIndex++;
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
@end
