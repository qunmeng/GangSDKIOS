//
//  GangEditPositionViewController.h
//  GangSDK
//
//  Created by codone on 2017/8/21.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBasePresentViewController.h"

@protocol GangEditPositionViewControllerDelegate <NSObject>

-(void)updateSuccess;

@end

@interface GangEditPositionViewController : GangBasePresentViewController
@property(strong) id role;
@property(weak) id<GangEditPositionViewControllerDelegate> delegate;
@end
