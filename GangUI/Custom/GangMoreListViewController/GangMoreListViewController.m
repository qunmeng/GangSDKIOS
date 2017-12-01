//
//  GangMoreListViewController.m
//  GangSDKDemo
//
//  Created by codone on 2017/7/31.
//  Copyright © 2017年 codone. All rights reserved.
//

#import "GangMoreListViewController.h"

@interface GangMoreListViewController ()

@end

@implementation GangMoreListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setTheInit{
    [super setTheInit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return GangColor_statusBar_style;
}

-(void)gang_toast:(NSString *)message{
    [self.view toastTheMsg:message];
}

-(void)gang_loading:(NSString *)info{
    [self.view showLoadingWithInfo:info];
}
-(void)gang_updataLoading:(NSString *)info{
    [self.view updateLoadingWithInfo:info];
}

-(void)gang_removeLoading{
    [self.view removeLoading];
}

@end
