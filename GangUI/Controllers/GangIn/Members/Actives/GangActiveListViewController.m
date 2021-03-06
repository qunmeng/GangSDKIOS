//
//  GangForbidsViewController.m
//  GangSDK
//
//  Created by codone on 2017/8/3.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangActiveListViewController.h"
#import "GangBaseLoadMoreTableView.h"
#import "GangActivesTableViewCell.h"
#import "GangActivesTableViewCellNormal.h"

#import "GangMemberInfoViewController.h"

@interface GangActiveListViewController ()<UITableViewDataSource,UITableViewDelegate,TableViewRefreshDelegate,TableViewLoadMoreDelegate>{
    int pageIndex;
    NSMutableArray *datas;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_statusBar;
@property (weak, nonatomic) IBOutlet UILabel *label_titleView;
@property (weak, nonatomic) IBOutlet GangBaseLoadMoreTableView *tableView;

@end

@implementation GangActiveListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)setTheDatas{
    [super setTheDatas];
}

-(void)setTheSubviews{
    [super setTheSubviews];
    if (GangUIInstance.needFitIphoneX) {
        self.constraint_height_statusBar.constant += 10;
    }
    
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
        GangActivesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"activesCellStar"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"GangActivesTableViewCell" bundle:nil] forCellReuseIdentifier:@"activesCellStar"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"activesCellStar"];
        }
        cell.iv_sort.image = [UIImage imageNamed:[NSString stringWithFormat:@"qm_icon_rank%ld",(long)indexPath.row+1]];
        [cell setTheObj:datas[indexPath.row]];
        return cell;
    }else{
        GangActivesTableViewCellNormal *cell = [tableView dequeueReusableCellWithIdentifier:@"activesCell"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"GangActivesTableViewCellNormal" bundle:nil] forCellReuseIdentifier:@"activesCell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"activesCell"];
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
    vc.consortiaid = GangSDKInstance.userBean.data.consortiaid;
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
    [GangSDKInstance.groupManager getMemberList:2 atPage:1 pageSize:GangPageSize success:^(GangUserListBean *data) {
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
    [GangSDKInstance.groupManager getMemberList:2 atPage:pageIndex pageSize:GangPageSize success:^(GangUserListBean *data) {
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
        [self.tableView endLoadMoreDatas:NO];
        if (error) {
            [self gang_toast:error.domain];
        }
    }];
}

- (IBAction)btn_back_click:(id)sender {
    [self popViewController];
}
@end
