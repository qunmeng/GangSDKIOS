//
//  CodoneTools+AttributeString.h
//  CodoneApplication
//
//  Created by codone on 2016/12/20.
//  Copyright © 2016年 codone. All rights reserved.
//

#import "CodoneTools.h"
#import <UIKit/UIKit.h>

@interface CodoneTools (AttributeString)

+(NSAttributedString*)getshowContent:(NSString*)content textColor:(UIColor*)color font:(UIFont*)font lineSpace:(float)space paraSpace:(float)paragraph;
+(NSAttributedString*)replaceSuperLinkText:(NSString*)content WithString:(NSString*)tag;
+ (NSArray*)getUrlsFromContent:(NSString*)text;
+(void)insertAImage:(UIImage*)image ofSize:(CGSize)size intoAttributionString:(NSMutableAttributedString*)string atIndex:(int)index;
+ (void)addAnUrlAtRange:(NSRange)range withUrl:(NSString*)urlString forAttributionString:(NSMutableAttributedString*)string;
+ (NSArray *)getSeparatedLinesFromLabel:(UILabel *)label;
@end
