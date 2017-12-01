//
//  GangManagePositionRightsViewController.m
//  GangSDK
//
//  Created by codone on 2017/9/12.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangManageRoleAccessViewController.h"

#import "GangRoleTableViewCell.h"
#import "GangAccessTableViewCell.h"
#import "GangEditPositionViewController.h"
#import <GangSDK/GangRightBean.h>

@interface GangManageRoleAccessViewController ()<UITableViewDataSource,UITableViewDelegate,GangRoleTableViewCellDelegate,GangEditPositionViewControllerDelegate,GangBaseTableViewCellDelegate>{
    GangPositionListBeanData *datas;
    NSMutableArray *datas_rights;//缓存各职位权限
    NSInteger position_select;
}
@property (weak, nonatomic) IBOutlet UILabel *label_titleView_title;
@property (weak, nonatomic) IBOutlet UIButton *btn_reload;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *label_title_position;
@property (weak, nonatomic) IBOutlet UILabel *label_title_rights;
@property (weak, nonatomic) IBOutlet UITableView *tableView_positon;
@property (weak, nonatomic) IBOutlet UITableView *tableView_rights;
@property (weak, nonatomic) IBOutlet UIButton *btn_save;
@property (weak, nonatomic) IBOutlet UIButton *btn_cancel;
@end

@implementation GangManageRoleAccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)setTheDatas{
    [super setTheDatas];
    [self getDatas];
}

-(void)setTheSubviews{
    [super setTheSubviews];
    self.label_titleView_title.font = [UIFont fontWithName:GangFont_title size:GangFontSize_title];
    self.label_titleView_title.textColor = [UIColor colorFromHexRGB:GangColor_title];
    self.label_title_position.textColor = [UIColor colorFromHexRGB:GangColor_managePosition_title];
    self.label_title_rights.textColor = [UIColor colorFromHexRGB:GangColor_managePosition_title];
    [self.btn_save setTitle:[GangTools getLocalizationOfKey:@"保存"] forState:UIControlStateNormal];
    [self.btn_cancel setTitle:[GangTools getLocalizationOfKey:@"取消"] forState:UIControlStateNormal];
    [self.btn_save setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_confirmButton] forState:UIControlStateNormal];
    [self.btn_cancel setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_cancelButton] forState:UIControlStateNormal];
}

-(void)getDatas{
    self.btn_reload.hidden = YES;
    [self gang_loading:@"正在获取数据"];
    [GangSDKInstance.groupManager getGangRoleAndAccess:^(GangPositionListBean * _Nullable data) {
        [self gang_removeLoading];
        datas = data.data;
        self.btn_save.enabled = datas.canedit;
        [self.tableView_positon reloadData];
        //处理数据
        datas_rights = [NSMutableArray array];
        for (GangPositionListBeanDataItem *position in datas.roleinfo) {
            NSMutableArray *rights = [NSMutableArray array];
            for (GangRightBean *right in datas.accessinfo) {
                GangRightBean *r = [[GangRightBean alloc] init];
                r.accessid = right.accessid;
                r.accessdesc = right.accessdesc;
                r.canassign = right.canassign;
                [position.accesslist enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj integerValue] == right.accessid) {
                        r.selected = YES;
                        *stop = YES;
                    }
                }];
                [rights addObject:r];
            }
            [datas_rights addObject:rights];
        }
        [self.tableView_positon reloadData];
        [self.tableView_rights reloadData];
        self.scrollView.hidden = NO;
    } fail:^(NSError * _Nullable error) {
        [self gang_removeLoading];
        if (error) {
            [self gang_toast:error.domain];
        }
        self.btn_reload.hidden = NO;
    }];
}

- (IBAction)btn_reload_click:(id)sender {
    [self getDatas];
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
    if (self.tableView_rights==tableView) {
        return [(NSMutableArray*)datas_rights[position_select] count];
    }
    return datas.roleinfo.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tableView_positon==tableView) {
        GangRoleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"positionsCell"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"GangRoleTableViewCell" bundle:nil] forCellReuseIdentifier:@"positionsCell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"positionsCell"];
        }
        cell.baseCellDelegate = self;
        cell.iv_bg.hidden = indexPath.row!=position_select;
        cell.label_position.textColor = [UIColor colorFromHexRGB:indexPath.row!=position_select?GangColor_managePosition_item:GangColor_managePosition_item_selected];
        cell.btn_edit.enabled = datas.canedit;
        [cell setTheObj:datas.roleinfo[indexPath.row]];
        cell.delegate = self;
        return cell;
    }else{
        GangAccessTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightsCell"];
        if (!cell) {
            [tableView registerNib:[UINib nibWithNibName:@"GangAccessTableViewCell" bundle:nil] forCellReuseIdentifier:@"rightsCell"];
            cell = [tableView dequeueReusableCellWithIdentifier:@"rightsCell"];
        }
        
        GangPositionListBeanDataItem *position = datas.roleinfo[position_select];
        cell.canEdit = position.canedit&&datas.canedit;
        [cell setTheObj:(NSMutableArray*)datas_rights[position_select][indexPath.row]];
        return cell;
    }
}

#pragma delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tableView_rights==tableView) {
        return 30;
    }
    return 30;
}

#pragma baseCellDelegate
-(void)selector1:(id)obj{
    position_select = [datas.roleinfo indexOfObject:obj];
    [self.tableView_positon reloadData];
    [self.tableView_rights reloadData];
}

#pragma GangRoleTableViewCellDelegate
-(void)clickEdit:(GangPositionListBeanDataItem*)obj{
    GangEditPositionViewController *vc = [[GangEditPositionViewController alloc] init];
    vc.role = obj;
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma GangEditPositionViewControllerDelegate
-(void)updateSuccess{
    [self.tableView_positon reloadData];
}

- (IBAction)btn_close_click:(id)sender {
    [self popViewController];
}

- (IBAction)btn_save_click:(id)sender {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for (int i=0; i<datas.roleinfo.count; i++) {
        GangPositionListBeanDataItem *position = datas.roleinfo[i];
        if (!position.canedit) {
            continue;
        }
        NSMutableArray *array = [NSMutableArray array];
        NSArray *rights = datas_rights[i];
        [rights enumerateObjectsUsingBlock:^(GangRightBean * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.selected) {
                [array addObject:@(obj.accessid)];
            }
        }];
        [dic setObject:array forKey:[NSString stringWithFormat:@"%ld",(long)position.roleid]];
    }
    [self gang_loading:@"正在提交数据"];
    [GangSDKInstance.groupManager changeGangApproveSwitch:[GangTools getJsonStringFromArrayOrDictionary:dic] success:^(id  _Nullable data) {
        [self gang_removeLoading];
        [self popViewController];
    } fail:^(NSError * _Nullable error) {
        [self gang_removeLoading];
        if (error){
            [self gang_toast:error.domain];
        }
    }];
}

@end
