//
//  LoadingView.m
//  CodoneBaseApplication
//
//  Created by codone on 2016/12/22.
//  Copyright © 2016年 codone. All rights reserved.
//

#import "GangNormalLoadingView.h"

@implementation GangNormalLoadingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(instancetype)createAnLoadingView{
    return [[NSBundle mainBundle] loadNibNamed:@"GangNormalLoadingView" owner:nil options:nil][0];
}

-(void)awakeFromNib{
    [super awakeFromNib];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    GangNormalLoadingView *loadingView = [GangNormalLoadingView createAnLoadingView];
    loadingView.frame = frame;
    return loadingView;
}

-(void)resetTheLoadingView{
    self.userInteractionEnabled = YES;
    [self.indicator stopAnimating];
    self.backgroundColor = [UIColor whiteColor];
    self.view_show.backgroundColor = [UIColor clearColor];
    self.indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.label_info.textColor = [UIColor blackColor];
}
@end
