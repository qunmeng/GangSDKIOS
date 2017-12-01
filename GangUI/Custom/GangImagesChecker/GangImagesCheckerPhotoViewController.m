//
//  GangImagesCheckerPhotoViewController.m
//  GangSDK
//
//  Created by codone on 2017/8/7.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangImagesCheckerPhotoViewController.h"
#import "GangImagesCheckerCollectionViewCell.h"

@interface GangImagesCheckerPhotoViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,GangImagesCheckerCollectionViewCellDelegate>{
    NSMutableArray *alasset_checked;
}
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (weak, nonatomic) IBOutlet UIButton *btn_check;
@property(strong) NSMutableArray *array;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation GangImagesCheckerPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self getPhotos];
}

-(void)setTheDatas{
    [super setTheDatas];
    [self.collectionView registerNib:[UINib nibWithNibName:@"GangImagesCheckerCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"imagsCheckerPhotoCell"];
    alasset_checked = [NSMutableArray array];
}

-(void)setTheSubviews{
    [super setTheSubviews];
    self.label_title.text = [self.group valueForProperty:ALAssetsGroupPropertyName];
}

-(void)getPhotos{
    if (!self.array) {
        self.array = [NSMutableArray array];
    }
    __weak GangImagesCheckerPhotoViewController *weakSelf = self;
    [(ALAssetsGroup*)self.group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            GangImagesCheckerObj *obj = [[GangImagesCheckerObj alloc] init];
            obj.alasset = result;
            [weakSelf.array addObject:obj];
        }else{
            [weakSelf.collectionView reloadData];
        }
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
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.array.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GangImagesCheckerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imagsCheckerPhotoCell" forIndexPath:indexPath];
    cell.delegate = self;
    GangImagesCheckerObj *obj = self.array[indexPath.row];
    [cell setTheObj:obj];
    return cell;
}

#pragma delegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    float width = ([UIScreen mainScreen].bounds.size.width-40)/3;
    return CGSizeMake(width, width);
}

- (IBAction)btn_back_click:(id)sender {
    [self popViewController];
}

#pragma cell delegate
-(BOOL)canChooseMore{
    return self.maxNum>alasset_checked.count;
}
-(void)chooseTheCellOfIndex:(GangImagesCheckerObj*)obj{
    [alasset_checked addObject:obj.alasset];
    if (alasset_checked.count>0) {
        self.btn_check.enabled = YES;
    }
}
-(void)cancelTheCellOfIndex:(GangImagesCheckerObj*)obj{
    [alasset_checked removeObject:obj.alasset];
    if (alasset_checked.count==0) {
        self.btn_check.enabled = NO;
    }
}

- (IBAction)btn_check_click:(id)sender {
    [self popViewController];
    if (self.delegate&&[self.delegate respondsToSelector:@selector(checkedImagesALassets:)]) {
        [self.delegate checkedImagesALassets:alasset_checked];
    }
}
@end
