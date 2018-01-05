//
//  GangGameDownloadOrStartViewController.m
//  Demo
//
//  Created by xd on 2017/12/8.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangGameDownloadOrStartViewController.h"
#import "GangNetStatesHintViewController.h"
#import <GangSupport/GangNetWatcher.h>
@interface GangGameDownloadOrStartViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label_titleView;
@property (weak, nonatomic) IBOutlet UILabel *label_content;
@property (weak, nonatomic) IBOutlet UIButton *btn_startOrDownload;

@end

@implementation GangGameDownloadOrStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)setTheSubviews{
    [super setTheSubviews];
    [self.label_titleView setTextColor:[UIColor colorFromHexRGB:GangColor_pop_gangGame_title]];
    [self.label_content setTextColor:[UIColor colorFromHexRGB:GangColor_pop_gangGame_content]];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://",self.iosscheme]]]) {
        [self.btn_startOrDownload setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_gangGame_btn] forState:UIControlStateNormal];
        [self.btn_startOrDownload setTitle:@"启动" forState:UIControlStateNormal];
        [self.btn_startOrDownload setBackgroundImage:[UIImage imageNamed:@"qm_btn_pop_game_start"] forState:UIControlStateNormal];
        self.label_content.text = @"您的设备中已安装此应用,点击下方 启动 按钮启动";
    } else {
        [self.btn_startOrDownload setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_gangGame_btn] forState:UIControlStateNormal];
        [self.btn_startOrDownload setTitle:@"下载" forState:UIControlStateNormal];
        [self.btn_startOrDownload setBackgroundImage:[UIImage imageNamed:@"qm_btn_pop_game_download"] forState:UIControlStateNormal];
        self.label_content.text = @"您的设备中未安装此应用,点击下方 下载 按钮安装";
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btn_startOrDownload_click:(UIButton *)sender {
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://",self.iosscheme]]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@://",self.iosscheme]]];
    } else {
        [self dismissViewControllerAnimated:YES completion:^{
            __weak GangGameDownloadOrStartViewController *weakSelf = self;
            [[GangNetWatcher instance] watchNetWithBlock:^(CodoneNetStatus statu) {
                GangNetStatesHintViewController *vc = [[GangNetStatesHintViewController  alloc] init];
                vc.iosdownloadurl = weakSelf.iosdownloadurl;
                switch (statu) {
                    case 1:{
                        vc.info = @"请确认是否下载？";
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
                [weakSelf.pushVc presentViewController:vc animated:YES completion:nil];
            } withKey:@"downLoad" needRemove:YES];
        }];
    }
}

- (IBAction)btn_close_click:(UIButton *)sender {
    [self dismissViewController];
}


@end
