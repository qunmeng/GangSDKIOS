//
//  GangImagsCheckerCollectionViewCell.m
//  GangSDK
//
//  Created by codone on 2017/8/7.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangImagesCheckerCollectionViewCell.h"

@implementation GangImagesCheckerObj
@end

@implementation GangImagesCheckerCollectionViewCell{
    GangImagesCheckerObj *obj_holder;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setTheObj:(GangImagesCheckerObj *)obj{
    obj_holder = obj;
    [self.btn setTitle:obj_holder.choosed?@"☑":@"□" forState:UIControlStateNormal];
    self.iv.image = [UIImage imageWithCGImage:obj_holder.alasset.thumbnail];
}

- (IBAction)btn_click:(id)sender {
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(canChooseMore)]&&![self.delegate canChooseMore]) {
            
        }else{
            obj_holder.choosed = !obj_holder.choosed;
            [self.btn setTitle:obj_holder.choosed?@"☑":@"□" forState:UIControlStateNormal];
            if (obj_holder.choosed&&[self.delegate respondsToSelector:@selector(chooseTheCellOfIndex:)]) {
                [self.delegate chooseTheCellOfIndex:obj_holder];
            }else if ([self.delegate respondsToSelector:@selector(cancelTheCellOfIndex:)]) {
                [self.delegate cancelTheCellOfIndex:obj_holder];
            }
        }
    }
}
@end
