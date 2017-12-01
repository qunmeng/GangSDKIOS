//
//  GangGameViewController.m
//  GangSDK
//
//  Created by codone on 2017/9/8.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangMonsterAttackViewController.h"
#import <GangSupport/CodoneAnimationHelper.h>
#import <GangSupport/MGWebImage.h>

@interface GangMonsterAttackViewController ()<CAAnimationDelegate>{
    int tapCount;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_width_percent;
@property (weak, nonatomic) IBOutlet UIImageView *iv_blood;
@property (weak, nonatomic) IBOutlet UIImageView *iv_empty;

@end

@implementation GangMonsterAttackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.label_title.textColor = [UIColor colorFromHexRGB:GangColor_pop_monster_title];
    self.label_title.text = [GangTools getLocalizationOfKey:@"怪兽突袭"];
    self.iv_blood.backgroundColor = [UIColor colorFromHexRGB:GangColor_pop_monster_blood];
    self.iv_empty.backgroundColor = [UIColor colorFromHexRGB:GangColor_pop_monster_empty];
    [self.btn_action setTitle:[GangTools getLocalizationOfKey:@"点击攻击"] forState:UIControlStateNormal];
    [self.iv_image setImageWithURLString:self.bean.taskiconurl];
    [self.btn_action setTitleColor:[UIColor colorFromHexRGB:GangColor_pop_monster_attackButton] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_close_click:(id)sender {
    [self dismissViewController];
}

- (IBAction)btn_action_click:(id)sender {
    CATextLayer *layer = [CATextLayer layer];
    layer.frame = CGRectMake(140, 160, 80, 40);
    layer.string = [NSString stringWithFormat:@"%d",rand()%10000];
    layer.foregroundColor = [UIColor redColor].CGColor;
    
    [self.iv_image.layer addSublayer:layer];
    
    CABasicAnimation *animation_scale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation_scale.fromValue = @(1);
    animation_scale.toValue = @(0.2);
    CABasicAnimation *animation_position = [CABasicAnimation animationWithKeyPath:@"position"];
    animation_position.fromValue = [NSValue valueWithCGPoint:CGPointMake(180, 180)];
    animation_position.toValue = [NSValue valueWithCGPoint:CGPointMake(240, 40)];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    [group setValue:layer forKey:@"layer"];
    group.delegate = self;
    group.animations = @[animation_scale,animation_position];
    group.duration = 1;
    group.removedOnCompletion = YES;
    [layer addAnimation:group forKey:@"sv"];
    
    tapCount++;
    if (tapCount<=10) {
        self.constraint_width_percent.constant = tapCount*220/10;
    }
    if (tapCount>=10) {
        self.btn_action.enabled = NO;
        [[UIApplication sharedApplication].keyWindow showLoadingWithInfo:@"正在请求数据"];
        [GangSDKInstance.groupManager dealTask:self.bean.tasktype taskid:self.bean.taskid success:^(id  _Nullable data) {
            [[UIApplication sharedApplication].keyWindow removeLoading];
            [self dismissViewControllerAfterAnimation];
            [GangSDKInstance.chatManager.messages_gangTips removeObject:self.bean];
            [[NSNotificationCenter defaultCenter] postNotificationName:Gang_notify_receiveGangAttack object:nil];
        } fail:^(NSError * _Nullable error) {
            self.btn_action.enabled = YES;
            [[UIApplication sharedApplication].keyWindow removeLoading];
            if (error) {
                [[UIApplication sharedApplication].keyWindow toastTheMsg:error.domain];
            }
        }];
    }
}

#pragma delegate
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    CALayer *layer = [anim valueForKey:@"layer"];
    [layer removeFromSuperlayer];
}

@end
