//
//  ToastView.h
//  CodoneBaseApplication
//
//  Created by codone on 2016/12/22.
//  Copyright © 2016年 codone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GangNormalToastView : UIView
@property (weak, nonatomic) IBOutlet UILabel *label_msg;
+(instancetype)createAnToastView;
@end
