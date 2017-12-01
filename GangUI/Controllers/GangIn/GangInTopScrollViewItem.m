//
//  GangInTopScrollViewItem.m
//  GangSDK
//
//  Created by codone on 2017/7/31.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangInTopScrollViewItem.h"

@implementation GangInTopScrollViewItem

+(instancetype)createATopScrollItem{
    return [[NSBundle mainBundle] loadNibNamed:@"GangInTopScrollViewItem" owner:self options:nil][0];
}

-(void)awakeFromNib{
    [super awakeFromNib];
}
-(void)hasBeenSelect{
    if (self.delegate&&[self.delegate respondsToSelector:@selector(selectTheItem:)]) {
        [self.delegate selectTheItem:(int)self.tag];
    }
}

- (IBAction)btn_click:(id)sender {
    [self hasBeenSelect];
}

@end
