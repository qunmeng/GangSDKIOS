//
//  GangImagesCheckerPhotoViewController.h
//  GangSDK
//
//  Created by codone on 2017/8/7.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseViewController.h"
#import "GangImagesCheckerDelegate.h"

@interface GangImagesCheckerPhotoViewController : GangBaseViewController
///最大选择数
@property(assign) int maxNum;
@property(weak) id<GangImagesCheckerDelegate> delegate;
@property(weak) id group;
@end
