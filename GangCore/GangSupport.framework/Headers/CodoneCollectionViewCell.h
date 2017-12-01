//
//  CodoneCollectionViewCell.h
//  WJD
//
//  Created by codone on 2017/1/10.
//  Copyright © 2017年 codone. All rights reserved.
//

#import "CodoneCollectionView.h"

@interface CodoneCollectionViewCell : UICollectionViewCell
///cell所在的tableview
@property(weak)CodoneCollectionView *parentCollectionView;
///obj
@property(weak)id obj_hold;

#pragma need override
-(void)resetTheCell;
-(CGSize)computeTheCellSize:(id)obj;
-(void)setTheObj:(id)obj;
@end
