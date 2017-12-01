//
//  CodoneNormalLoadView.h
//  RefreshTest
//
//  Created by codone on 2017/6/12.
//  Copyright © 2017年 codone. All rights reserved.
//

#import <GangSupport/CodoneBottomRefreshView.h>

@interface CodoneNormalLoadView : CodoneBottomRefreshView
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end
