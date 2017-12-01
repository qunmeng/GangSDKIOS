//
//  CodoneRefreshView.h
//  RefreshTest
//
//  Created by codone on 2017/7/6.
//  Copyright © 2017年 codone. All rights reserved.
//

#import "CodoneRefreshView.h"

@interface CodoneTopRefreshView : CodoneRefreshView

#pragma can override for state content
-(void)changeToState_CanPullOrClick:(BOOL)animted finished:(void (^)(void))finish;
-(void)changeToState_CanPull:(BOOL)animted finished:(void (^)(void))finish;
-(void)changeToState_ReleaseToLoad:(BOOL)animted finished:(void (^)(void))finish;
-(void)changeToState_Refreshing:(BOOL)animted finished:(void (^)(void))finish;
-(void)changeToState_EndRefresh:(BOOL)animted finished:(void (^)(void))finish;
-(void)changeToState_NoMoreData:(BOOL)animted finished:(void (^)(void))finish;
-(void)changeToState_Hidden:(BOOL)animted finished:(void (^)(void))finish;
@end
