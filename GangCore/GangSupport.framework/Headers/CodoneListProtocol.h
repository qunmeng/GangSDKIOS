//
//  CodoneListProtocol.h
//  Codone
//
//  Created by codone on 2017/7/27.
//  Copyright © 2017年 codone. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CodoneSelectDelegate <NSObject>
/**
 *返回包含了以前选择了的数据
 */
-(NSArray*)objsPassedChoosed;
/**
 *返回是否已经不能继续选择
 */
-(BOOL)hasForbidSelectMore;
/**
 *选中了obj对应的cell
 */
-(void)selectedTheObj:(id)obj;
/**
 *取消选中obj对应的cell
 */
-(void)deselectedTheObj:(id)obj;
/**
 *移除所有选中的cell
 */
-(void)removeAllSelectedObjs;
@end
