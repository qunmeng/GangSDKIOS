//
//  GangImagesCheckerViewController.h
//  GangSDK
//
//  Created by codone on 2017/8/7.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseViewController.h"
#import "GangImagesCheckerDelegate.h"

@interface GangImagesCheckerViewController : GangBaseViewController
@property(weak) id<GangImagesCheckerDelegate> delegate;
///最大选择数
@property(assign) int maxNum;
@end
