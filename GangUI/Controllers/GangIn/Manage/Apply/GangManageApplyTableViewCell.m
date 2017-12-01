//
//  GangManageApplyTableViewCell.m
//  GangSDK
//
//  Created by codone on 2017/8/4.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangManageApplyTableViewCell.h"
#import <GangSupport/MGWebImage.h>

@implementation GangManageApplyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.label_gameRole setTextColor:[UIColor colorFromHexRGB:GangColor_invent_role]];
    [self.label_gameLevel setTextColor:[UIColor colorFromHexRGB:GangColor_invent_name]];
    [self.label_nickname setTextColor:[UIColor colorFromHexRGB:GangColor_invent_name]];
    
    [self.btn_agree setTitle:@"同意" forState: UIControlStateNormal];
    [self.btn_agree setTitleColor:[UIColor colorFromHexRGB:GangColor_invent_agree] forState:UIControlStateNormal];
    
    [self.btn_ignore setTitle:@"忽略" forState: UIControlStateNormal];
    [self.btn_ignore setTitleColor:[UIColor colorFromHexRGB:GangColor_invent_refuse] forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setTheObj:(GangUserBeanData*)obj{
    [super setTheObj:obj];
    [self.iv_head setImageWithURLString:obj.iconurl];
    self.label_nickname.text = obj.nickname;
    self.label_gameLevel.text = [NSString stringWithFormat:@"Lv.%ld",(long)obj.gamelevel];
    self.view_level.hidden = obj.gamelevel==0;
    self.label_gameRole.text = obj.gamerole;
    switch (obj.status) {
        case 0:{//未处理
            self.label_status.hidden = YES;
            self.btn_agree.hidden = NO;
            self.btn_ignore.hidden = NO;
        }
            break;
            
        case 1:{//已通过
            self.label_status.hidden = NO;
            self.label_status.text = @"已通过";
            self.btn_agree.hidden = YES;
            self.btn_ignore.hidden = YES;
        }
            break;
            
        case 2:{//已拒绝
            self.label_status.hidden = NO;
            self.label_status.text = @"已拒绝";
            self.btn_agree.hidden = YES;
            self.btn_ignore.hidden = YES;
        }
            break;
            
        default:
            break;
    }
}

- (IBAction)btn_ignore_click:(id)sender {
    GangUserBeanData *user = self.obj_hold;
    [[UIApplication sharedApplication].keyWindow showLoadingWithInfo:@"正在请求数据"];
    [GangSDKInstance.groupManager acceptApplicationOfUserWithId:user.applicationid status:2 success:^(id  _Nullable data) {
        [[UIApplication sharedApplication].keyWindow removeLoading];
        user.status = 2;
        if (self.baseCellDelegate&&[self.baseCellDelegate respondsToSelector:@selector(selector1:)]) {
            [self.baseCellDelegate selector1:self.obj_hold];
        }
    } fail:^(NSError * _Nullable error) {
        [[UIApplication sharedApplication].keyWindow removeLoading];
        if (error) {
            [[UIApplication sharedApplication].keyWindow toastTheMsg:error.domain];
        }
    }];
}
- (IBAction)btn_agree_click:(id)sender {
    GangUserBeanData *user = self.obj_hold;
    [[UIApplication sharedApplication].keyWindow showLoadingWithInfo:@"正在请求数据"];
    [GangSDKInstance.groupManager acceptApplicationOfUserWithId:user.applicationid status:1 success:^(id  _Nullable data) {
        [[UIApplication sharedApplication].keyWindow removeLoading];
        user.status = 1;
        if (self.baseCellDelegate&&[self.baseCellDelegate respondsToSelector:@selector(selector1:)]) {
            [self.baseCellDelegate selector1:self.obj_hold];
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:Gang_notify_MembersChanged object:nil];
    } fail:^(NSError * _Nullable error) {
        [[UIApplication sharedApplication].keyWindow removeLoading];
        if (error) {
            [[UIApplication sharedApplication].keyWindow toastTheMsg:error.domain];
        }
    }];
}
@end
