//
//  GangGoodsListBean.h
//  GangSDK
//
//  Created by codone on 2017/12/14.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseBean.h"

@class GangGoodsBean;
@interface GangGoodsListBean : GangBaseBean
@property(strong) NSArray<GangGoodsBean*> *data;
@end

@interface GangGoodsBean : NSObject
@property(strong) NSString *productid;   /**<商品id*/
@property(strong) NSString *goldname;    /**<商品名称*/
@property(strong) NSString *goldpicurl;  /**<商品图片*/
@property(assign) int goldnum;           /**<商品数量*/
@property(strong) NSString *goldcostnum; /**<商品金额*/
@end
