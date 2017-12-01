//
//  UtilTools.h
//  Yopull
//
//  Created by codone on 15/12/2.
//  Copyright © 2015年 codone. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CodoneTools : NSObject

+ (NSString *)platformString;
+ (NSString *)getUniqueStrByUUID;
+ (BOOL)isPureInt:(NSString*)string;
+ (void)caculateUseTime:(void(^)(void))block withflag:(NSString*)flag;
+ (NSString*)getStringFromBool:(BOOL)value;
+ (NSString*)stringFromString:(NSString*)string deleteCharSet:(NSCharacterSet*)set;
+ (NSString*)getJsonStringFromArrayOrDictionary:(id)object;
+ (id)getArrayOrDictionaryFromJsonString:(NSString*)str;

+ (void)fixTheLabels:(float)width_max first:(UILabel*)label1 second:(UILabel*)label2 lastConstraint:(NSLayoutConstraint*)constraint;
+(void)judgeTextfield:(UITextField*)textField stringLength:(int)length;
+(void)judgeTextview:(UITextView*)textView stringLength:(int)length;
+ (int)countTheStrLength:(NSString*)strtemp;
@end
