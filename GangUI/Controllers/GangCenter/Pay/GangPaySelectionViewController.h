//
//  GangPaySelectionViewController.h
//  Demo
//
//  Created by xd on 2017/12/7.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBasePresentViewController.h"

@protocol GangPaySelectionDelegate <NSObject>
-(void)aliPay:(id)obj;
-(void)wechatPay:(id)obj;
@end

@interface GangPaySelectionViewController : GangBasePresentViewController
@property(strong) id obj;
@property(weak) id<GangPaySelectionDelegate> delegate;
@end
