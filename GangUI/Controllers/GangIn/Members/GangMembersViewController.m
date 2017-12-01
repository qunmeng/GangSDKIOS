//
//  GangMembersViewController.m
//  GangSDK
//
//  Created by codone on 2017/7/31.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangMembersViewController.h"
#import "GangBaseLoadMoreTableView.h"
#import "GangMembersTableViewCell.h"
#import "GangMuteListViewController.h"
#import "GangActiveListViewController.h"
#import "GangDonateListViewController.h"
#import "GangAddMemberViewController.h"
#import "GangMemberInfoViewController.h"
#import "GangOutViewController.h"
#import "GangExitGangViewController.h"

@interface GangMembersViewController ()<UITableViewDataSource,UITableViewDelegate,TableViewRefreshDelegate,TableViewLoadMoreDelegate,UITextFieldDelegate,GangBaseTableViewCellDelegate,GangExitGangViewControllerDelegate>{
    int type;
    
    int pageIndex;
    NSMutableArray *datas;
}
@property (weak, nonatomic) IBOutlet UILabel *label_online;
@property (weak, nonatomic) IBOutlet UIButton *btn_mutes;
@property (weak, nonatomic) IBOutlet UIButton *btn_actives;
@property (weak, nonatomic) IBOutlet UIButton *btn_contributes;
@property (weak, nonatomic) IBOutlet UIButton *btn_addUser;
@property (weak, nonatomic) IBOutlet UIButton *btn_searchBtn;
@property (weak, nonatomic) IBOutlet UITextField *textfield_search;
@property (weak, nonatomic) IBOutlet UIButton *btn_search;
@property (weak, nonatomic) IBOutlet GangBaseLoadMoreTableView *tableView;

@end

@implementation GangMembersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)setTheDatas{
    [super setTheDatas];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshMembersList) name:Gang_notify_MembersChanged object:nil];
}

-(void)refreshMembersList{
    [self.tableView startRefresh];
}

-(void)setTheSubviews{
    [super setTheSubviews];
    
    [self setUpHideInputTap:YES];
    
    [self.btn_mutes setTitleColor:[UIColor colorFromHexRGB:GangColor_gangMembers_buttonTitle] forState:UIControlStateNormal];
    [self.btn_mutes setTitle:[GangTools getLocalizationOfKey:@"禁言室"] forState:UIControlStateNormal];
    [self.btn_actives setTitleColor:[UIColor colorFromHexRGB:GangColor_gangMembers_buttonTitle] forState:UIControlStateNormal];
    [self.btn_actives setTitle:[GangTools getLocalizationOfKey:@"活跃榜"] forState:UIControlStateNormal];
    [self.btn_contributes setTitleColor:[UIColor colorFromHexRGB:GangColor_gangMembers_buttonTitle] forState:UIControlStateNormal];
    [self.btn_contributes setTitle:[GangTools getLocalizationOfKey:@"贡献榜"] forState:UIControlStateNormal];
    [self.btn_addUser setTitleColor:[UIColor colorFromHexRGB:GangColor_gangMembers_buttonTitle] forState:UIControlStateNormal];
    [self.btn_addUser setTitle:[GangTools getLocalizationOfKey:@"添加成员"] forState:UIControlStateNormal];
    
    self.label_online.textColor = [UIColor colorFromHexRGB:GangColor_gangMembers_onlineNum];
    
    [self.btn_search setTitleColor:[UIColor colorFromHexRGB:GangColor_gangMembers_searchButtonTitle] forState:UIControlStateNormal];
    [self.btn_search setTitle:[GangTools getLocalizationOfKey:@"搜索"] forState:UIControlStateNormal];
    NSString *holderText = [GangTools getLocalizationOfKey:@"输入要查找的玩家名称"];
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:[UIColor colorFromHexRGB:GangColor_gangMembers_search_placeholder]
                        range:NSMakeRange(0, holderText.length)];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:11]
                        range:NSMakeRange(0, holderText.length)];
    self.textfield_search.attributedPlaceholder = placeholder;
    
    
    self.textfield_search.leftViewMode = UITextFieldViewModeAlways;
    [self.textfield_search setTextColor:[UIColor colorFromHexRGB:GangColor_gangMembers_search_inputMessage]];
    [self.textfield_search setTintColor:[UIColor colorFromHexRGB:GangColor_gangMembers_search_inputMessage]];
    self.tableView.refreshDelegate = self;
    self.tableView.loadMoreDelegate = self;
}

- (IBAction)btn_searchBtn_click:(id)sender {
    if (0==type) {
        [self beSearchType];
    }else{
        [self beNormalType];
    }
}

-(void)beSearchType{
    [self.tableView hideTheRefreshFooter:YES];
    type = 1;
    [self.btn_searchBtn setImage:[UIImage imageNamed:@"qm_icon_gangmembers_search_back"] forState:UIControlStateNormal];
    [self.textfield_search becomeFirstResponder];
    datas = nil;
    [self.tableView reloadData];
}

-(void)beNormalType{
    type = 0;
    [self.btn_searchBtn setImage:[UIImage imageNamed:@"qm_icon_gangmembers_magnifier"] forState:UIControlStateNormal];
    [self.textfield_search resignFirstResponder];
    self.textfield_search.text = nil;
    datas = nil;
    [self.tableView reloadData];
    [self.tableView startRefresh];
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
    GangMembersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"memebersCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"GangMembersTableViewCell" bundle:nil] forCellReuseIdentifier:@"memebersCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"memebersCell"];
    }
    [cell setTheObj:datas[indexPath.row]];
    cell.baseCellDelegate = self;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GangMemberInfoViewController *vc = [[GangMemberInfoViewController alloc] init];
    vc.userid = [(GangUserBeanData*)[datas objectAtIndex:indexPath.row] userid];
    [self pushViewController:vc];
}

#pragma delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 73;
}

#pragma basecelldelegate

-(void)selector1:(id)obj{
    GangExitGangViewController *vc = [[GangExitGangViewController alloc]init];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma exitDelegate
-(void)exitGang{
    [self gang_loading:@"正在请求数据"];
    [GangSDKInstance.userManager quitGang:^(id  _Nullable data) {
        [self gang_removeLoading];
        [self pushViewController:[[GangOutViewController alloc] init]];
    } failure:^(NSError * _Nullable error) {
        [self gang_removeLoading];
        if (error) {
            [self gang_toast:error.domain];
        }
    }];
}

#pragma refreshDelegate
-(void)refreshDatas:(id)sender{
    switch (type) {
        case 0:{
            [GangSDKInstance.groupManager getGangMembers:1 pageSize:GangPageSize success:^(GangMembersListBean *data) {
                self.hasRefreshed = YES;
                [self.tableView endRefresh];
                self.label_online.text = [NSString stringWithFormat:@"%@%d/%d",[GangTools getLocalizationOfKey:@"在线"],data.data.onlinenum,data.data.totalnum];
                datas = [NSMutableArray arrayWithArray:data.data.sortedlist];
                [self.tableView reloadData];
                if (GangPageSize==data.data.sortedlist.count) {
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
            if (self.textfield_search.text.length==0) {
                [self.tableView endRefresh];
                [self gang_toast:@"请输入用户名!"];
                return;
            }
            [GangSDKInstance.groupManager searchGangMember:self.textfield_search.text atPage:1 pageSize:GangPageSize success:^(GangUserListBean *data) {
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
            break;
            
        default:
            break;
    }
}

-(void)loadMoreDatas:(id)sender{
    switch (type) {
        case 0:{
            [GangSDKInstance.groupManager getGangMembers:pageIndex pageSize:GangPageSize success:^(GangMembersListBean *data) {
                [self.tableView endRefresh];
                [datas addObjectsFromArray:data.data.sortedlist];
                [self.tableView reloadData];
                if (GangPageSize==data.data.sortedlist.count) {
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
            [GangSDKInstance.groupManager searchGangMember:self.textfield_search.text atPage:pageIndex pageSize:GangPageSize success:^(GangUserListBean *data) {
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
            break;
            
        default:
            break;
    }
}

- (IBAction)btn_forbids_click:(id)sender {
    [self pushViewController:[[GangMuteListViewController alloc] init]];
}
- (IBAction)btn_actives_click:(id)sender {
    [self pushViewController:[[GangActiveListViewController alloc] init]];
}
- (IBAction)btn_contributions_click:(id)sender {
    [self pushViewController:[[GangDonateListViewController alloc] init]];
}
- (IBAction)btn_addMember_click:(id)sender {
    [self presentViewController:[[GangAddMemberViewController alloc] init] animated:YES completion:nil];
}

#pragma textfild delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    [self.tableView hideTheRefreshFooter:YES];
    type = 1;
    [self.btn_searchBtn setImage:[UIImage imageNamed:@"qm_icon_gangmembers_search_back"] forState:UIControlStateNormal];
    datas = nil;
    [self.tableView reloadData];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self btn_search_click:nil];
    return YES;
}

- (IBAction)btn_search_click:(id)sender {
    [self.textfield_search resignFirstResponder];
    NSString *str_name = self.textfield_search.text;
    if (str_name.length>0) {
        type = 1;
        [self.tableView startRefresh];
    }else{
        [self gang_toast:@"请输入用户名!"];
    }
}

@end
