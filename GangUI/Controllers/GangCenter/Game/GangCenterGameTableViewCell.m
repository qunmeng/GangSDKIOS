//
//  GangCenterGameTableViewCell.m
//  Demo
//
//  Created by xd on 2017/12/5.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangCenterGameTableViewCell.h"
#import <GangSupport/MGWebImage.h>
#import "GangTools.h"
#import "GangNetStatesHintViewController.h"
#import <GangSupport/GangNetWatcher.h>
@implementation GangCenterGameTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.label_gameName setTextColor:[UIColor colorFromHexRGB:GangColor_gameCenter_name]];
    [self.label_gameDescription setTextColor:[UIColor colorFromHexRGB:GangColor_gameCenter_description]];
}

- (void)setTheObj:(GangGameBean *)obj{
    [super setTheObj:obj];
    self.label_gameName.text = obj.appname;
    self.label_gameDescription.text = obj.appinfo;
    [self.iv_head setImageWithURLString:obj.appicon];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://",obj.iosscheme]]]) {
        [self.btn_download setTitle:@"启动" forState:UIControlStateNormal];
        [self.btn_download setBackgroundImage:[UIImage imageNamed:@"qm_btn_gamecenter_start"] forState:UIControlStateNormal];
        [self.btn_download setTitleColor:[UIColor colorFromHexRGB:GangColor_gameCenter_btn_start] forState:UIControlStateNormal];
    }else{
        [self.btn_download setTitle:@"下载" forState:UIControlStateNormal];
        [self.btn_download setBackgroundImage:[UIImage imageNamed:@"qm_btn_gamecenter_download"] forState:UIControlStateNormal];
        [self.btn_download setTitleColor:[UIColor colorFromHexRGB:GangColor_gameCenter_btn_download] forState:UIControlStateNormal];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (IBAction)btn_download_click:(UIButton *)sender {
    GangGameBean *obj = self.obj_hold;
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://",obj.iosscheme]]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://",obj.iosscheme]]];
    }else{
        __weak GangCenterGameTableViewCell *weakSelf = self;
        [[GangNetWatcher instance] watchNetWithBlock:^(CodoneNetStatus statu) {
            GangNetStatesHintViewController *vc = [[GangNetStatesHintViewController  alloc] init];
            vc.iosdownloadurl = obj.iosdownloadurl;
            switch (statu) {
                case 1:{
                    vc.info = @"您当前处于无线网络，请确认是否下载？";
                }
                    break;
                case 2:{
                    vc.info = @"您当前处于移动网络，请确认是否下载？";
                }
                    break;
                default:
                    vc.info = @"您当前未连接网络，请检查网络";
                    break;
            }
            [weakSelf.parentTableView.parentController presentViewController:vc animated:YES completion:nil];
        } withKey:@"downLoad" needRemove:YES];
    }
}

@end
