//
//  GangChatViewController.m
//  GangSDK
//
//  Created by codone on 2017/7/31.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangChatViewController.h"
#import "GangBaseTableView.h"
#import "GangChatTopLoadMoreTableView.h"
#import "GangChatLeftTableViewCell.h"
#import "GangChatRightTableViewCell.h"
#import "GangChatSystemTableViewCell.h"
#import "GangChatLeftVoiceTableViewCell.h"
#import "GangChatRightVoiceTableViewCell.h"
#import "GangChatResponseLeftTableViewCell.h"
#import "GangChatResponseRightTableViewCell.h"
#import "GangChatTipsTableViewCell.h"
#import "GangChatAttacksTableViewCell.h"
#import <GangSupport/GangRecordTool.h>
#import <GangSupport/CodoneViewController+SettingAlert.h>
#import "GangMemberInfoViewController.h"
#import "GangDonateViewController.h"
#import "GangGangInfoViewController.h"
#import <GangSDK/GangAttackBean.h>
#import "GangMonsterAttackViewController.h"
#import "GangWaterTreeViewController.h"
#import <GangSupport/CodoneTimerHander.h>

@interface GangChatViewController ()<UITableViewDataSource,UITableViewDelegate,GangBaseTableViewCellDelegate,TableViewTopLoadMoreDelegate,LVRecordToolDelegate>{
    BOOL isRecording;
}
@property(strong)CodoneTimerHander *hander;
@property(strong)CodoneTimerHander *hander_GangScroll;/**<禁止gang滚动*/
@property(strong)CodoneTimerHander *hander_WorldScroll;/**<禁止world滚动*/
@property(assign) BOOL tipsTimeout;
@property (weak, nonatomic) IBOutlet GangBaseTableView *tableView_tips;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraiint_height_tipsTableView;

@property (weak, nonatomic) IBOutlet UIView *view_gang;
@property (weak, nonatomic) IBOutlet GangChatTopLoadMoreTableView *tableView_gang;
@property (weak, nonatomic) IBOutlet GangChatTopLoadMoreTableView *tableView_world;
@property (weak, nonatomic) IBOutlet UIView *view_moreAction;
@property (weak, nonatomic) IBOutlet UIView *view_showActions;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_height_showActions;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_bottom_inputView;
@property (weak, nonatomic) IBOutlet UIButton *btn_msgAndVoice;
@property (weak, nonatomic) IBOutlet UIView *view_input;
@property (weak, nonatomic) IBOutlet UITextView *tv_input;
@property (weak, nonatomic) IBOutlet UILabel *label_tvPlaceHolder;
@property (weak, nonatomic) IBOutlet UIButton *btn_gangMessage;
@property (weak, nonatomic) IBOutlet UIButton *btn_worldMessage;
@property (weak, nonatomic) IBOutlet UIButton *btn_send;
@property (weak, nonatomic) IBOutlet UIButton *btn_record;
@property (weak, nonatomic) IBOutlet UIButton *btn_moreAction;
@property (weak, nonatomic) IBOutlet UIImageView *bg_record;
@property (weak, nonatomic) IBOutlet UIView *view_showRecord;
@property (weak, nonatomic) IBOutlet UIImageView *iv_recordVoice;

@property(assign) BOOL isWorldShow;
@end

@implementation GangChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)setTheDatas{
    [super setTheDatas];
    [self setUpHideInputTap];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshWorldTableView) name:Gang_notify_receiveWorldMessage object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshGangTableView) name:Gang_notify_receiveGangMessage object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTipsForTips) name:Gang_notify_receiveGangTip object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTips) name:Gang_notify_receiveGangAttack object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tvTextChanged:) name:UITextViewTextDidChangeNotification object:nil];
}

-(void)keyboardWillShow:(NSNotification*)aNotification{
    if (!self.keyboardAutoFitDisable) {
        if (self.tv_input.isFirstResponder) {
            CGFloat aDuration = [[aNotification userInfo][UIKeyboardAnimationDurationUserInfoKey] floatValue];
            CGRect kbFrame = [[aNotification userInfo][UIKeyboardFrameEndUserInfoKey] CGRectValue];
            [UIView animateWithDuration:aDuration animations:^{
                self.constraint_bottom_inputView.constant = kbFrame.size.height;
                [self.view layoutIfNeeded];
            }];
        }
    }
    [self scrollChatsToBottom];
}

-(void)keyboardWillHide:(NSNotification*)aNotification{
    if (!self.keyboardAutoFitDisable) {
        if (self.tv_input.isFirstResponder) {
            CGFloat aDuration = [[aNotification userInfo][UIKeyboardAnimationDurationUserInfoKey] floatValue];
            [UIView animateWithDuration:aDuration animations:^{
                self.constraint_bottom_inputView.constant = 18;
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

-(void)refreshWorldTableView{
    [self.tableView_world reloadData];
    if (!self.isWorldShow||!self.hander_WorldScroll) {
        [self.tableView_world scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:GangSDKInstance.chatManager.messages_world.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

-(void)refreshGangTableView{
    [self.tableView_gang reloadData];
    if (self.isWorldShow||!self.hander_GangScroll) {
        [self.tableView_gang scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:GangSDKInstance.chatManager.messages_gang.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

-(void)setTheSubviews{
    [super setTheSubviews];
    
    UILongPressGestureRecognizer *pressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressGestureRecognize:)];
    pressGestureRecognizer.minimumPressDuration = 0;
    [self.btn_record addGestureRecognizer:pressGestureRecognizer];
    
    self.tableView_gang.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
    self.tableView_gang.loadMoreDelegate = self;
    self.tableView_world.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
    self.tableView_world.loadMoreDelegate = self;
    
    //设置消息输入框的字体颜色
    [self.tv_input setTextColor:[UIColor colorFromHexRGB:GangColor_gangChat_textFieldPlaceholder]];
    [self.tv_input setTintColor:[UIColor colorFromHexRGB:GangColor_gangChat_textFieldPlaceholder]];
    [self.btn_gangMessage setTitleColor:[UIColor colorFromHexRGB:GangColor_gangChat_channelSelected] forState:UIControlStateNormal];
    [self.btn_gangMessage setTitle:[NSString stringWithFormat:@"%@%@",GangSDKInstance.settingBean.data.gamevariable.gangname,[GangTools getLocalizationOfKey:@"频道"]] forState:UIControlStateNormal];
    [self.btn_worldMessage setTitleColor:[UIColor colorFromHexRGB:GangColor_gangChat_channelNormal] forState:UIControlStateNormal];
    [self.btn_worldMessage setTitle:[GangTools getLocalizationOfKey:@"招募频道"] forState:UIControlStateNormal];
    self.label_tvPlaceHolder.text = [GangTools getLocalizationOfKey:@"想说点什么"];
    self.label_tvPlaceHolder.textColor = [UIColor colorFromHexRGB:GangColor_gangChat_textFieldPlaceholder];
    [self.btn_send setTitleColor:[UIColor colorFromHexRGB:GangColor_gangChat_sendMessageButton] forState:UIControlStateNormal];
    [self.btn_send setTitle:[GangTools getLocalizationOfKey:@"发送"] forState:UIControlStateNormal];
    [self.btn_record setTitleColor:[UIColor colorFromHexRGB:GangColor_gangChat_voiceButtonTitle] forState:UIControlStateNormal];
    float y = 0;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, y, 32, 23)];
    btn.titleLabel.font = [UIFont systemFontOfSize:10];
    btn.titleLabel.numberOfLines = 0;
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn addTarget:self action:@selector(btn_donate_click) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:[GangTools getLocalizationOfKey:@"捐献"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"qm_btn_gangchat_pop_more_action"] forState:UIControlStateNormal];
    [self.view_showActions addSubview:btn];
    y += 23;
    if (GangSDKInstance.settingBean.data.gameconfig.is_use_callup_function_flag) {
        //分割线
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(-3.5, y+2, 39, 0.5)];
        line.image = [UIImage imageNamed:@"qm_image_gangchat_pop_line"];
        [self.view_showActions addSubview:line];
        //按钮
        y += 4.5;
        btn = [[UIButton alloc] initWithFrame:CGRectMake(0, y, 32, 23)];
        btn.titleLabel.font = [UIFont systemFontOfSize:10];
        btn.titleLabel.numberOfLines = 0;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [btn addTarget:self action:@selector(btn_zhaojiling_click) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:[GangTools getLocalizationOfKey:@"召集令"] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"qm_btn_gangchat_pop_more_action"] forState:UIControlStateNormal];
        [self.view_showActions addSubview:btn];
        y += 23;
    }
    self.constraint_height_showActions.constant = y;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self scrollChatsToBottom];
    });
    
    [self refreshTips];
    
    if (GangSDKInstance.chatManager.messages_gang.count==0) {
        [self.tableView_gang startLoad];
    }
    if (GangSDKInstance.chatManager.messages_world.count==0) {
        [self.tableView_world startLoad];
    }
}

//gang滚动计时
-(void)handerGang{
    __weak GangChatViewController *weakSelf = self;
    if (self.hander_GangScroll) {
        [self.hander_GangScroll stop];
    }
    self.hander_GangScroll = [CodoneTimerHander initWithInterVal:1 objHolder:@(0) whenReapt:^(CodoneTimerHander *obj) {
        int t = [obj.obj intValue] + 1;
        obj.obj = @(t);
        if (t>=10) {
            [obj stop];
            weakSelf.hander_GangScroll = nil;
        }
    }];
    [self.hander_GangScroll start];
}

//world滚动计时
-(void)handerWorld{
    __weak GangChatViewController *weakSelf = self;
    if (self.hander_WorldScroll) {
        [self.hander_WorldScroll stop];
    }
    self.hander_WorldScroll = [CodoneTimerHander initWithInterVal:1 objHolder:@(10) whenReapt:^(CodoneTimerHander *obj) {
        int t = [obj.obj intValue] + 1;
        obj.obj = @(t);
        if (t>=10) {
            [obj stop];
            weakSelf.hander_WorldScroll = nil;
        }
    }];
    [self.hander_WorldScroll start];
}


#pragma mark - loadmore delegate
-(void)loadMoreDatas:(id)sender{
    if (sender==self.tableView_gang) {
        NSString *timeStr = @"";
        if (GangSDKInstance.chatManager.messages_gang.count>0) {
            timeStr = ((GangChatMessageBean*)(GangSDKInstance.chatManager.messages_gang[0])).createtime;
        }
        [GangSDKInstance.chatManager getChatHistory:timeStr pageSize:GangPageSize inChannel:2 success:^(GangChatListBean * _Nullable data) {
            if (data.data.count>0) {
                if (!GangSDKInstance.chatManager.messages_gang) {
                    GangSDKInstance.chatManager.messages_gang = [NSMutableArray array];
                }
                [GangSDKInstance.chatManager.messages_gang insertObjects:data.data atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, data.data.count)]];
                [self.tableView_gang reloadData];
                if (GangSDKInstance.chatManager.messages_gang.count==data.data.count) {
                    [self.tableView_gang scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:GangSDKInstance.chatManager.messages_gang.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                }else{
                    [self.tableView_gang scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:data.data.count inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                }
            }
            if (data.data.count==GangPageSize) {
                [self.tableView_gang endLoadMoreDatas:NO];
            }else{
                [self.tableView_gang hideTheRefreshHeader:YES];
            }
        } fail:^(NSError * _Nullable error) {
            [self.tableView_gang endLoadMoreDatas:NO];
            if (error) {
                [self gang_toast:error.domain];
            }
        }];
    }else{
        NSString *timeStr = @"";
        if (GangSDKInstance.chatManager.messages_world.count>0) {
            timeStr = ((GangChatMessageBean*)(GangSDKInstance.chatManager.messages_world[0])).createtime;
        }
        [GangSDKInstance.chatManager getChatHistory:timeStr pageSize:GangPageSize inChannel:1 success:^(GangChatListBean * _Nullable data) {
            if (data.data.count>0) {
                if (!GangSDKInstance.chatManager.messages_world) {
                    GangSDKInstance.chatManager.messages_world = [NSMutableArray array];
                }
                [GangSDKInstance.chatManager.messages_world insertObjects:data.data atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, data.data.count)]];
                [self.tableView_world reloadData];
                if (GangSDKInstance.chatManager.messages_world.count==data.data.count) {
                    [self.tableView_world scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:GangSDKInstance.chatManager.messages_world.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                }else{
                    [self.tableView_world scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:data.data.count inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                }
            }
            if (data.data.count==GangPageSize) {
                [self.tableView_world endLoadMoreDatas:NO];
            }else{
                [self.tableView_world hideTheRefreshHeader:YES];
            }
        } fail:^(NSError * _Nullable error) {
            [self.tableView_world endLoadMoreDatas:NO];
            if (error) {
                [self gang_toast:error.domain];
            }
        }];
    }
}

- (void)btn_donate_click {
    self.view_moreAction.hidden = YES;
    [self presentViewController:[[GangDonateViewController alloc] init] animated:YES completion:nil];
}
- (void)btn_zhaojiling_click {
    self.view_moreAction.hidden = YES;
}

-(void)scrollChatsToBottom{
    if (self.isWorldShow) {
        float y = self.tableView_world.contentSize.height-self.tableView_world.bounds.size.height;
        if (y<0) {
            y=0;
        }
        [self.tableView_world scrollRectToVisible:CGRectMake(0, y, self.tableView_world.bounds.size.width, self.tableView_world.bounds.size.height) animated:NO];
    }else{
        float y = self.tableView_gang.contentSize.height-self.tableView_gang.bounds.size.height;
        if (y<0) {
            y=0;
        }
        [self.tableView_gang scrollRectToVisible:CGRectMake(0, y, self.tableView_gang.bounds.size.width, self.tableView_gang.bounds.size.height) animated:NO];
    }
}

-(void)refreshTipsForTips{
    self.tipsTimeout = NO;
    [self refreshTips];
}

//刷新提示栏
-(void)refreshTips{
    __weak GangChatViewController *weakSelf = self;
    float height_tip = 0.0;
    for (int i=0; i<GangSDKInstance.chatManager.messages_gangTips.count; i++) {
        id tip = GangSDKInstance.chatManager.messages_gangTips[i];
        if ([tip isKindOfClass:[NSString class]]) {
            if (!self.tipsTimeout) {
                height_tip += [self.tableView_tips computeTheCellHeight:@"GangChatTipsTableViewCell" withObj:tip];
                if (!self.hander) {
                    self.hander = [CodoneTimerHander initWithInterVal:1 objHolder:@(0) whenReapt:^(CodoneTimerHander *obj) {
                        int t = [obj.obj intValue] + 1;
                        obj.obj = @(t);
                        if (t>=60) {
                            [obj stop];
                            weakSelf.hander = nil;
                            weakSelf.tipsTimeout = YES;
                            [weakSelf refreshTips];
                        }
                    }];
                    [self.hander start];
                }
            }
        }else{
            height_tip += [self.tableView_tips computeTheCellHeight:@"GangChatAttacksTableViewCell" withObj:tip];
        }
    }
    self.constraiint_height_tipsTableView.constant = height_tip;
    [self.tableView_tips reloadData];
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

- (IBAction)btn_gangMessage_click:(id)sender {
    [self.btn_gangMessage setTitleColor:[UIColor colorFromHexRGB:GangColor_gangChat_channelSelected] forState:UIControlStateNormal];
    [self.btn_worldMessage setTitleColor:[UIColor colorFromHexRGB:GangColor_gangChat_channelNormal] forState:UIControlStateNormal];
    [self.btn_gangMessage setBackgroundImage:[UIImage imageNamed:@"qm_btn_gangchat_selected"] forState:UIControlStateNormal];
    [self.btn_worldMessage setBackgroundImage:[UIImage imageNamed:@"qm_btn_gangchat_normal"] forState:UIControlStateNormal];
    self.tableView_world.hidden = YES;
    self.view_gang.hidden = NO;
    self.isWorldShow = NO;
    self.btn_moreAction.enabled = YES;
    [self scrollChatsToBottom];
}
- (IBAction)btn_wordMessage_click:(id)sender {
    [self.btn_gangMessage setTitleColor:[UIColor colorFromHexRGB:GangColor_gangChat_channelNormal] forState:UIControlStateNormal];
    [self.btn_worldMessage setTitleColor:[UIColor colorFromHexRGB:GangColor_gangChat_channelSelected] forState:UIControlStateNormal];
    [self.btn_gangMessage setBackgroundImage:[UIImage imageNamed:@"qm_btn_gangchat_normal"] forState:UIControlStateNormal];
    [self.btn_worldMessage setBackgroundImage:[UIImage imageNamed:@"qm_btn_gangchat_selected"] forState:UIControlStateNormal];
    self.tableView_world.hidden = NO;
    self.view_gang.hidden = YES;
    self.isWorldShow = YES;
    self.btn_moreAction.enabled = NO;
    [self scrollChatsToBottom];
}
- (IBAction)btn_moreAction_click:(id)sender {
    [self.tv_input resignFirstResponder];
    self.view_moreAction.hidden = NO;
}
- (IBAction)tap_view_moreAction:(id)sender {
    self.view_moreAction.hidden = YES;
}


- (IBAction)btn_msgAndVoice_click:(id)sender {
    [self.tv_input resignFirstResponder];
    if (0==self.btn_msgAndVoice.tag) {
        [self.btn_msgAndVoice setImage:[UIImage imageNamed:@"qm_btn_gangchat_keyboard"] forState:UIControlStateNormal];
        [self.tv_input endEditing:YES];
        self.view_input.hidden = YES;
        self.label_tvPlaceHolder.hidden = YES;
        self.tv_input.hidden = YES;
        self.btn_send.hidden = YES;
        self.btn_record.hidden = NO;
        self.bg_record.hidden = NO;
        self.btn_msgAndVoice.tag = 1;
    }else{
        [self.btn_msgAndVoice setImage:[UIImage imageNamed:@"qm_btn_gangchat_voice"] forState:UIControlStateNormal];
        [self.tv_input becomeFirstResponder];
        self.view_input.hidden = NO;
        self.label_tvPlaceHolder.hidden = self.tv_input.text.length>0;
        self.tv_input.hidden = NO;
        self.btn_send.hidden = NO;
        self.btn_record.hidden = YES;
        self.bg_record.hidden = YES;
        self.btn_msgAndVoice.tag = 0;
    }
}

-(void)tvTextChanged:(id)sender{
    if (self.tv_input.text.length==0) {
        self.label_tvPlaceHolder.hidden = NO;
    }else{
        self.label_tvPlaceHolder.hidden = YES;
    }
}

#pragma mark -delegate
-(void)recordTool:(GangRecordTool *)recordTool didstartRecoring:(int)no{
    self.iv_recordVoice.image = [UIImage imageNamed:[NSString stringWithFormat:@"qm_record_tone%d",no]];
    if ([GangRecordTool sharedRecordTool].recorder.currentTime>59) {
        [self btn_record_touchEvent_upInside:self.btn_record];
    }
}

#pragma mark - panGegsture
-(void)pressGestureRecognize:(UIPanGestureRecognizer *)recognizer{
    CGPoint point = [recognizer locationInView:self.btn_record];
    CGRect rect = self.btn_record.bounds;
    rect.origin.x -= 16;
    rect.origin.y -= 16;
    rect.size.width += 32;
    rect.size.height += 32;
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            [self btn_record_touchEvent_down:self.btn_record];
            break;
            
        case UIGestureRecognizerStateChanged:
            if (CGRectContainsPoint(rect, point)) {
                [self btn_record_touchEvent_dragEnter:self.btn_record];
            }else{
                [self btn_record_touchEvent_dragExit:self.btn_record];
            }
            break;
        case UIGestureRecognizerStateEnded:
            if (CGRectContainsPoint(rect, point)) {
                [self btn_record_touchEvent_upInside:self.btn_record];
            }else{
                [self btn_record_touchEvent_upOut:self.btn_record];
            }
            break;
        case UIGestureRecognizerStateCancelled:
            [self btn_record_touchEvent_cancel:self.btn_record];
            break;
        case UIGestureRecognizerStateFailed:
            break;
        default:
            break;
    }
}
#pragma record
- (void)btn_record_touchEvent_down:(id)sender {
    if (!isRecording) {
        __weak GangChatViewController *weakSelf = self;
        if (AVAudioSessionRecordPermissionGranted==[AVAudioSession sharedInstance].recordPermission) {
            isRecording = YES;
            AVAudioSession *audioSession = AVAudioSession.sharedInstance;
            if (@available(iOS 10.0, *)) {
                [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord mode:AVAudioSession.sharedInstance.mode options:AVAudioSession.sharedInstance.categoryOptions error:nil];
            } else {
                [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSession.sharedInstance.categoryOptions error:nil];
            }
            [GangRecordTool sharedRecordTool].delegate = self;
            [[GangRecordTool sharedRecordTool]startRecording];
            self.bg_record.image = [UIImage imageNamed:@"qm_btn_gangchat_stop_talk"];
            [self.btn_record setTitle:@"松开 结束" forState:UIControlStateNormal];
            [self.btn_record setTitleColor:[UIColor colorFromHexRGB:GangColor_gangChat_endVoiceButtonTitle] forState:UIControlStateNormal];
            self.view_showRecord.hidden = NO;
        }else if(AVAudioSessionRecordPermissionDenied==[AVAudioSession sharedInstance].recordPermission){
            [weakSelf showAletToSettingFor:3];
        }else{
            [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                
            }];
        }
    }
}
- (void)btn_record_touchEvent_cancel:(id)sender {
    if (isRecording) {
        self.view_showRecord.hidden = YES;
        [GangRecordTool sharedRecordTool].delegate = nil;
        self.bg_record.image = [UIImage imageNamed:@"qm_btn_gangchat_press_on"];
        [self.btn_record setTitle:@"按住 说话" forState:UIControlStateNormal];
        [self.btn_record setTitleColor:[UIColor colorFromHexRGB:GangColor_gangChat_voiceButtonTitle] forState:UIControlStateNormal];
        [[GangRecordTool sharedRecordTool] stopRecording];
        [[GangRecordTool sharedRecordTool] destructionRecordingFile];
        isRecording = NO;
    }
}
- (void)btn_record_touchEvent_dragExit:(id)sender {
    if (isRecording) {
        self.bg_record.image = [UIImage imageNamed:@"qm_btn_gangchat_stop_talk"];
        [self.btn_record setTitle:@"松开手指，取消录音" forState:UIControlStateNormal];
        [self.btn_record setTitleColor:[UIColor colorFromHexRGB:GangColor_gangChat_endVoiceButtonTitle] forState:UIControlStateNormal];
    }
}
- (void)btn_record_touchEvent_dragEnter:(id)sender {
    if (isRecording) {
        self.bg_record.image = [UIImage imageNamed:@"qm_btn_gangchat_stop_talk"];
        [self.btn_record setTitle:@"松开 结束" forState:UIControlStateNormal];
        [self.btn_record setTitleColor:[UIColor colorFromHexRGB:GangColor_gangChat_endVoiceButtonTitle] forState:UIControlStateNormal];
    }
}
- (void)btn_record_touchEvent_upOut:(id)sender {
    if (isRecording) {
        self.view_showRecord.hidden = YES;
        [GangRecordTool sharedRecordTool].delegate = nil;
        self.bg_record.image = [UIImage imageNamed:@"qm_btn_gangchat_press_on"];
        [self.btn_record setTitle:@"按住 说话" forState:UIControlStateNormal];
        [self.btn_record setTitleColor:[UIColor colorFromHexRGB:GangColor_gangChat_voiceButtonTitle] forState:UIControlStateNormal];
        [[GangRecordTool sharedRecordTool] stopRecording];
        [[GangRecordTool sharedRecordTool] destructionRecordingFile];
        isRecording = NO;
    }
}
- (void)btn_record_touchEvent_upInside:(id)sender {
    if (isRecording) {
        self.view_showRecord.hidden = YES;
        [GangRecordTool sharedRecordTool].delegate = nil;
        self.bg_record.image = [UIImage imageNamed:@"qm_btn_gangchat_press_on"];
        [self.btn_record setTitle:@"按住 说话" forState:UIControlStateNormal];
        [self.btn_record setTitleColor:[UIColor colorFromHexRGB:GangColor_gangChat_voiceButtonTitle] forState:UIControlStateNormal];
        if ([GangRecordTool sharedRecordTool].recorder.currentTime < 1){
            if ([GangRecordTool sharedRecordTool].recorder.currentTime>0) {
                [self gang_toast:@"录音时间太短"];
            }
            [[GangRecordTool sharedRecordTool] stopRecording];
            [[GangRecordTool sharedRecordTool] destructionRecordingFile];
        }else {
            int voiceSeconds = [GangRecordTool sharedRecordTool].recorder.currentTime;
            [[GangRecordTool sharedRecordTool] stopRecording];
            NSString *file = [[GangRecordTool sharedRecordTool] toMp3];
            NSData *d = [NSData dataWithContentsOfFile:file];
            [self sendVoiceData:d second:voiceSeconds];
        }
        isRecording = NO;
    }
}

-(void)sendVoiceData:(id)data second:(int)voiceSeconds{
//    [self gang_loading:@"正在提交数据"];
    self.btn_record.enabled = NO;
    [GangSDKInstance.chatManager sendVoiceMessage:data withName:@"iphone.mp3" ofTimes:voiceSeconds inChannel:self.isWorldShow?1:2 success:^{
//        [self gang_removeLoading];
        self.btn_record.enabled = YES;
    } fail:^(NSError * _Nullable error) {
//        [self gang_removeLoading];
        self.btn_record.enabled = YES;
        if (error){
            [self gang_toast:error.domain];
        }
    } progress:^(double percent) {
//        [self gang_updataLoading:[NSString stringWithFormat:@"已提交:%d%%",(int)(percent*100)]];
    }];
}

- (IBAction)btn_send_click:(id)sender {
    NSString *str_message = self.tv_input.text;
    if ([GangTools stringFromString:str_message deleteCharSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        if ([self.tv_input isFirstResponder]) {
            [[UIApplication sharedApplication].keyWindow toastTheMsg:@"请输入内容!" atPosition:POSITION_TOP duration:1.5];
        }else{
            [self gang_toast:@"请输入内容!"];
        }
        return;
    }else if ([CodoneTools countTheStrLength:str_message]>50) {
        [self gang_toast:@"最多输入50个字!"];
        return;
    }
    //        [self gang_loading:@"正在提交数据"];
    self.btn_send.enabled = NO;
    [GangSDKInstance.chatManager sendTextMessage:str_message inChannel:self.isWorldShow?1:2 success:^{
        //            [self gang_removeLoading];
        self.btn_send.enabled = YES;
        self.tv_input.text = nil;
        self.label_tvPlaceHolder.hidden = NO;
    } fail:^(NSError * _Nullable error) {
        //            [self gang_removeLoading];
        self.btn_send.enabled = YES;
        if (error){
            if ([self.tv_input isFirstResponder]) {
                [self.view toastTheMsg:error.domain atPosition:POSITION_TOP duration:1.5];
            }else{
                [self gang_toast:error.domain];
            }
        }
    }];
}

#pragma scrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView==self.tableView_world) {
        [self handerWorld];
    }else{
        [self handerGang];
    }
}

#pragma dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.tableView_tips==tableView) {
        return GangSDKInstance.chatManager.messages_gangTips.count;
    }else if (self.tableView_world==tableView) {
        return GangSDKInstance.chatManager.messages_world.count;
    }else if (self.tableView_gang==tableView) {
        return GangSDKInstance.chatManager.messages_gang.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tableView_tips==tableView) {
        id tip = GangSDKInstance.chatManager.messages_gangTips[indexPath.row];
        if ([tip isKindOfClass:[NSString class]]) {
            GangChatTipsTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"chatTipsCell"];
            if (!cell) {
                [tableView registerNib:[UINib nibWithNibName:@"GangChatTipsTableViewCell" bundle:nil] forCellReuseIdentifier:@"chatTipsCell"];
                cell =[tableView dequeueReusableCellWithIdentifier:@"chatTipsCell"];
            }
            [cell setTheObj:tip];
            cell.alpha = 0;
            [UIView animateWithDuration:0.3 animations:^{
                cell.alpha = 1;
            }];
            cell.hidden = self.tipsTimeout;
            return cell;
        }else{
            GangChatAttacksTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"chatAttackCell"];
            if (!cell) {
                [tableView registerNib:[UINib nibWithNibName:@"GangChatAttacksTableViewCell" bundle:nil] forCellReuseIdentifier:@"chatAttackCell"];
                cell =[tableView dequeueReusableCellWithIdentifier:@"chatAttackCell"];
            }
            cell.baseCellDelegate = self;
            [cell setTheObj:tip];
            cell.alpha = 0;
            [UIView animateWithDuration:0.3 animations:^{
                cell.alpha = 1;
            }];
            return cell;
        }
        
    }else if (self.tableView_world==tableView||self.tableView_gang==tableView) {
        GangChatMessageBean *bean;
        BOOL needShowTime = NO;
        if (self.tableView_world==tableView) {
            bean = GangSDKInstance.chatManager.messages_world[indexPath.row];
//            if (indexPath.row>0) {
//                GangChatMessageBean *beforeBean = GangSDKInstance.chatManager.messages_world[indexPath.row-1];
//                if (([bean.createtime integerValue]-[beforeBean.createtime integerValue])/1000>60*2) {
//                    needShowTime = YES;
//                }
//            }
        }else{
            bean = GangSDKInstance.chatManager.messages_gang[indexPath.row];
//            if (indexPath.row>0) {
//                GangChatMessageBean *beforeBean = GangSDKInstance.chatManager.messages_gang[indexPath.row-1];
//                if (([bean.createtime integerValue]-[beforeBean.createtime integerValue])/1000>60*2) {
//                    needShowTime = YES;
//                }
//            }
        }
        switch (bean.messagetype) {
            case 1:
                if ([bean.userid isEqualToString:@"0"]) {
                    GangChatSystemTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"systemCell"];
                    if (!cell) {
                        [tableView registerNib:[UINib nibWithNibName:@"GangChatSystemTableViewCell" bundle:nil] forCellReuseIdentifier:@"systemCell"];
                        cell =[tableView dequeueReusableCellWithIdentifier:@"systemCell"];
                    }
                    [cell setTheObj:bean];
                    [cell showTime:needShowTime];
                    return cell;
                }else{
                    if ([bean.userid isEqualToString:GangSDKInstance.userBean.data.userid]) {
                        GangChatRightTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"chatRightCell"];
                        if (!cell) {
                            [tableView registerNib:[UINib nibWithNibName:@"GangChatRightTableViewCell" bundle:nil] forCellReuseIdentifier:@"chatRightCell"];
                            cell =[tableView dequeueReusableCellWithIdentifier:@"chatRightCell"];
                        }
                        cell.baseCellDelegate = self;
                        cell.isWorld = tableView==self.tableView_world;
                        [cell setTheObj:bean];
                        [cell showTime:needShowTime];
                        
                        return cell;
                    }else{
                        GangChatLeftTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"chatLeftCell"];
                        if (!cell) {
                            [tableView registerNib:[UINib nibWithNibName:@"GangChatLeftTableViewCell" bundle:nil] forCellReuseIdentifier:@"chatLeftCell"];
                            cell =[tableView dequeueReusableCellWithIdentifier:@"chatLeftCell"];
                        }
                        cell.baseCellDelegate = self;
                        cell.isWorld = tableView==self.tableView_world;
                        [cell setTheObj:bean];
                        [cell showTime:needShowTime];
                        return cell;
                    }
                }
                break;
                
            case 2:
                if ([bean.userid isEqualToString:GangSDKInstance.userBean.data.userid]) {
                    GangChatRightVoiceTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"chatRightVoiceCell"];
                    if (!cell) {
                        [tableView registerNib:[UINib nibWithNibName:@"GangChatRightVoiceTableViewCell" bundle:nil] forCellReuseIdentifier:@"chatRightVoiceCell"];
                        cell =[tableView dequeueReusableCellWithIdentifier:@"chatRightVoiceCell"];
                    }
                    cell.baseCellDelegate = self;
                    cell.isWorld = tableView==self.tableView_world;
                    [cell setTheObj:bean];
                    [cell showTime:needShowTime];
                    return cell;
                }else{
                    GangChatLeftVoiceTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"chatLeftVoiceCell"];
                    if (!cell) {
                        [tableView registerNib:[UINib nibWithNibName:@"GangChatLeftVoiceTableViewCell" bundle:nil] forCellReuseIdentifier:@"chatLeftVoiceCell"];
                        cell =[tableView dequeueReusableCellWithIdentifier:@"chatLeftVoiceCell"];
                    }
                    cell.baseCellDelegate = self;
                    cell.isWorld = tableView==self.tableView_world;
                    [cell setTheObj:bean];
                    [cell showTime:needShowTime];
                    return cell;
                }
                break;
                
            case 3:
                if ([bean.userid isEqualToString:GangSDKInstance.userBean.data.userid]) {
                    GangChatResponseRightTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"chatResponseRightCell"];
                    if (!cell) {
                        [tableView registerNib:[UINib nibWithNibName:@"GangChatResponseRightTableViewCell" bundle:nil] forCellReuseIdentifier:@"chatResponseRightCell"];
                        cell =[tableView dequeueReusableCellWithIdentifier:@"chatResponseRightCell"];
                    }
                    cell.baseCellDelegate = self;
                    cell.isWorld = tableView==self.tableView_world;
                    [cell setTheObj:bean];
                    [cell showTime:needShowTime];
                    return cell;
                }else{
                    GangChatResponseLeftTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"chatResponseLeftCell"];
                    if (!cell) {
                        [tableView registerNib:[UINib nibWithNibName:@"GangChatResponseLeftTableViewCell" bundle:nil] forCellReuseIdentifier:@"chatResponseLeftCell"];
                        cell =[tableView dequeueReusableCellWithIdentifier:@"chatResponseLeftCell"];
                    }
                    cell.baseCellDelegate = self;
                    cell.isWorld = tableView==self.tableView_world;
                    [cell setTheObj:bean];
                    [cell showTime:needShowTime];
                    return cell;
                }
                break;
                
            default:
                break;
        }
    }
    return nil;
}
#pragma delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.tableView_tips==tableView) {
        id tip = GangSDKInstance.chatManager.messages_gangTips[indexPath.row];
        if ([tip isKindOfClass:[NSString class]]) {
            return self.tipsTimeout?0:[self.tableView_tips computeTheCellHeight:@"GangChatTipsTableViewCell" withObj:tip];
        }else{
            return [self.tableView_tips computeTheCellHeight:@"GangChatAttacksTableViewCell" withObj:tip];
        }
    }else if (self.tableView_world==tableView||self.tableView_gang==tableView) {
        float add_time = 0;
        GangChatMessageBean *bean;
        if (self.tableView_world==tableView) {
            bean = GangSDKInstance.chatManager.messages_world[indexPath.row];
//            if (indexPath.row>0) {
//                GangChatMessageBean *beforeBean = GangSDKInstance.chatManager.messages_world[indexPath.row-1];
//                if (([bean.createtime integerValue]-[beforeBean.createtime integerValue])/1000>60*2) {
//                    add_time = 30;
//                }
//            }
        }else{
            bean = GangSDKInstance.chatManager.messages_gang[indexPath.row];
//            if (indexPath.row>0) {
//                GangChatMessageBean *beforeBean = GangSDKInstance.chatManager.messages_gang[indexPath.row-1];
//                if (([bean.createtime integerValue]-[beforeBean.createtime integerValue])/1000>60*2) {
//                    add_time = 30;
//                }
//            }
        }
        switch (bean.messagetype) {
            case 1:
                if ([bean.userid isEqualToString:@"0"]) {
                    return [self.tableView_gang computeTheCellHeight:@"GangChatSystemTableViewCell" withObj:bean];
                }else{
                    if ([bean.userid isEqualToString:GangSDKInstance.userBean.data.userid]) {
                        return [self.tableView_gang computeTheCellHeight:@"GangChatRightTableViewCell" withObj:bean]+add_time;
                    }else{
                        return [self.tableView_gang computeTheCellHeight:@"GangChatLeftTableViewCell" withObj:bean]+add_time;
                    }
                }
                break;
                
            case 2:
                if ([bean.userid isEqualToString:GangSDKInstance.userBean.data.userid]) {
                    return [self.tableView_gang computeTheCellHeight:@"GangChatRightVoiceTableViewCell" withObj:bean]+add_time;
                }else{
                    return [self.tableView_gang computeTheCellHeight:@"GangChatLeftVoiceTableViewCell" withObj:bean]+add_time;
                }
                break;
                
            case 3:
                if ([bean.userid isEqualToString:GangSDKInstance.userBean.data.userid]) {
                    return [self.tableView_gang computeTheCellHeight:@"GangChatResponseRightTableViewCell" withObj:bean]+add_time;
                    
                }else{
                    return [self.tableView_gang computeTheCellHeight:@"GangChatResponseLeftTableViewCell" withObj:bean]+add_time;
                }
                break;
                
            default:
                break;
        }
    }
    return 0;
}

#pragma basecelldelegate
-(void)selector1:(id)obj{
    if ([obj isKindOfClass:[GangChatMessageBean class]]) {
        GangChatMessageBean *bean = obj;
        if (self.isWorldShow) {
            if ([bean.userid isEqualToString:GangSDKInstance.userBean.data.userid]) {
                if ([GangSDKInstance.userBean.data.consortiaid integerValue]>0) {
                    GangGangInfoViewController *infoVC = [[GangGangInfoViewController alloc] init];
                    infoVC.consortiaid = GangSDKInstance.userBean.data.consortiaid;
                    [self presentViewController:infoVC animated:YES completion:nil];
                } else {
                    [self gang_toast:[NSString stringWithFormat:@"您还没有加入%@",GangSDKInstance.settingBean.data.gamevariable.gangname]];
                }
            }else{
                if ([bean.consortiaid integerValue]>0) {
                    GangGangInfoViewController *infoVC = [[GangGangInfoViewController alloc] init];
                    infoVC.consortiaid = bean.consortiaid;
                    [self presentViewController:infoVC animated:YES completion:nil];
                } else {
                    [self gang_toast:[NSString stringWithFormat:@"他还没有加入%@",GangSDKInstance.settingBean.data.gamevariable.gangname]];
                }
            }
        }else{
            GangMemberInfoViewController *vc = [[GangMemberInfoViewController alloc] init];
            vc.userid = bean.userid;
            [self pushViewController:vc];
        }
    }else if ([obj isKindOfClass:[GangAttackBean class]]){
        GangAttackBean *bean = obj;
        switch (bean.type) {
            case 0:
            {
                GangMonsterAttackViewController *vc = [[GangMonsterAttackViewController alloc]init];
                vc.bean = bean;
                [self presentViewController:vc animated:YES completion:nil];
            }
                break;
                
            case 1:
            {
                GangWaterTreeViewController *vc = [[GangWaterTreeViewController alloc]init];
                vc.bean = bean;
                [self presentViewController:vc animated:YES completion:nil];
            }
                break;
                
            default:
                break;
        }
    }
}

-(void)dealloc{
    if (self.hander) {
        [self.hander stop];
        self.hander = nil;
    }
    if (self.hander_GangScroll) {
        [self.hander_GangScroll stop];
        self.hander_GangScroll = nil;
    }
    if (self.hander_WorldScroll) {
        [self.hander_WorldScroll stop];
        self.hander_WorldScroll = nil;
    }
}
@end

