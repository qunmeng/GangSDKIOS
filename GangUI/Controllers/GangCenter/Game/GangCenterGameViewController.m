//
//  GangCenterGameViewController.m
//  Demo
//
//  Created by codone on 2017/12/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangCenterGameViewController.h"
#import "GangBaseLoadMoreTableView.h"
#import "GangCenterGameTableViewCell.h"
@interface GangCenterGameViewController ()<UITableViewDataSource,UITableViewDelegate,TableViewRefreshDelegate>{
    NSMutableArray *dataArray;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_statusBar;
@property (weak, nonatomic) IBOutlet UILabel *label_titleView;
@property (weak, nonatomic) IBOutlet GangNormalRefreshTableView *tableView;

@end

@implementation GangCenterGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)setTheDatas{
    [super setTheDatas];
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
    self.tableView.parentController = self;
    [self.tableView startRefresh];
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

- (IBAction)btn_back_click:(UIButton *)sender {
    [self popViewController];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GangCenterGameTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"gameCenterCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"GangCenterGameTableViewCell" bundle:nil] forCellReuseIdentifier:@"gameCenterCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"gameCenterCell"];
    }
    [cell setTheObj:dataArray[indexPath.row]];
    cell.parentTableView = self.tableView;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73;
}

#pragma mark - refreshDelegate
- (void)refreshDatas:(id)sender{
    [GangSDKInstance.gameManager getGameList:^(GangGameListBean * _Nullable bean) {
        self.hasRefreshed = YES;
        [self.tableView endRefresh];
        dataArray = [NSMutableArray arrayWithArray:bean.data];
        [self.tableView reloadData];
    } failure:^(NSError * _Nullable error) {
        [self.tableView endRefresh];
        if (error) {
            [self gang_toast:error.domain];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
