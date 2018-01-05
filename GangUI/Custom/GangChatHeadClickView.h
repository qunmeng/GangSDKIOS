//
//  GangChatHeadClickView.h
//  Demo
//
//  Created by codone on 2017/12/11.
//  Copyright © 2017年 qm. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GangChatHeadClickDelegate <NSObject>
@optional
-(void)singleChat:(id)obj;
-(void)showUserInfo:(id)obj;
-(void)showGangInfo:(id)obj;
@end

@interface GangChatHeadClickView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *iv_head;
@property (weak, nonatomic) IBOutlet UIButton *btn_singleChat;
@property (weak, nonatomic) IBOutlet UIButton *btn_showUserInfo;
@property (weak, nonatomic) IBOutlet UIButton *btn_gangInfo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_gangInfo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_margin_top_gangInfo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_x;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_y;
@property(weak) id obj;
@property(weak) id<GangChatHeadClickDelegate> delegate;
-(void)hideGangInfo:(BOOL)hide;

-(void)showInView:(UIView*)superView;
-(void)removeSelf;

+(instancetype)getInstance;
@end
