//
//  ToastView.m
//  CodoneBaseApplication
//
//  Created by codone on 2016/12/22.
//  Copyright © 2016年 codone. All rights reserved.
//

#import "GangNormalToastView.h"

@implementation GangNormalToastView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)createAnToastView{
    return [[NSBundle mainBundle] loadNibNamed:@"GangNormalToastView" owner:nil options:nil][0];
}

-(void)awakeFromNib{
    [super awakeFromNib];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    GangNormalToastView *toastView = [GangNormalToastView createAnToastView];
    toastView.frame = frame;
    return toastView;
}
@end
