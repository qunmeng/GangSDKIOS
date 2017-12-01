//
//  GangBasePresentViewController.m
//  GangSDKDemo
//
//  Created by codone on 2017/7/31.
//  Copyright © 2017年 codone. All rights reserved.
//

#import "GangBasePresentViewController.h"
#import "GangTools.h"

@interface GangBasePresentViewController (){
    UIView *bg;
    float add_centerY;
}

@end

@implementation GangBasePresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)setTheDatas{
    [super setTheDatas];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWillShow:(NSNotification*)aNotification{
    if (!self.keyboardAutoFitDisable) {
        CGFloat aDuration = [[aNotification userInfo][UIKeyboardAnimationDurationUserInfoKey] floatValue];
        CGRect kbFrame = [[aNotification userInfo][UIKeyboardFrameEndUserInfoKey] CGRectValue];
        if (kbFrame.size.height>([UIScreen mainScreen].bounds.size.height-self.height_view)/2) {
            [UIView animateWithDuration:aDuration animations:^{
                add_centerY = kbFrame.size.height-([UIScreen mainScreen].bounds.size.height-self.height_view)/2;
                self.constraint_centerY.constant = -add_centerY;
                [self.view layoutIfNeeded];
            }];
        }
    }
}

-(void)keyboardWillHide:(NSNotification*)aNotification{
    if (!self.keyboardAutoFitDisable) {
        CGFloat aDuration = [[aNotification userInfo][UIKeyboardAnimationDurationUserInfoKey] floatValue];
        [UIView animateWithDuration:aDuration animations:^{
            self.constraint_centerY.constant = 0;
            [self.view layoutIfNeeded];
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 */

-(void)setTheContrainerViewBeforeAdd:(UIView *)containerView{
    bg = [[UIView alloc] init];
    bg.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    [containerView addSubViewToEqual:bg];
    [UIView animateWithDuration:0.2 animations:^{
        bg.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    }];
}

-(void)setTheContrainerViewBeforeRemove:(UIView *)containerView{
    [bg removeFromSuperview];
}

/**
 *设置输入法弹出控制
 *@param height 显示的view的高度
 *@param yConstraint 居中显示的界面的y轴约束
 */
-(void)setupKeyboardManageForHeight:(float)height atCenterY:(NSLayoutConstraint *)yConstraint{
    self.height_view = height;
    self.constraint_centerY = yConstraint;
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

-(void)dismissViewControllerAfterAnimation{
    [self dismissViewControllerAfterDelay:0.25f];
}
-(void)dismissViewControllerAfterDelay:(float)delay{
    [self performSelector:@selector(dismissViewController) withObject:nil afterDelay:delay];
}

@end
