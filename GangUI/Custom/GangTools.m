//
//  GangTools.m
//  GangSDKDemo
//
//  Created by codone on 2017/7/31.
//  Copyright © 2017年 codone. All rights reserved.
//

#import "GangTools.h"

@implementation GangTools
+(NSString *)getLocalizationOfKey:(NSString *)key{
    return NSLocalizedStringFromTable(key, @"GangUILocalization", nil);
}
@end
