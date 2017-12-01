//
//  GangListViewController.m
//  GangSDK
//
//  Created by 雪狼 on 2017/7/31.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangListViewController.h"
#import "GangBaseLoadMoreTableView.h"
#import "GangListTableViewCell.h"
#import "GangGangInfoViewController.h"
#import "GangInViewController.h"

@interface GangListViewController ()<UITableViewDataSource,UITableViewDelegate,TableViewRefreshDelegate,TableViewLoadMoreDelegate,UITextFieldDelegate,GangBaseTableViewCellDelegate>{
    int pageIndex;
    NSMutableArray *dataArray;
    int type;
}
@property (weak, nonatomic) IBOutlet GangBaseLoadMoreTableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textField_searchGang;
@property (weak, nonatomic) IBOutlet UIButton *btn_showSearch;
@property (weak, nonatomic) IBOutlet UIButton *btn_search;

@end

@implementation GangListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)setTheDatas{
    [super setTheDatas];
}

- (void)setTheSubviews{
    [super setTheSubviews];
    //设置搜索框的占位符字体颜色 字体大小
    NSString *holderText = [NSString stringWithFormat:@"请输入要查询的%@名称或ID",GangSDKInstance.settingBean.data.gamevariable.gangname];
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:[UIColor colorFromHexRGB:GangColor_gangLists_textFieldPlaceholder]
                        range:NSMakeRange(0, holderText.length)];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:12]
                        range:NSMakeRange(0, holderText.length)];
    self.textField_searchGang.attributedPlaceholder = placeholder;
    [self.textField_searchGang setTextColor:[UIColor colorFromHexRGB:Gangcolor_ganglists_inputMessage]];
    [self.textField_searchGang setTintColor:[UIColor colorFromHexRGB:Gangcolor_ganglists_inputMessage]];
    //设置搜索按钮字体大小 字体颜色
    [self.btn_search setTitleColor:[UIColor colorFromHexRGB:GangColor_gangLists_searchButtonTitle] forState:UIControlStateNormal];
    self.btn_search.titleLabel.font = [UIFont systemFontOfSize:GangFontSize_tab_title];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.refreshDelegate = self;
    self.tableView.loadMoreDelegate = self;
    [self setUpHideInputTap:YES];
}

-(void)refreshTheControllerNoJudge:(BOOL)noJudge{
    if (noJudge) {
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
        [self.tableView startRefresh];
    }else if (!self.hasRefreshed) {
        [self.tableView startRefresh];
    }
}

- (IBAction)btn_showSearch_click:(UIButton *)sender {
    if (0==type) {
        [self beSearchType];
    }else{
        [self beNormalType];
    }
}

-(void)beSearchType{
    [self.tableView hideTheRefreshFooter:YES];
    type = 1;
    [self.btn_showSearch setImage:[UIImage imageNamed:@"qm_icon_ganglist_search_back"] forState:UIControlStateNormal];
    [self.textField_searchGang becomeFirstResponder];
    dataArray = nil;
    [self.tableView reloadData];
    
}

-(void)beNormalType{
    type = 0;
    [self.btn_showSearch setImage:[UIImage imageNamed:@"qm_icon_ganglist_magnifier"] forState:UIControlStateNormal];
    [self.textField_searchGang resignFirstResponder];
    self.textField_searchGang.text = nil;
    dataArray = nil;
    [self.tableView reloadData];
    [self.tableView startRefresh];
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
    GangListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"GangListTableViewCell" bundle:nil] forCellReuseIdentifier:@"listCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"listCell"];
    }
    GangInfoBeanData *infoData = dataArray[indexPath.row];
    cell.baseCellDelegate = self;
    [cell setTheObj:infoData];
    if (infoData.consortiaid != nil) {
        cell.consortiaid = infoData.consortiaid;
    }
    cell.label_listNumber.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];
    [cell.label_listNumber setTextColor:[UIColor colorFromHexRGB:GangColor_gangLists_rankListNum]];
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
    switch (type) {
        case 0:{
            [GangSDKInstance.groupManager getGangList:1 atPage:1 pageSize:GangPageSize success:^(GangListBean * _Nullable result) {
                if (result.data.count>0) {
                    self.hasRefreshed = YES;
                }
                [self.tableView endRefresh];
                dataArray = [NSMutableArray arrayWithArray:result.data];
                [self.tableView reloadData];
                if (GangPageSize==result.data.count) {
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
            break;
        case 1:{
            if (self.textField_searchGang.text.length==0) {
                [self.tableView endRefresh];
                [self gang_toast:@"请输入名称!"];
                return;
            }
            [GangSDKInstance.groupManager searchGang:self.textField_searchGang.text atPage:1 pageSize:GangPageSize success:^(GangListBean *result) {
                [self.tableView endRefresh];
                dataArray = [NSMutableArray arrayWithArray:result.data];
                [self.tableView reloadData];
                if (GangPageSize==result.data.count) {
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
            break;
        default:
            break;
    }
}

- (void)loadMoreDatas:(id)sender{
    switch (type) {
        case 0:{
            [GangSDKInstance.groupManager getGangList:1 atPage:pageIndex pageSize:GangPageSize success:^(GangListBean * _Nullable result) {
                [self.tableView endRefresh];
                [dataArray addObjectsFromArray:result.data];
                [self.tableView reloadData];
                if (GangPageSize==result.data.count) {
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
            break;
        case 1:{
            [GangSDKInstance.groupManager searchGang:self.textField_searchGang.text atPage:pageIndex  pageSize:GangPageSize success:^(GangListBean *result) {
                [self.tableView endRefresh];
                [dataArray addObjectsFromArray:result.data];
                [self.tableView reloadData];
                if (GangPageSize==result.data.count) {
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
            break;
        default:
            break;
    }
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

#pragma mark - textfildDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.tableView hideTheRefreshFooter:YES];
    type = 1;
    [self.btn_showSearch setImage:[UIImage imageNamed:@"qm_icon_ganglist_search_back"] forState:UIControlStateNormal];
    dataArray = nil;
    [self.tableView reloadData];
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self btn_search_click:nil];
    return YES;
}

#pragma mark - buttonAction
- (IBAction)btn_search_click:(UIButton *)sender {
    [self.textField_searchGang resignFirstResponder];
    NSString *str_name = self.textField_searchGang.text;
    if (str_name.length>0) {
        type = 1;
        [self.tableView startRefresh];
    }else{
        [self gang_toast:@"请输入名称!"];
    }
}

@end
