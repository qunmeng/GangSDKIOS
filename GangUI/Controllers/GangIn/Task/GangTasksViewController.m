//
//  GangWorksViewController.m
//  GangSDK
//
//  Created by codone on 2017/7/31.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangTasksViewController.h"
#import "GangBaseLoadMoreTableView.h"
#import "GangTasksTableViewCell.h"
#import "GangTasksTableViewHeader.h"


@interface GangTasksViewController ()<UITableViewDataSource,UITableViewDelegate,TableViewRefreshDelegate,TableViewLoadMoreDelegate,GangBaseTableViewCellDelegate>{
    GangWorkListBean *datas;
}
@property (weak, nonatomic) IBOutlet GangBaseLoadMoreTableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *view_header1;
@property (strong, nonatomic) IBOutlet UIView *view_header2;
@property (strong, nonatomic) IBOutlet UIView *view_header3;

@end

@implementation GangTasksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

#pragma datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return datas.data.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    GangWorkListGroupBean *group = datas.data[section];
    return group.groupitems.count;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    GangTasksTableViewHeader *header = [GangTasksTableViewHeader createAHeader];
    GangWorkListGroupBean *group = datas.data[section];
    header.label_title.textColor = [UIColor colorFromHexRGB:GangColor_work_title];
    header.label_title.text = group.groupname;
    return header;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GangTasksTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"worksCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"GangTasksTableViewCell" bundle:nil] forCellReuseIdentifier:@"worksCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"worksCell"];
    }
    GangWorkListGroupBean *group = datas.data[indexPath.section];
    if (group.groupitems.count==1) {
        cell.iv_background.image = [UIImage imageNamed:@"qm_bg_gangtask_bottom_blue"];
    }else{
        if (indexPath.row==0) {
            cell.iv_background.image = [UIImage imageNamed:@"qm_bg_gangtask_top"];
        }else if(indexPath.row==group.groupitems.count-1){
            if (indexPath.row%2==0) {
                cell.iv_background.image = [UIImage imageNamed:@"qm_bg_gangtask_bottom_blue"];
            }else{
                cell.iv_background.image = [UIImage imageNamed:@"qm_bg_gangtask_bottom_blue_dark"];
            }
        }else{
            if (indexPath.row%2==0) {
                cell.iv_background.image = [UIImage imageNamed:@"qm_bg_gangtask_center_blue"];
            }else{
                cell.iv_background.image = [UIImage imageNamed:@"qm_bg_gangtask_center_blue_dark"];
            }
        }
    }
    cell.baseCellDelegate = self;
    [cell setTheObj:group.groupitems[indexPath.row]];
    return cell;
}

#pragma delegate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 38;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

#pragma basecelldelegate
-(void)selector1:(GangWorkBean *)work{
    [[UIApplication sharedApplication].keyWindow showLoadingWithInfo:@"正在请求数据"];
    [GangSDKInstance.groupManager dealTask:work.tasktype taskid:work.taskid success:^(id  _Nullable data) {
        [[UIApplication sharedApplication].keyWindow removeLoading];
        [self.tableView startRefresh];
    } fail:^(NSError * _Nullable error) {
        [[UIApplication sharedApplication].keyWindow removeLoading];
        if (error) {
            [[UIApplication sharedApplication].keyWindow toastTheMsg:error.domain];
        }
    }];
}


#pragma refreshDelegate
-(void)refreshDatas:(id)sender{
    [GangSDKInstance.groupManager getGangTaskList:^(GangWorkListBean *data) {
        if (data.data.count>0) {
            self.hasRefreshed = YES;
        }
        //取消红点
        GangSDKInstance.userBean.data.taskfinished = YES;
        [[NSNotificationCenter defaultCenter] postNotificationName:Gang_notify_receiveGangTask object:nil];
        
        [self.tableView endRefresh];
        datas = data;
        [self.tableView reloadData];
    } fail:^(NSError * _Nullable error) {
        [self.tableView endRefresh];
        if (error) {
            [self gang_toast:error.domain];
        }
    }];
}

-(void)loadMoreDatas:(id)sender{
}

@end
