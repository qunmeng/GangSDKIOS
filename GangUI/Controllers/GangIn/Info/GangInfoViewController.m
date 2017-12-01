//
//  GangInfoViewController.m
//  GangSDK
//
//  Created by codone on 2017/7/31.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangInfoViewController.h"
#import "GangLogsTableView.h"
#import "GangLogsTableViewCell.h"
#import "GangDonateViewController.h"
#import "GangInfoScrollView.h"


@interface GangInfoViewController ()<UITableViewDataSource,UITableViewDelegate,TableViewRefreshDelegate,TableViewLoadMoreDelegate,ScrollViewRefreshDelegate>{
    NSMutableArray *datas;
    int pageIndex;
}
@property (weak, nonatomic) IBOutlet UIButton *btn_reload;
@property (weak, nonatomic) IBOutlet GangInfoScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *label_tips;
@property (weak, nonatomic) IBOutlet UILabel *label_gangName;
@property (weak, nonatomic) IBOutlet UILabel *label_chairMan;
@property (weak, nonatomic) IBOutlet UILabel *label_level;
@property (weak, nonatomic) IBOutlet UILabel *label_contributedNum;
@property (weak, nonatomic) IBOutlet UILabel *label_memberNum;
@property (weak, nonatomic) IBOutlet UILabel *label_actionLevel;
@property (weak, nonatomic) IBOutlet UILabel *label_valueNum;
@property (weak, nonatomic) IBOutlet UILabel *label_dreamWord;
@property (weak, nonatomic) IBOutlet UIButton *btn_contribute;

@property (weak, nonatomic) IBOutlet UILabel *label_title_tips;
@property (weak, nonatomic) IBOutlet UILabel *label_title_gangInfo;
@property (weak, nonatomic) IBOutlet UILabel *label_title_dreamWord;
@property (weak, nonatomic) IBOutlet UILabel *label_title_log;

@property (weak, nonatomic) IBOutlet UILabel *label_lGangName;
@property (weak, nonatomic) IBOutlet UILabel *label_lChairman;
@property (weak, nonatomic) IBOutlet UILabel *label_lLevel;
@property (weak, nonatomic) IBOutlet UILabel *label_lContributed;
@property (weak, nonatomic) IBOutlet UILabel *label_lMembersNum;
@property (weak, nonatomic) IBOutlet UILabel *label_lActiveNum;
@property (weak, nonatomic) IBOutlet UILabel *label_lValueNum;
@property (weak, nonatomic) IBOutlet UILabel *label_lId;
@property (weak, nonatomic) IBOutlet UILabel *label_id;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_tips;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_dreamWord;

@property (weak, nonatomic) IBOutlet GangLogsTableView *tableView;

@end

@implementation GangInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)setTheDatas{
    [super setTheDatas];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshGangInfo) name:Gang_notify_infoChanged object:nil];
}

-(void)refreshGangInfo{
    [self.scrollView startRefresh];
    [self.tableView startRefresh];
}

- (IBAction)btn_reload_click:(id)sender {
    [self refreshGangInfo];
}

-(void)setTheSubviews{
    [super setTheSubviews];
    self.label_title_tips.textColor = [UIColor colorFromHexRGB:GangColor_gangInfo_title];
    self.label_title_gangInfo.textColor = [UIColor colorFromHexRGB:GangColor_gangInfo_title];
    self.label_title_dreamWord.textColor = [UIColor colorFromHexRGB:GangColor_gangInfo_title];
    self.label_title_log.textColor = [UIColor colorFromHexRGB:GangColor_gangInfo_title];
    
    self.label_lGangName.textColor = [UIColor colorFromHexRGB:GangColor_gangInfo_content];
    self.label_lChairman.textColor = [UIColor colorFromHexRGB:GangColor_gangInfo_content];
    self.label_lId.textColor = [UIColor colorFromHexRGB:GangColor_gangInfo_content];
    self.label_lLevel.textColor = [UIColor colorFromHexRGB:GangColor_gangInfo_content];
    self.label_lContributed.textColor = [UIColor colorFromHexRGB:GangColor_gangInfo_content];
    self.label_lMembersNum.textColor = [UIColor colorFromHexRGB:GangColor_gangInfo_content];
    self.label_lActiveNum.textColor = [UIColor colorFromHexRGB:GangColor_gangInfo_content];
    self.label_lValueNum.textColor = [UIColor colorFromHexRGB:GangColor_gangInfo_content];
    
    self.label_tips.textColor = [UIColor colorFromHexRGB:GangColor_gangInfo_content];
    self.label_gangName.textColor = [UIColor colorFromHexRGB:GangColor_gangInfo_content];
    self.label_id.textColor = [UIColor colorFromHexRGB:GangColor_gangInfo_content];
    self.label_chairMan.textColor = [UIColor colorFromHexRGB:GangColor_gangInfo_content];
    self.label_level.textColor = [UIColor colorFromHexRGB:GangColor_gangInfo_content];
    self.label_contributedNum.textColor = [UIColor colorFromHexRGB:GangColor_gangInfo_content];
    self.label_memberNum.textColor = [UIColor colorFromHexRGB:GangColor_gangInfo_content];
    self.label_actionLevel.textColor = [UIColor colorFromHexRGB:GangColor_gangInfo_content];
    self.label_valueNum.textColor = [UIColor colorFromHexRGB:GangColor_gangInfo_content];
    self.label_dreamWord.textColor = [UIColor colorFromHexRGB:GangColor_gangInfo_content];
    
    self.label_title_tips.text = [GangTools getLocalizationOfKey:@"公告"];
    self.label_title_gangInfo.text = [NSString stringWithFormat:@"%@%@",GangSDKInstance.settingBean.data.gamevariable.gangname,[GangTools getLocalizationOfKey:@"信息"]];
    self.label_title_dreamWord.text = [GangTools getLocalizationOfKey:@"宣言"];
    self.label_title_log.text = [GangTools getLocalizationOfKey:@"日志"];
    [self.btn_contribute setTitleColor:[UIColor colorFromHexRGB:GangColor_gangInfo_contributeButtonTitle] forState:UIControlStateNormal];
    [self.btn_contribute setTitle:[GangTools getLocalizationOfKey:@"捐献"] forState:UIControlStateNormal];
    
    self.scrollView.refreshDelegate = self;
    
    self.tableView.refreshDelegate = self;
    self.tableView.loadMoreDelegate = self;
}

-(void)refreshTheControllerNoJudge:(BOOL)noJudge{
    if (noJudge) {
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
        [self.tableView startRefresh];
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        [self.scrollView startRefresh];
    }else if (!self.hasRefreshed) {
        [self.tableView startRefresh];
        [self.scrollView startRefresh];
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
    GangLogsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"logsCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"GangLogsTableViewCell" bundle:nil] forCellReuseIdentifier:@"logsCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"logsCell"];
    }
    [cell setTheObj:datas[indexPath.row]];
    return cell;
}
#pragma delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.tableView computeTheCellHeight:@"GangLogsTableViewCell" withObj:datas[indexPath.row]];
}

#pragma refreshDelegate
-(void)refreshDatas:(id)sender{
    if (self.scrollView==sender) {
        self.btn_reload.hidden = YES;
        [GangSDKInstance.groupManager getGangInfoWithConsortiaid:GangSDKInstance.userBean.data.consortiaid success:^(GangInfoBean *data) {
            self.hasRefreshed = YES;
            [self.scrollView endRefresh];
            if (data.data.announcements.count>0) {
                self.label_tips.text = [(GangTipsBean*)data.data.announcements[0] content];
                CGSize size = [self.label_tips sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width-(320-80), 0)];
                self.constraint_height_tips.constant = size.height>40?size.height:40;
            }
            self.label_gangName.text = data.data.consortianame;
            self.label_id.text = data.data.consortiaid;
            self.label_chairMan.text = data.data.chairman;
            self.label_level.text = [NSString stringWithFormat:@"%ld",(long)data.data.buildlevel];
            self.label_contributedNum.text = [NSString stringWithFormat:@"%ld",(long)data.data.buildnum];
            self.label_memberNum.text = [NSString stringWithFormat:@"%ld/%ld",(long)data.data.nownum,(long)data.data.maxnum];
            self.label_actionLevel.text = [NSString stringWithFormat:@"LV%ld",(long)data.data.activelevel];
            self.label_valueNum.text = [NSString stringWithFormat:@"%ld",(long)data.data.moneynum];
            self.label_dreamWord.text = data.data.declaration;
            CGSize size = [self.label_dreamWord sizeThatFits:CGSizeMake([UIScreen mainScreen].bounds.size.width-(320-80), 0)];
            self.constraint_height_dreamWord.constant = size.height>40?size.height:40;
        } fail:^(NSError * _Nullable error) {
            [self.scrollView endRefresh];
            self.btn_reload.hidden = NO;
            if (error) {
                [self gang_toast:error.domain];
            }
        }];
    }else{
        [GangSDKInstance.groupManager getGangLogList:@"" pageSize:GangPageSize success:^(GangLogListBean * _Nullable data) {
            [self.tableView endRefresh];
            datas = [NSMutableArray arrayWithArray:data.data];
            [self.tableView reloadData];
            if (GangPageSize==data.data.count) {
                [self.tableView hideTheRefreshFooter:NO];
                pageIndex = 2;
            }
        } fail:^(NSError * _Nullable error) {
            [self.tableView endRefresh];
        }];
    }
}

-(void)loadMoreDatas:(id)sender{
    [GangSDKInstance.groupManager getGangLogList:[(GangLogsBean*)[datas lastObject] createtime] pageSize:GangPageSize success:^(GangLogListBean * _Nullable data) {
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

- (IBAction)btn_dunate:(id)sender {
    [self presentViewController:[[GangDonateViewController alloc] init] animated:YES completion:nil];
}
@end
