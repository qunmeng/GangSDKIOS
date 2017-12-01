//
//  GangDissolvedViewController.h
//  GangSDK
//
//  Created by codone on 2017/8/11.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBasePresentViewController.h"


@protocol GangExitGangViewControllerDelegate <NSObject>

-(void)exitGang;

@end

@interface GangExitGangViewController : GangBasePresentViewController
@property(weak) id<GangExitGangViewControllerDelegate> delegate;
@end
