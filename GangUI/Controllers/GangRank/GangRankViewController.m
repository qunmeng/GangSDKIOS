//
//  GangRankViewController.m
//  GangSDK
//
//  Created by codone on 2017/8/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangRankViewController.h"
#import "GangRankTopScrollViewItem.h"
#import "GangTheListsNormalItemViewController.h"

@interface GangRankViewController ()<MoreListViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label_titleView;
@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView_holder;
@property (weak, nonatomic) IBOutlet UIScrollView *bottomScrollView_holder;

@end

@implementation GangRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)setTheSubviews{
    [super setTheSubviews];
    self.noScrollAnimation = YES;
    
    self.label_titleView.font = [UIFont fontWithName:GangFont_title size:GangFontSize_title];
    self.label_titleView.textColor = [UIColor colorFromHexRGB:GangColor_title];
    self.label_titleView.text = [NSString stringWithFormat:@"%@排行榜",GangSDKInstance.settingBean.data.gamevariable.gangname];
    //设置各个选项卡
    self.topScrollView = self.topScrollView_holder;
    self.bottomScrollView = self.bottomScrollView_holder;
    self.delegate = self;
    
    GangTheListsNormalItemViewController *vc = [[GangTheListsNormalItemViewController alloc] init];
    vc.title = [GangTools getLocalizationOfKey:@"等级榜"];
    vc.type = 1;
    [self addAnChildActivity:vc];
    vc = [[GangTheListsNormalItemViewController alloc] init];
    vc.title = [GangTools getLocalizationOfKey:@"人气榜"];
    vc.type = 2;
    [self addAnChildActivity:vc];
    vc = [[GangTheListsNormalItemViewController alloc] init];
    vc.title = [GangTools getLocalizationOfKey:@"财富榜"];
    vc.type = 3;
    [self addAnChildActivity:vc];
}

-(void)setTheSubviewsAfterLayout{
    [super setTheSubviewsAfterLayout];
    [self showAllViews];
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

#pragma override
-(CodoneTopScrollViewItem *)getTopScrollViewItemWithTitle:(NSString *)title index:(int)index{
    GangRankTopScrollViewItem *item = [GangRankTopScrollViewItem createATopScrollItem];
    [item.btn setTitle:title forState:UIControlStateNormal];
    [item.btn setTitleColor:[UIColor colorFromHexRGB:GangColor_tab_normal] forState:UIControlStateNormal];
    [item.btn setBackgroundImage:[UIImage imageNamed:@"qm_btn_tab_normal"] forState:UIControlStateNormal];
    if (self.pageIndex==index) {
        [item.btn setTitleColor:[UIColor colorFromHexRGB:GangColor_tab_selected] forState:UIControlStateNormal];
        [item.btn setBackgroundImage:[UIImage imageNamed:@"qm_btn_tab_selected"] forState:UIControlStateNormal];
    }
    return item;
}

#pragma MoreListViewControllerDelegate
-(void)hasShowTheController:(CodoneViewController *)controller{
    [controller refreshTheControllerNoJudge:NO];
}
-(void)clickTheSelectedItemOfController:(CodoneViewController *)controller{
    [controller refreshTheControllerNoJudge:YES];
}

- (IBAction)btn_back_click:(id)sender {
    [self popViewController];
}

@end
