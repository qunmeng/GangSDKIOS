//
//  CodoneTools+Time.h
//  CodoneApplication
//
//  Created by codone on 2016/12/20.
//  Copyright © 2016年 codone. All rights reserved.
//

#import "CodoneTools.h"

@interface CodoneTools (Time)
+(NSTimeInterval)formatTimeToNow:(NSString*)time;
+(NSString*)getTimeStringFromScends:(NSInteger)second;
+(NSTimeInterval)formatTime:(NSString*)time1 ToTime:(NSString*)time2;
+ (NSString *)formatTimeToMDHM:(NSString *)time;
+(NSString*)getTitleFromConfTime:(NSString*)time;
@end
