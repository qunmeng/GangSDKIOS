//
//  AnimationTools.h
//  AAplication
//
//  Created by codone on 16/2/1.
//  Copyright © 2016年 codone. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface CodoneAnimationHelper : NSObject
+(CABasicAnimation *)scaleTo:(NSNumber *)toValue from:(NSNumber *)fromValue durTimes:(float)time endRemove:(BOOL)remove;
+(CABasicAnimation *)rotate;
+(CAAnimationGroup*)popShow;
+(CAAnimation*)scaleDismiss;
+(CAAnimationGroup*)popMoveShow:(CGPoint)from toPosition:(CGPoint)to;
+(CAAnimation*)rotateY;
+(CAAnimationGroup*)scaleViewShow:(CGSize)size fromPosition:(CGPoint)from toPosition:(CGPoint)to;
+(CAAnimationGroup*)scaleViewHide:(CGSize)size fromPosition:(CGPoint)from toPosition:(CGPoint)to;
+(CAAnimation*)shake;
+(CAAnimation *)toBigToNor;
@end
