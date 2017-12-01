//
//  GangCreateViewController.m
//  GangSDK
//
//  Created by xd on 2017/8/9.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangCreateViewController.h"
#import "GangInViewController.h"
#import "GangIconCollectionViewCell.h"
#import <GangSupport/MGWebImage.h>
@interface GangCreateViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,GangBaseCollectionViewCellDelegate>{
    NSString *iconString;
}
@property (weak, nonatomic) IBOutlet UITextField *textField_GangName;
@property (weak, nonatomic) IBOutlet UIImageView *iv_gangIcon;
@property (weak, nonatomic) IBOutlet UIImageView *iv_iconFrame;
@property (weak, nonatomic) IBOutlet UITextView  *textView_declaration;
@property (weak, nonatomic) IBOutlet UILabel *label_titleView;
@property (weak, nonatomic) IBOutlet UILabel *label_gangName;
@property (weak, nonatomic) IBOutlet UILabel *label_gangDeclaration;
@property (weak, nonatomic) IBOutlet UILabel *label_tvPlaceHolder;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITextView *textView_rules;

@end

@implementation GangCreateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)setTheDatas{
    [super setTheDatas];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tvTextChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)setTheSubviews{
    [super setTheSubviews];
    //设置标题的字体 大小 颜色
    self.label_titleView.font = [UIFont fontWithName:GangFont_title size:GangFontSize_title];
    [self.label_titleView setTextColor:[UIColor colorFromHexRGB:GangColor_title]];
    self.label_titleView.text = [NSString stringWithFormat:@"创建%@",GangSDKInstance.settingBean.data.gamevariable.gangname];
    [self.label_gangName setTextColor:[UIColor colorFromHexRGB:GangColor_createGang_icon_titleColor]];
    //设置社群名输入框的圆角和占位符字体大小 字体颜色
    NSString *holderText = [NSString stringWithFormat:@"请输入%@名称",GangSDKInstance.settingBean.data.gamevariable.gangname];
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSForegroundColorAttributeName
                        value:[UIColor colorFromHexRGB:GangColor_createGang_placeholder]
                        range:NSMakeRange(0, holderText.length)];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:12]
                        range:NSMakeRange(0, holderText.length)];
    self.textField_GangName.attributedPlaceholder = placeholder;
    [self.textField_GangName setTextColor:[UIColor colorFromHexRGB:GangColor_createGang_inputMessage]];
    [self.textField_GangName setTintColor:[UIColor colorFromHexRGB:GangColor_createGang_inputMessage]];
    //设置社群宣言输入框的圆角和占位符字体大小 字体颜色
    [self.textView_declaration setTextColor:[UIColor colorFromHexRGB:GangColor_createGang_inputMessage]];
    [self.textView_declaration setTintColor:[UIColor colorFromHexRGB:GangColor_createGang_inputMessage]];
    self.label_tvPlaceHolder.text = [NSString stringWithFormat:@"请输入%@宣言(最多输入30个字)",GangSDKInstance.settingBean.data.gamevariable.gangname];
    [self.label_gangDeclaration setTextColor:[UIColor colorFromHexRGB:GangColor_createGang_icon_titleColor]];
    [self.label_tvPlaceHolder setTextColor:[UIColor colorFromHexRGB:GangColor_createGang_placeholder]];
    //设置社群规则的字体颜色
    NSString *info = GangSDKInstance.settingBean.data.gameprompt.create_consortia;
    if (info) {
        info = [info stringByReplacingOccurrencesOfString:@"{$gangname$}" withString:GangSDKInstance.settingBean.data.gamevariable.gangname];
        self.textView_rules.text = [NSString stringWithFormat:@"规则:%@",info];
    }
    [self.textView_rules setTextColor:[UIColor colorFromHexRGB:GangColor_createGang_rules]];
    self.textView_rules.font = [UIFont systemFontOfSize:11];
    //注册单元格
    [self.collectionView registerNib:[UINib nibWithNibName:@"GangIconCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"gangIconCollectionViewCell"];
    //设置社群默认图标
    iconString = GangSDKInstance.settingBean.data.gameconfig.consortia_icons.firstObject;
    [self.iv_gangIcon setImageWithURLString:iconString];
}

- (void)tvTextChanged:(id)sender{
    self.label_tvPlaceHolder.hidden = self.textView_declaration.text.length > 0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - buttonAction
- (IBAction)btn_backClick:(UIButton *)sender {
    [self popViewController];
}

- (IBAction)btn_createClick:(UIButton *)sender {
    NSString *nameStr = self.textField_GangName.text;
    if ([GangTools countTheStrLength:nameStr] ==0) {
        [self gang_toast:[NSString stringWithFormat:@"请输入%@名称",GangSDKInstance.settingBean.data.gamevariable.gangname]];
        return;
    } else if ([GangTools countTheStrLength:nameStr] > 7) {
        [self gang_toast:[NSString stringWithFormat:@"%@名称最多七个字",GangSDKInstance.settingBean.data.gamevariable.gangname]];
        return;
    }
    if (iconString == nil) {
        [self gang_toast:@"请选择图标"];
        return;
    }
    NSString *declarationStr = self.textView_declaration.text;
    if ([GangTools countTheStrLength:declarationStr] > 30) {
        [self gang_toast:[NSString stringWithFormat:@"%@宣言最多30字",GangSDKInstance.settingBean.data.gamevariable.gangname]];
        return;
    }
    [self gang_loading:@"正在创建..."];
    [GangSDKInstance.groupManager createGangWithConsortianame:nameStr iconurl:iconString declaration:declarationStr success:^(GangInfoBean * _Nullable data) {
        [self gang_removeLoading];
        [self gang_toast:@"创建成功"];
        [self pushViewController:[[GangInViewController alloc] init]];
    } fail:^(NSError * _Nullable error) {
        [self gang_removeLoading];
        [self gang_toast:@"创建失败"];
        if (error) {
            [self gang_toast:error.domain];
        }
    }];
}

#pragma mark - collectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return GangSDKInstance.settingBean.data.gameconfig.consortia_icons.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GangIconCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"gangIconCollectionViewCell" forIndexPath:indexPath];
    cell.baseCellDelegate = self;
    [cell.iv_icon setImageWithURLString:GangSDKInstance.settingBean.data.gameconfig.consortia_icons[indexPath.row]];
    [cell setTheObj:GangSDKInstance.settingBean.data.gameconfig.consortia_icons[indexPath.row]];
    if ([iconString isEqualToString:GangSDKInstance.settingBean.data.gameconfig.consortia_icons[indexPath.row]]) {
        [cell.button setBackgroundImage:[UIImage imageNamed:@"qm_bg_creategang_icon_selected"] forState:UIControlStateNormal];
    } else {
        [cell.button setBackgroundImage:[UIImage imageNamed:@"qm_bg_creategang_icon_normal"] forState:UIControlStateNormal];
    }
    return cell;
}

#pragma mark - collectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(45, 45);
}

#pragma mark - basecelldelegate

- (void)selector1:(NSString *)obj{
    [self.iv_gangIcon setImageWithURLString:obj];
    iconString = obj;
    [self.collectionView reloadData];
}

@end
