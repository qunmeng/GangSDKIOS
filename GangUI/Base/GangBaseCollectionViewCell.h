//
//  GangBaseCollectionViewCell.h
//  GangSDKDemo
//
//  Created by codone on 2017/7/28.
//  Copyright © 2017年 codone. All rights reserved.
//

#import <GangSupport/CodoneCollectionViewCell.h>
#import "GangUIHeader.h"

@protocol GangBaseCollectionViewCellDelegate <NSObject>
//预设的方法
-(void)selector1:(id)obj;
@end

@interface GangBaseCollectionViewCell : CodoneCollectionViewCell
@property(weak) id<GangBaseCollectionViewCellDelegate> baseCellDelegate;

@end
