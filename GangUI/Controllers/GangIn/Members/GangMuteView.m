//
//  GangMuteView.m
//  GangSDK
//
//  Created by codone on 2017/8/14.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangMuteView.h"

@implementation GangMuteView

-(void)awakeFromNib{
    [super awakeFromNib];
}

+(instancetype)createAGangMuteView{
    return [[NSBundle mainBundle] loadNibNamed:@"GangMuteView" owner:self options:nil][0];
}

@end
