//
//  GangImagesCheckerViewController.m
//  GangSDK
//
//  Created by codone on 2017/8/7.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangImagesCheckerViewController.h"
#import "GangImagesCheckerTableViewCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "GangImagesCheckerPhotoViewController.h"

@interface GangImagesCheckerViewController ()<UITableViewDataSource,UITableViewDelegate>{
    ALAssetsLibrary *library;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(strong) NSMutableArray *array;

@end

@implementation GangImagesCheckerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self getGroups];
}

-(void)setTheDatas{
    [super setTheDatas];
    library = [[ALAssetsLibrary alloc] init];
    self.array = [NSMutableArray array];
}

-(void)getGroups{
    __weak GangImagesCheckerViewController *weakSelf = self;
    [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [weakSelf.array addObject:group];
        }else{
            [weakSelf.tableView reloadData];
        }
    } failureBlock:^(NSError *error) {
        [self gang_toast:@"获取图库失败！"];
    }];
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
    return self.array.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GangImagesCheckerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupCell"];
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"GangImagesCheckerTableViewCell" bundle:nil] forCellReuseIdentifier:@"groupCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"groupCell"];
    }
    ALAssetsGroup *group = self.array[indexPath.row];
    cell.iv.image = [UIImage imageWithCGImage:group.posterImage];
    cell.label.text = [group valueForProperty:ALAssetsGroupPropertyName];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GangImagesCheckerPhotoViewController *vc = [[GangImagesCheckerPhotoViewController alloc] init];
    vc.maxNum = self.maxNum;
    vc.delegate = self.delegate;
    vc.group = self.array[indexPath.row];
    [self pushViewController:vc];
}


#pragma delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (IBAction)btn_back_click:(id)sender {
    [self popViewController];
}

@end
