//
//  GangForbidsViewController.m
//  GangSDK
//
//  Created by codone on 2017/8/3.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangDonateListViewController.h"
#import "GangBaseLoadMoreTableView.h"
#import "GangDonateListTableViewCell.h"
#import "GangDonateListTableViewCellNormal.h"

#import "GangMemberInfoViewController.h"

@interface GangDonateListViewController ()<UITableViewDataSource,UITableViewDelegate,TableViewRefreshDelegate,TableViewLoadMoreDelegate>{
    int pageIndex;
    NSMutableArray *datas;
}
@property (weak, nonatomic) IBOutlet UILabel *label_titleView;
@property (weak, nonatomic) IBOutlet GangBaseLoadMoreTableView *tableView;

@end

@implementation GangDonateListViewController

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
    if (indexPath.row<3) {
        GangDonateListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contributionsCellStar"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"GangDonateListTableViewCell" bundle:nil] forCellReuseIdentifier:@"contributionsCellStar"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"contributionsCellStar"];
        }
        cell.iv_sort.image = [UIImage imageNamed:[NSString stringWithFormat:@"qm_icon_rank%ld",(long)indexPath.row+1]];
        [cell setTheObj:datas[indexPath.row]];
        return cell;
    }else{
        GangDonateListTableViewCellNormal *cell = [tableView dequeueReusableCellWithIdentifier:@"contributionsCell"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"GangDonateListTableViewCellNormal" bundle:nil] forCellReuseIdentifier:@"contributionsCell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"contributionsCell"];
        }
        cell.label_sort.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
        [cell setTheObj:datas[indexPath.row]];
        return cell;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GangMemberInfoViewController *vc = [[GangMemberInfoViewController alloc] init];
    vc.userid = [(GangUserBeanData*)datas[indexPath.row] userid];
    [self pushViewController:vc];
}

#pragma delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row>2) {
        return 57;
    }
    return 73;
}

#pragma refreshDelegate
-(void)refreshDatas:(id)sender{
    [GangSDKInstance.groupManager getMemberList:1 atPage:1 pageSize:GangPageSize success:^(GangUserListBean *data) {
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
    [GangSDKInstance.groupManager getMemberList:1 atPage:pageIndex pageSize:GangPageSize success:^(GangUserListBean *data) {
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

- (IBAction)btn_back_click:(id)sender {
    [self popViewController];
}
@end
