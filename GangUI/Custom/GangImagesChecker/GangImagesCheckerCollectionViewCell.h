//
//  GangImagsCheckerCollectionViewCell.h
//  GangSDK
//
//  Created by codone on 2017/8/7.
//  Copyright © 2017年 qm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface GangImagesCheckerObj : NSObject
@property(assign) BOOL choosed;
@property(strong) ALAsset *alasset;
@end

@protocol GangImagesCheckerCollectionViewCellDelegate <NSObject>
@optional
-(BOOL)canChooseMore;
-(void)chooseTheCellOfIndex:(GangImagesCheckerObj*)obj;
-(void)cancelTheCellOfIndex:(GangImagesCheckerObj*)obj;

@end

@interface GangImagesCheckerCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iv;
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property(weak) id<GangImagesCheckerCollectionViewCellDelegate> delegate;
-(void)setTheObj:(GangImagesCheckerObj*)obj;
@end
