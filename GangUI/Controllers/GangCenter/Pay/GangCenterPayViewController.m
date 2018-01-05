//
//  GangCenterPayViewController.m
//  Demo
//
//  Created by xd on 2017/12/6.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangCenterPayViewController.h"
#import "GangBaseCollectionViewCell.h"
#import "GangCenterPayCollectionViewCell.h"
#import "GangPaySelectionViewController.h"
#import <GangPay/GangPay.h>

@interface GangCenterPayViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,GangPaySelectionDelegate>{
    NSMutableArray *dataArray;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_statusBar;
@property (weak, nonatomic) IBOutlet UILabel *label_titleView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation GangCenterPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)setTheSubviews{
    [super setTheSubviews];
    if (GangUIInstance.needFitIphoneX) {
        self.constraint_height_statusBar.constant += 10;
    }
    
    //设置标题的字体 大小 颜色
    self.label_titleView.font = [UIFont fontWithName:GangFont_title size:GangFontSize_title];
    [self.label_titleView setTextColor:[UIColor colorFromHexRGB:GangColor_title]];
    self.label_titleView.text = [NSString stringWithFormat:@"%@充值",GangSDKInstance.settingBean.data.gamevariable.gangname];
    //注册单元格
    [self.collectionView registerNib:[UINib nibWithNibName:@"GangCenterPayCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"gangCenterPayCollectionViewCell"];    
}

- (void)setTheDatas{
    [super setTheDatas];
    [self gang_loading:@"正在加载数据"];
    [GangSDKInstance.userManager getPayConfigInfo:^(GangGoodsListBean * _Nullable result) {
        [self gang_removeLoading];
        dataArray = [NSMutableArray arrayWithArray:result.data];
        [self.collectionView reloadData];
    } failure:^(NSError * _Nullable error) {
        [self gang_removeLoading];
        if (error) {
            [self gang_toast:error.domain];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -buttonAction
- (IBAction)btn_back_click:(UIButton *)sender {
    [self popViewController];
}


#pragma mark - collectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    float width = ([UIScreen mainScreen].bounds.size.width-26*2-16*2)/3;
    if (width>115) {
        width = 115;
    }
    return CGSizeMake(width, width*(286+24)/(154+40));
}
//设置水平间距 (同一行的cell的左右间距）
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 16;
}
//垂直间距 (同一列cell上下间距)
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 35;
}

#pragma mark - collectionViewDataSource

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    GangCenterPayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"gangCenterPayCollectionViewCell" forIndexPath:indexPath];
    GangGoodsBean *bean = dataArray[indexPath.item];
    [cell setTheObj:bean];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    GangPaySelectionViewController *vc = [[GangPaySelectionViewController alloc] init];
    vc.obj = dataArray[indexPath.item];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}
#pragma mark - choosePayDelegate
-(void)aliPay:(id)obj{
    if (!GangSDKInstance.userBean.data.userid) {
        [self gang_toast:@"登录信息错误!"];
        return;
    }
    GangGoodsBean *bean = obj;
    GangPayInfo *info = [[GangPayInfo alloc] init];
    info.productid = bean.productid;
    info.productcost = bean.goldcostnum;
    [GangPay showAliPay:info success:^{
        [self gang_toast:@"购买成功"];
        [[NSNotificationCenter defaultCenter] postNotificationName:Gang_notify_userInfoChanged object:nil];
        [self popViewControllerWithoutAnimation];
    } fail:^(NSError * _Nullable error) {
        if (error.domain.length>0) {
            [self gang_toast:error.domain];
        }
    }];
}
-(void)wechatPay:(id)obj{
    if (!GangSDKInstance.userBean.data.userid) {
        [self gang_toast:@"登录信息错误!"];
        return;
    }
    GangGoodsBean *bean = obj;
    GangPayInfo *info = [[GangPayInfo alloc] init];
    info.productid = bean.productid;
    info.productcost = bean.goldcostnum;
    [GangPay showWechatPay:info success:^{
        [self gang_toast:@"购买成功"];
        [[NSNotificationCenter defaultCenter] postNotificationName:Gang_notify_userInfoChanged object:nil];
        [self popViewControllerWithoutAnimation];
    } fail:^(NSError * _Nullable error) {
        if (error.domain.length>0) {
            [self gang_toast:error.domain];
        }
    }];
}
@end
