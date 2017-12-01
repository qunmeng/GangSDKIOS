//
//  GangUI.m
//  GangSDK
//
//  Created by codone on 2017/8/10.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangUI.h"
#import <GangSDK/GangSDK.h>
#import "GangUpdateRoleNameViewController.h"
#import "GangBaseNavigationController.h"
#import "GangOutViewController.h"
#import "GangInViewController.h"
#import "GangGangInfoViewController.h"

@interface GangUI ()<GangUpdateRoleNameDelegate>
@property(weak) UIViewController *passVc;
@property(weak) UINavigationController *fromNavigationVc;
@property(weak) UIViewController *topController;
@property(weak) UIViewController *pushNavigationVc;
@property(assign) BOOL navigationBarHidden;
@end

@implementation GangUI

+(void)startUI:(UIViewController *)controller userId:(NSString *)gameUserid nickname:(NSString *)nickname headIconUrl:(NSString *)headIconUrl gameLevel:(NSInteger)gameLevel gameRole:(NSString *)gameRole extParams:(NSDictionary *)extDic success:(void (^)(void))success failure:(void (^)(NSError * _Nullable))failure{
    [GangSDKInstance login:gameUserid nickname:nickname headIconUrl:headIconUrl gameLevel:gameLevel gameRole:gameRole extParams:extDic success:^{
        if (GangSDKInstance.userBean) {
            if (GangSDKInstance.settingBean) {
                [[GangUI instance] jumpFromController:controller];
            }else{
                GangLog(@"------GangSDK------>gangSDK获取设置失败");
            }
        }else{
            GangLog(@"------GangSDK------>gangSDK初始化失败");
        }
        if (success) {
            success();
        }
    } failure:^(NSError * _Nullable error) {
        if (error) {
            [[UIApplication sharedApplication].keyWindow toastTheMsg:error.domain];
        }
        if (failure) {
            failure(error);
        }
    }];
}

+(void)startUI:(UIViewController *)controller success:(void (^)(void))success failure:(void (^)(NSError * _Nullable))failure{
    [self startUI:controller userId:nil nickname:nil headIconUrl:nil gameLevel:0 gameRole:nil extParams:nil success:success failure:failure];
}

+(void)startUI:(UIViewController *)controller userId:(NSString *)gameUserid success:(void (^)(void))success failure:(void (^)(NSError * _Nullable))failure{
    [self startUI:controller userId:gameUserid nickname:nil headIconUrl:nil gameLevel:0 gameRole:nil extParams:nil success:success failure:failure];
}

+(void)startUI:(UIViewController *)controller userId:(NSString *)gameUserid nickname:(NSString *)nickname success:(void (^)(void))success failure:(void (^)(NSError * _Nullable))failure{
    [self startUI:controller userId:gameUserid nickname:nickname headIconUrl:nil gameLevel:0 gameRole:nil extParams:nil success:success failure:failure];
}

+(void)startUI:(UIViewController *)controller userId:(NSString *)gameUserid nickname:(NSString *)nickname headIconUrl:(NSString *)headIconUrl success:(void (^)(void))success failure:(void (^)(NSError * _Nullable))failure{
    [self startUI:controller userId:gameUserid nickname:nickname headIconUrl:headIconUrl gameLevel:0 gameRole:nil extParams:nil success:success failure:failure];
}

+(void)startUI:(UIViewController *)controller{
    if (GangSDKInstance.userBean) {
        if (GangSDKInstance.settingBean) {
            [[GangUI instance] jumpFromController:controller];
        }else{
            GangLog(@"------GangSDK------>gangSDK获取设置失败");
        }
    }else{
        GangLog(@"------GangSDK------>gangSDK初始化失败");
    }
}

+(void)showGangInfo:(UIViewController *)controller ofId:(NSString *)consortiaid{
    if ([consortiaid intValue]>0) {
        GangGangInfoViewController *vc = [[GangGangInfoViewController alloc] init];
        vc.consortiaid = consortiaid;
        [controller presentViewController:vc animated:YES completion:nil];
    }
}

#pragma mark - private

- (void)jumpFromController:(UIViewController*)controller{
    self.passVc = controller;
    if (GangSDKInstance.userBean.data.nickname.length>0) {
        UIViewController *vc;
        if ([GangSDKInstance.userBean.data.consortiaid integerValue]>0) {
            vc = [[GangInViewController alloc] init];
        }else{
            vc = [[GangOutViewController alloc] init];
        }
        if ([controller isKindOfClass:[UINavigationController class]]) {
            [GangUI instance].fromNavigationVc = (UINavigationController*)controller;
            [GangUI instance].topController = [(UINavigationController*)controller topViewController];
            [GangUI instance].navigationBarHidden = [(UINavigationController*)controller isNavigationBarHidden];
            [GangUI instance].fromNavigationVc.navigationBarHidden = YES;
            [(UINavigationController*)controller pushViewController:vc animated:YES];
        }else{
            GangBaseNavigationController *nav = [[GangBaseNavigationController alloc] initWithRootViewController:vc];
            [GangUI instance].pushNavigationVc = nav;
            [controller presentViewController:nav animated:YES completion:nil];
        }
        [[GangUI instance] registLoginOtherPlatNotify];
    }else{
        GangUpdateRoleNameViewController *vc = [[GangUpdateRoleNameViewController alloc] init];
        vc.delegate = [GangUI instance];
        [controller presentViewController:vc animated:YES completion:nil];
    }
}

#pragma mark - updated nickname
-(void)updated{
    [self jumpFromController:self.passVc];
}

+(instancetype)instance{
    static dispatch_once_t onceToken;
    static GangUI *instance;
    dispatch_once(&onceToken, ^{
        instance = [[GangUI alloc] init];
    });
    return instance;
}

-(void)registLoginOtherPlatNotify{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOnOtherPlat) name:Gang_notify_receiveLoginOnOtherPlat object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNavigationBarHidden) name:@"changeNavigationBarHidden" object:nil];
}

//账号在其他地方登录了
-(void)loginOnOtherPlat{
    [[UIApplication sharedApplication].keyWindow toastTheMsg:[GangTools getLocalizationOfKey:@"您的账号在其他地方登录了!"]];
    if (self.fromNavigationVc&&self.topController) {
        if (self.fromNavigationVc.presentedViewController) {
            [self.fromNavigationVc dismissViewControllerAnimated:YES completion:^{
                [self.fromNavigationVc popToViewController:self.topController animated:YES];
            }];
        }else{
            [self.fromNavigationVc popToViewController:self.topController animated:YES];
        }
        self.fromNavigationVc.navigationBarHidden = self.navigationBarHidden;
    }else if (self.pushNavigationVc) {
        if (self.pushNavigationVc.presentedViewController) {
            [self.pushNavigationVc dismissViewControllerAnimated:YES completion:^{
                [self.pushNavigationVc dismissViewControllerAnimated:YES completion:nil];
            }];
        }else{
            [self.pushNavigationVc dismissViewControllerAnimated:YES completion:nil];
        }
    }
}

//恢复传入的navigationController navigationiBarHidden状态
-(void)changeNavigationBarHidden{
    if (self.fromNavigationVc) {
        self.fromNavigationVc.navigationBarHidden = self.navigationBarHidden;
    }
}

@end
