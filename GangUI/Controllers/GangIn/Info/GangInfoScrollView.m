//
//  GangInfoScrollView.m
//  GangSDK
//
//  Created by codone on 2017/8/28.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangInfoScrollView.h"

@implementation GangInfoScrollView

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    self.scrollEnabled = YES;
    return [super hitTest:point withEvent:event];
}

@end
