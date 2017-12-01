//
//  GangMakesureViewController.h
//  GangSDK
//
//  Created by codone on 2017/8/14.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBasePresentViewController.h"

@protocol GangMakeSureDelegate <NSObject>
-(void)makeSureClick;
@end

@interface GangMakesureViewController : GangBasePresentViewController
@property(strong) NSAttributedString *info;
@property(weak) id<GangMakeSureDelegate> delegate;

@end
