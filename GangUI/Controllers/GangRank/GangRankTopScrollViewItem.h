//
//  GangRankTopScrollViewItem.h
//  GangSDK
//
//  Created by codone on 2017/8/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangTopScrollViewItem.h"

@interface GangRankTopScrollViewItem : GangTopScrollViewItem
@property (weak, nonatomic) IBOutlet UIButton *btn;
+(instancetype)createATopScrollItem;
@end
