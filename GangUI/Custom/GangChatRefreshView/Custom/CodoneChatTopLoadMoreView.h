//
//  NormalLoadView.h
//  RefreshTest
//
//  Created by codone on 2017/6/12.
//  Copyright © 2017年 codone. All rights reserved.
//

#import <GangSupport/CodoneTopRefreshView.h>

@interface CodoneChatTopLoadMoreView : CodoneTopRefreshView
@property (weak, nonatomic) IBOutlet UIImageView *iv;
@property (weak, nonatomic) IBOutlet UIImageView *iv_boy;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_margin;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
