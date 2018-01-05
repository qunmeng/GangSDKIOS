//
//  GangChatHeadClickView.m
//  Demo
//
//  Created by codone on 2017/12/11.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangChatHeadClickView.h"
#import <GangSupport/UIView+codone.h>
#import <GangSupport/UIColor+codone.h>
#import "GangUIFont.h"
#import <GangSDK/GangSDK.h>

@implementation GangChatHeadClickView

+(instancetype)getInstance{
    static dispatch_once_t onceToken;
    static GangChatHeadClickView *view;
    dispatch_once(&onceToken, ^{
        view = [[NSBundle mainBundle] loadNibNamed:@"GangChatHeadClickView" owner:nil options:nil][0];
        [view.btn_singleChat setTitleColor:[UIColor colorFromHexRGB:GangColor_gangChat_clickHeadItemButton] forState:UIControlStateNormal];
        [view.btn_showUserInfo setTitleColor:[UIColor colorFromHexRGB:GangColor_gangChat_clickHeadItemButton] forState:UIControlStateNormal];
        [view.btn_gangInfo setTitle:[NSString stringWithFormat:@"%@信息",GangSDKInstance.settingBean.data.gamevariable.gangname]  forState:UIControlStateNormal];
        [view.btn_gangInfo setTitleColor:[UIColor colorFromHexRGB:GangColor_gangChat_clickHeadItemButton] forState:UIControlStateNormal];
    });
    return view;
}

-(void)hideGangInfo:(BOOL)hide{
    if (hide) {
        self.constraint_margin_top_gangInfo.constant = 0;
        self.constraint_height_gangInfo.constant = 0;
        self.btn_gangInfo.hidden = YES;
    }else{
        self.constraint_margin_top_gangInfo.constant = 7;
        self.constraint_height_gangInfo.constant = 25;
        self.btn_gangInfo.hidden = NO;
    }
}

-(void)showInView:(UIView *)superView{
    [superView addSubViewToEqual:self];
}

-(void)removeSelf{
    [self removeFromSuperview];
    self.delegate = nil;
}

- (IBAction)btn_click:(UIButton*)sender {
    if (self.delegate) {
        switch (sender.tag) {
            case 0:
                break;
                
            case 1:
                if ([self.delegate respondsToSelector:@selector(singleChat:)]) {
                    [self.delegate singleChat:self.obj];
                }
                break;
                
            case 2:
                if ([self.delegate respondsToSelector:@selector(showUserInfo:)]) {
                    [self.delegate showUserInfo:self.obj];
                }
                break;
                
            case 3:
                if ([self.delegate respondsToSelector:@selector(showGangInfo:)]) {
                    [self.delegate showGangInfo:self.obj];
                }
                break;
                
            default:
                break;
        }
    }
    [self removeSelf];
}

@end
