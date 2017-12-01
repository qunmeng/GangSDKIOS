//
//  UIColor+Codone.h
//  WJD
//
//  Created by codone on 2017/1/11.
//  Copyright © 2017年 codone. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Codone)
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString;
+ (UIColor *)colorFromHexRGB:(NSString *)inColorString alpha:(CGFloat)alpha;
@end
