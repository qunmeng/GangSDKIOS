//
//  GangTasksTableViewHeader.h
//  GangSDK
//
//  Created by codone on 2017/8/28.
//  Copyright © 2017年 qm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GangTasksTableViewHeader : UIView
@property (weak, nonatomic) IBOutlet UILabel *label_title;
+(instancetype)createAHeader;

@end
