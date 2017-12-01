//
//  CodoneTimerHander.h
//  TimerTest
//
//  Created by codone on 2017/10/9.
//  Copyright © 2017年 qm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CodoneTimerHander : NSObject
@property(assign) NSTimeInterval interval; /**<default 1*/
@property(strong) id obj; /**<holder*/
@property(copy) void(^repeatBlock)(CodoneTimerHander *obj); /**<repeat callBack*/

+(instancetype)initWithInterVal:(NSTimeInterval)interval objHolder:(id)obj whenReapt:(void(^)(CodoneTimerHander *obj))repeatBlock;

/**
 create a timer and start
 */
-(void)start;

/**
 invalidate the timer and set nil
 */
-(void)stop;
@end
