//
//  GangLogsTableView.m
//  GangSDK
//
//  Created by codone on 2017/8/28.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangLogsTableView.h"
#import "GangInfoScrollView.h"

@implementation GangLogsTableView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    if (self.nextResponder) {
        [self forbidAllScroll:self.nextResponder];
    }
    return [super hitTest:point withEvent:event];
    
}

-(void)forbidAllScroll:(UIResponder*)responder{
    if ([responder isKindOfClass:[UIView class]]) {
        if ([responder isKindOfClass:[GangInfoScrollView class]]) {
            [(GangInfoScrollView*)responder setScrollEnabled:NO];
        }
        if (responder.nextResponder) {
            [self forbidAllScroll:responder.nextResponder];
        }
    }
}

@end
