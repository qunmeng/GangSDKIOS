//
//  GangDissolvedViewController.h
//  GangSDK
//
//  Created by codone on 2017/8/11.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBasePresentViewController.h"


@protocol GangDissolvedViewControllerDelegate <NSObject>

-(void)deletedGang;

@end

@interface GangDissolvedViewController : GangBasePresentViewController
@property(weak) id<GangDissolvedViewControllerDelegate> delegate;
@end
