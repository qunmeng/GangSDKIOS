//
//  GangBaseTableViewCell.h
//  GangSDKDemo
//
//  Created by codone on 2017/7/28.
//  Copyright © 2017年 codone. All rights reserved.
//

#import <GangSupport/CodoneTableViewCell.h>
#import "GangUIHeader.h"

@protocol GangBaseTableViewCellDelegate <NSObject>
//预设的方法
-(void)selector1:(id)obj;
@end

@interface GangBaseTableViewCell : CodoneTableViewCell
@property(weak) id<GangBaseTableViewCellDelegate> baseCellDelegate;
@end
