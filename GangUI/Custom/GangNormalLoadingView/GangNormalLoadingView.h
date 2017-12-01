//
//  LoadingView.h
//  CodoneBaseApplication
//
//  Created by codone on 2016/12/22.
//  Copyright © 2016年 codone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GangSupport/CodoneLoadingProtocol.h>

@interface GangNormalLoadingView : UIView<CodoneLoadingProtocol>
@property (weak, nonatomic) IBOutlet UIView *view_show;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UILabel *label_info;
+(instancetype)createAnLoadingView;
@end
