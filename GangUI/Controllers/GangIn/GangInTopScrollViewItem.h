//
//  GangInTopScrollViewItem.h
//  GangSDK
//
//  Created by codone on 2017/7/31.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangTopScrollViewItem.h"

@interface GangInTopScrollViewItem : GangTopScrollViewItem
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIImageView *iv_point;
+(instancetype)createATopScrollItem;
@end
