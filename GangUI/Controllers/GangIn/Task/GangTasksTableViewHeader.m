//
//  GangTasksTableViewHeader.m
//  GangSDK
//
//  Created by codone on 2017/8/28.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangTasksTableViewHeader.h"

@implementation GangTasksTableViewHeader

+(instancetype)createAHeader{
    return [[NSBundle mainBundle] loadNibNamed:@"GangTasksTableViewHeader" owner:nil options:0][0];
}

@end
