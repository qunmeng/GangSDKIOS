//
//  CodoneTopScrollViewItem.h
//  WJD
//
//  Created by codone on 2017/1/18.
//  Copyright © 2017年 codone. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CodoneTopScrollItemDelegate <NSObject>
///点击一项
-(void)selectTheItem:(int)page;
@end

@interface CodoneTopScrollViewItem : UIView
@property(assign) id<CodoneTopScrollItemDelegate> delegate;
@end
