//
//  GangRecruitViewController.m
//  GangSDK
//
//  Created by 雪狼 on 2017/7/31.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangRecruitViewController.h"
#import "GangBaseTableView.h"
#import "GangChatTopLoadMoreTableView.h"
#import <GangSupport/GangRecordTool.h>
#import <GangSupport/CodoneViewController+SettingAlert.h>
#import "GangChatLeftTableViewCell.h"
#import "GangChatRightTableViewCell.h"
#import "GangChatSystemTableViewCell.h"
#import "GangChatLeftVoiceTableViewCell.h"
#import "GangChatRightVoiceTableViewCell.h"
#import "GangChatResponseLeftTableViewCell.h"
#import "GangChatResponseRightTableViewCell.h"
#import "GangChatLeftLinkTableViewCell.h"
#import "GangChatRightLinkTableViewCell.h"
#import "GangChatDefaultTableViewCell.h"
#import <GangSDK/GangChatMessageBean.h>
#import <GangSupport/CodoneTimerHander.h>
#import "GangChatHeadClickView.h"
#import <GangSupport/MGWebImage.h>
#import "GangMemberInfoViewController.h"
#import "GangGangInfoViewController.h"

@interface GangRecruitViewController ()<UITableViewDataSource,UITableViewDelegate,TableViewTopLoadMoreDelegate,LVRecordToolDelegate,GangBaseTableViewCellDelegate,GangChatHeadClickDelegate>{
    BOOL isRecording;
    GangChatMessageBean *user_singleChating;
}
@property(strong)CodoneTimerHander *hander;
@property(strong)CodoneTimerHander *hander_WorldScroll;/**<禁止world滚动*/
@property(strong)CodoneTimerHander *hander_SingleScroll;/**<禁止single滚动*/

@property (weak, nonatomic) IBOutlet GangChatTopLoadMoreTableView *tableView_world;
@property (weak, nonatomic) IBOutlet GangChatTopLoadMoreTableView *tableView_single;

@property (weak, nonatomic) IBOutlet UITextView *tv_input;
@property (weak, nonatomic) IBOutlet UIButton *btn_record;
@property (weak, nonatomic) IBOutlet UIButton *btn_msgAndVoice;
@property (weak, nonatomic) IBOutlet UIButton *btn_send;
@property (weak, nonatomic) IBOutlet UILabel *label_tvPlaceHolder;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constraint_bottom_inputView;
@property (weak, nonatomic) IBOutlet UIImageView *iv_bg_inputTextField;
@property (weak, nonatomic) IBOutlet UIView *view_showRecord;
@property (weak, nonatomic) IBOutlet UIImageView *iv_recordVoice;
@property (weak, nonatomic) IBOutlet UIImageView *bg_record;
@property (weak, nonatomic) IBOutlet UIButton *btn_worldMessage;
@property (weak, nonatomic) IBOutlet UIButton *btn_singleMessage;

@property(assign) int chatType;

@end

@implementation GangRecruitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)setTheDatas{
    [super setTheDatas];
    [self setUpHideInputTap];
    //注册通知,监听键盘弹出事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //注册通知,监听键盘消失事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    //注册通知,监听textView状态改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tvTextChanged:) name:UITextViewTextDidChangeNotification object:nil];
    //注册通知,刷新招募信息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshWorldTableView) name:Gang_notify_receiveWorldMessage object:nil];
    //注册通知，刷新私聊信息
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshSingleTableView) name:Gang_notify_receiveSingleMessage object:nil];
    
    self.chatType = 1;
}

- (void)setTheSubviews{
    [super setTheSubviews];
    
    UILongPressGestureRecognizer *pressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressGestureRecognize:)];
    pressGestureRecognizer.minimumPressDuration = 0;
    [self.btn_record addGestureRecognizer:pressGestureRecognizer];
    
    [self.btn_worldMessage setTitleColor:[UIColor colorFromHexRGB:GangColor_gangChat_channelSelected] forState:UIControlStateNormal];
    [self.btn_worldMessage setTitle:[GangTools getLocalizationOfKey:@"招募频道"] forState:UIControlStateNormal];
    [self.btn_singleMessage setTitleColor:[UIColor colorFromHexRGB:GangColor_gangChat_channelNormal] forState:UIControlStateNormal];
    [self.btn_singleMessage setTitle:[GangTools getLocalizationOfKey:@"私聊频道"] forState:UIControlStateNormal];
    
    self.tableView_world.parentController = self;
    self.tableView_world.loadMoreDelegate = self;
    self.tableView_world.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView_single.parentController = self;
    self.tableView_single.loadMoreDelegate = self;
    self.tableView_single.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //设置语音按钮的颜色
    [self.btn_record setTitleColor:[UIColor colorFromHexRGB:GangColor_recruit_voiceButtonTitle] forState:UIControlStateNormal];
    //设置发送按钮的标题颜色
    [self.btn_send setTitle:@"发送" forState:UIControlStateNormal];
    [self.btn_send setTitleColor:[UIColor colorFromHexRGB:GangColor_recruit_sendMessageButton] forState:UIControlStateNormal];
    //设置占位符字体颜色
    [self.label_tvPlaceHolder setTextColor:[UIColor colorFromHexRGB:GangColor_recruit_textFieldPlaceholder]];
    //设置消息输入框的字体颜色
    [self.tv_input setTextColor:[UIColor colorFromHexRGB:GangColor_recruit_textFieldPlaceholder]];
    [self.tv_input setTintColor:[UIColor colorFromHexRGB:GangColor_recruit_textFieldPlaceholder]];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self scrollChatsToBottom];
    });
    
    if (GangSDKInstance.chatManager.messages_world.count<GangPageSize) {
        [self.tableView_world startLoad];
    }
    if (GangSDKInstance.chatManager.messages_single.count<GangPageSize) {
        [self.tableView_single startLoad];
    }
}

-(void)firstShowViews{
    [super firstShowViews];
    [self.tableView_world beEnable];
    [self.tableView_single beEnable];
}

//world滚动计时
-(void)handerWorld{
    __weak GangRecruitViewController *weakSelf = self;
    if (self.hander_WorldScroll) {
        [self.hander_WorldScroll stop];
    }
    self.hander_WorldScroll = [CodoneTimerHander initWithInterVal:1 objHolder:@(0) whenReapt:^(CodoneTimerHander *obj) {
        int t = [obj.obj intValue] + 1;
        obj.obj = @(t);
        if (t>=10) {
            [obj stop];
            weakSelf.hander_WorldScroll = nil;
        }
    }];
    [self.hander_WorldScroll start];
}

//single滚动计时
-(void)handerSingle{
    __weak GangRecruitViewController *weakSelf = self;
    if (self.hander_SingleScroll) {
        [self.hander_SingleScroll stop];
    }
    self.hander_SingleScroll = [CodoneTimerHander initWithInterVal:1 objHolder:@(0) whenReapt:^(CodoneTimerHander *obj) {
        int t = [obj.obj intValue] + 1;
        obj.obj = @(t);
        if (t>=10) {
            [obj stop];
            weakSelf.hander_SingleScroll = nil;
        }
    }];
    [self.hander_SingleScroll start];
    
}

- (void)scrollChatsToBottom{
    switch (self.chatType) {
        case 1:
            if (GangSDKInstance.chatManager.messages_world.count>0) {
                [self.tableView_world scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:GangSDKInstance.chatManager.messages_world.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            }
            break;
        case 3:
            if (GangSDKInstance.chatManager.messages_single.count>0) {
                [self.tableView_single scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:GangSDKInstance.chatManager.messages_single.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            }
            break;
            
        default:
            break;
    }
}

#pragma mark - loadmore delegate
- (void)loadMoreDatas:(id)sender{
    if (sender == self.tableView_world) {
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
    }else {
        NSString *timeStr = @"";
        if (GangSDKInstance.chatManager.messages_single.count>0) {
            timeStr = ((GangChatMessageBean*)(GangSDKInstance.chatManager.messages_single[0])).createtime;
        }
        [GangSDKInstance.chatManager getChatHistory:timeStr pageSize:GangPageSize inChannel:3 success:^(GangChatListBean * _Nullable data) {
            if (data.data.count>0) {
                if (!GangSDKInstance.chatManager.messages_single) {
                    GangSDKInstance.chatManager.messages_single = [NSMutableArray array];
                }
                [GangSDKInstance.chatManager.messages_single insertObjects:data.data atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, data.data.count)]];
                [self.tableView_single reloadData];
                if (GangSDKInstance.chatManager.messages_single.count==data.data.count) {
                    [self.tableView_single scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:GangSDKInstance.chatManager.messages_single.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                }else{
                    [self.tableView_single scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:data.data.count inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
                }
            }
            if (data.data.count==GangPageSize) {
                [self.tableView_single endLoadMoreDatas:NO];
            }else{
                [self.tableView_single hideTheRefreshHeader:YES];
            }
        } fail:^(NSError * _Nullable error) {
            [self.tableView_single endLoadMoreDatas:NO];
            if (error) {
                [self gang_toast:error.domain];
            }
        }];
    }
}

#pragma mark - keyboardAction

/**
 *键盘弹出时调用方法
 */
- (void)keyboardWillShow:(NSNotification*)aNotification{
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


/**
 *键盘消失时调用
 */
- (void)keyboardWillHide:(NSNotification*)aNotification{
    if (!self.keyboardAutoFitDisable) {
        if (self.tv_input.isFirstResponder) {
            CGFloat aDuration = [[aNotification userInfo][UIKeyboardAnimationDurationUserInfoKey] floatValue];
            [UIView animateWithDuration:aDuration animations:^{
                self.constraint_bottom_inputView.constant = 14;
                [self.view layoutIfNeeded];
            } completion:^(BOOL finished) {
                
            }];
        }
    }
}

- (void)refreshWorldTableView{
    [self.tableView_world reloadData];
    if (self.chatType!=1||!self.hander_WorldScroll) {
        [self.tableView_world scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:GangSDKInstance.chatManager.messages_world.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (void)refreshSingleTableView{
    [self.tableView_single reloadData];
    if (self.chatType!=3||!self.hander_SingleScroll) {
        [self.tableView_single scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:GangSDKInstance.chatManager.messages_single.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (void)tvTextChanged:(id)sender{
    self.label_tvPlaceHolder.hidden = YES;
    if (user_singleChating) {
        NSRange range = [self.tv_input.text rangeOfString:[NSString stringWithFormat:@"@%@ ",user_singleChating.nickname]];
        if (range.location==0&&range.length>0) {
            if (range.length<self.tv_input.text.length) {
                self.btn_send.enabled = YES;
            }else{
                self.btn_send.enabled = NO;
            }
        }else{
            self.label_tvPlaceHolder.hidden = NO;
            user_singleChating = nil;
            self.tv_input.text = nil;
            self.btn_send.enabled = NO;
            if (self.chatType!=3) {
                self.btn_msgAndVoice.enabled = YES;
            }
        }
    }else{
        if (self.tv_input.text.length==0) {
            self.label_tvPlaceHolder.hidden = NO;
            self.btn_send.enabled = NO;
        }else if (self.chatType!=3){
            self.btn_send.enabled = YES;
        }
    }
}

#pragma mark -delegate
- (void)recordTool:(GangRecordTool *)recordTool didstartRecoring:(int)no{
    self.iv_recordVoice.image = [UIImage imageNamed:[NSString stringWithFormat:@"qm_record_tone%d",no]];
    if ([GangRecordTool sharedRecordTool].recorder.currentTime>59) {
        [self btn_record_touchEvent_upInside:self.btn_record];
    }
}


#pragma mark - recordButtonAction
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
#pragma mark -开始录音-
- (void)btn_record_touchEvent_down:(UIButton *)sender {
    if (!isRecording) {
        __weak GangRecruitViewController *weakSelf = self;
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
            [self.bg_record setImage:[UIImage imageNamed:@"qm_btn_gangchat_stop_talk"]];
            [self.btn_record setBackgroundImage:[UIImage imageNamed:@"qm_btn_gangchat_stop_talk"] forState:UIControlStateNormal];
            [self.btn_record setTitle:@"松开 结束" forState:UIControlStateNormal];
            [self.btn_record setTitleColor:[UIColor colorFromHexRGB:GangColor_recruit_endVoiceButtonTitle] forState:UIControlStateNormal];
            self.view_showRecord.hidden = NO;
        }else if(AVAudioSessionRecordPermissionDenied==[AVAudioSession sharedInstance].recordPermission){
            [weakSelf showAletToSettingFor:3];
        }else{
            [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
                
            }];
        }
    }
}

#pragma mark -提示取消发送-
- (void)btn_record_touchEvent_dragExit:(UIButton *)sender {
    if (isRecording) {
        [self.bg_record setImage:[UIImage imageNamed:@"qm_btn_gangchat_stop_talk"]];
        [self.btn_record setBackgroundImage:[UIImage imageNamed:@"qm_btn_gangchat_stop_talk"] forState:UIControlStateNormal];
        [self.btn_record setTitle:@"松开手指，取消录音" forState:UIControlStateNormal];
        [self.btn_record setTitleColor:[UIColor colorFromHexRGB:GangColor_recruit_endVoiceButtonTitle] forState:UIControlStateNormal];
    }
}

#pragma mark -提示松开发送语音消息-
- (void)btn_record_touchEvent_dragEnter:(UIButton *)sender {
    if (isRecording) {
        [self.bg_record setImage:[UIImage imageNamed:@"qm_btn_gangchat_stop_talk"]];
        [self.btn_record setBackgroundImage:[UIImage imageNamed:@"qm_btn_gangchat_stop_talk"] forState:UIControlStateNormal];
        [self.btn_record setTitle:@"松开 结束" forState:UIControlStateNormal];
        [self.btn_record setTitleColor:[UIColor colorFromHexRGB:GangColor_recruit_endVoiceButtonTitle] forState:UIControlStateNormal];
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

- (void)btn_record_touchEvent_upOut:(UIButton *)sender {
    if (isRecording) {
        self.view_showRecord.hidden = YES;
        [GangRecordTool sharedRecordTool].delegate = nil;
        [[GangRecordTool sharedRecordTool] stopRecording];
        [[GangRecordTool sharedRecordTool] destructionRecordingFile];
        [self.bg_record setImage:[UIImage imageNamed:@"qm_btn_gangchat_press_on"]];
        [self.btn_record setBackgroundImage:[UIImage imageNamed:@"qm_btn_gangchat_press_on"] forState:UIControlStateNormal];
        [self.btn_record setTitle:@"按住 说话" forState:UIControlStateNormal];
        [self.btn_record setTitleColor:[UIColor colorFromHexRGB:GangColor_recruit_voiceButtonTitle] forState:UIControlStateNormal];
        isRecording = NO;
    }
}

- (void)btn_record_touchEvent_upInside:(UIButton *)sender {
    if (isRecording) {
        self.view_showRecord.hidden = YES;
        [GangRecordTool sharedRecordTool].delegate = nil;
        [self.btn_record setBackgroundImage:[UIImage imageNamed:@"qm_btn_gangchat_press_on"] forState:UIControlStateNormal];
        [self.bg_record setImage:[UIImage imageNamed:@"qm_btn_gangchat_press_on"]];
        [self.btn_record setTitle:@"按住 说话" forState:UIControlStateNormal];
        [self.btn_record setTitleColor:[UIColor colorFromHexRGB:GangColor_recruit_voiceButtonTitle] forState:UIControlStateNormal];
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

/**
 *发送语音文件
 @param data 语音文件
 */
- (void)sendVoiceData:(id)data second:(int)voiceSeconds{
//    [self gang_loading:@"正在提交数据"];
    self.btn_record.enabled = NO;
    [GangSDKInstance.chatManager sendVoiceMessage:data withName:@"iphone.mp3" ofTimes:voiceSeconds inChannel:self.chatType success:^{
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

#pragma scrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView==self.tableView_world) {
        [self handerWorld];
    }else{
        [self handerSingle];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.tableView_world==tableView) {
        return GangSDKInstance.chatManager.messages_world.count;
    }
    else if (self.tableView_single==tableView) {
        return GangSDKInstance.chatManager.messages_single.count;
    }
    return 0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GangChatMessageBean *bean;
    BOOL needShowTime = NO;
    if (self.tableView_world ==tableView) {
        bean = GangSDKInstance.chatManager.messages_world[indexPath.row];
        //            if (indexPath.row > 0) {
        //                GangChatMessageBean *beforeBean = GangSDKInstance.chatManager.messages_world[indexPath.row-1];
        //                if (([bean.createtime integerValue]-[beforeBean.createtime integerValue])/1000>60*2) {
        //                    needShowTime = YES;
        //                }
        //            }
    }else {
        bean = GangSDKInstance.chatManager.messages_single[indexPath.row];
    ////            if (indexPath.row>0) {
    ////                GangChatMessageBean *beforeBean = GangSDKInstance.chatManager.messages_single[indexPath.row-1];
    ////                if (([bean.createtime integerValue]-[beforeBean.createtime integerValue])/1000>60*2) {
    ////                    needShowTime = YES;
    ////                }
    ////            }
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
                    cell.isWorld = tableView==self.tableView_world;
                    cell.isSingle = tableView==self.tableView_single;
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
                    cell.isSingle = tableView==self.tableView_single;
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
                cell.isWorld = tableView==self.tableView_world;
                cell.isSingle = tableView==self.tableView_single;
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
                cell.isSingle = tableView==self.tableView_single;
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
                cell.isWorld = tableView==self.tableView_world;
                cell.isSingle = tableView==self.tableView_single;
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
                cell.isSingle = tableView==self.tableView_single;
                [cell setTheObj:bean];
                [cell showTime:needShowTime];
                return cell;
            }
            break;
            
        case 4:
            if ([bean.userid isEqualToString:GangSDKInstance.userBean.data.userid]) {
                GangChatRightLinkTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"chatRightLinkCell"];
                if (!cell) {
                    [tableView registerNib:[UINib nibWithNibName:@"GangChatRightLinkTableViewCell" bundle:nil] forCellReuseIdentifier:@"chatRightLinkCell"];
                    cell =[tableView dequeueReusableCellWithIdentifier:@"chatRightLinkCell"];
                }
                cell.navigationController = self.navigationController;
                cell.isWorld = tableView==self.tableView_world;
                cell.isSingle = tableView==self.tableView_single;
                [cell setTheObj:bean];
                [cell showTime:needShowTime];
                return cell;
            }else{
                GangChatLeftLinkTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"chatLeftLinkCell"];
                if (!cell) {
                    [tableView registerNib:[UINib nibWithNibName:@"GangChatLeftLinkTableViewCell" bundle:nil] forCellReuseIdentifier:@"chatLeftLinkCell"];
                    cell =[tableView dequeueReusableCellWithIdentifier:@"chatLeftLinkCell"];
                }
                cell.navigationController = self.navigationController;
                cell.baseCellDelegate = self;
                cell.isWorld = tableView==self.tableView_world;
                cell.isSingle = tableView==self.tableView_single;
                [cell setTheObj:bean];
                [cell showTime:needShowTime];
                return cell;
            }
            
        default:
        {
            GangChatDefaultTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"chatDefaultCell"];
            if (!cell) {
                [tableView registerNib:[UINib nibWithNibName:@"GangChatDefaultTableViewCell" bundle:nil] forCellReuseIdentifier:@"chatDefaultCell"];
                cell =[tableView dequeueReusableCellWithIdentifier:@"chatDefaultCell"];
            }
            cell.baseCellDelegate = self;
            cell.isWorld = tableView==self.tableView_world;
            cell.isSingle = tableView==self.tableView_single;
            [cell setTheObj:bean];
            [cell showTime:needShowTime];
            return cell;
        }
            break;
    }
    return nil;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    float add_time = 0;
    GangChatMessageBean *bean;
    if (self.tableView_world==tableView) {
        bean = GangSDKInstance.chatManager.messages_world[indexPath.row];
        //            if (indexPath.row > 0) {
        //                GangChatMessageBean *beforeBean = GangSDKInstance.chatManager.messages_world[indexPath.row-1];
        //                if (([bean.createtime integerValue] -[beforeBean.createtime integerValue])/1000>60*2) {
        //                    add_time = 30;
        //                }
        //            }
    }else{
        bean = GangSDKInstance.chatManager.messages_single[indexPath.row];
        //            if (indexPath.row > 0) {
        //                GangChatMessageBean *beforeBean = GangSDKInstance.chatManager.messages_single[indexPath.row-1];
        //                if (([bean.createtime integerValue] -[beforeBean.createtime integerValue])/1000>60*2) {
        //                    add_time = 30;
        //                }
        //            }
    }
    if (tableView==self.tableView_world) {
        switch (bean.messagetype) {
            case 1:
                if ([bean.userid isEqualToString:@"0"]) {
                    return [self.tableView_world computeTheCellHeight:@"GangChatSystemTableViewCell" withObj:bean];
                }else{
                    if ([bean.userid isEqualToString:GangSDKInstance.userBean.data.userid]) {
                        return [self.tableView_world computeTheCellHeight:@"GangChatRightTableViewCell" withObj:bean]+add_time;
                    }else{
                        return [self.tableView_world computeTheCellHeight:@"GangChatLeftTableViewCell" withObj:bean]+add_time;
                    }
                }
                break;
                
            case 2:
                if ([bean.userid isEqualToString:GangSDKInstance.userBean.data.userid]) {
                    return [self.tableView_world computeTheCellHeight:@"GangChatRightVoiceTableViewCell" withObj:bean]+add_time;
                }else{
                    return [self.tableView_world computeTheCellHeight:@"GangChatLeftVoiceTableViewCell" withObj:bean]+add_time;
                }
                break;
                
            case 3:
                if ([bean.userid isEqualToString:GangSDKInstance.userBean.data.userid]) {
                    return [self.tableView_world computeTheCellHeight:@"GangChatResponseRightTableViewCell" withObj:bean]+add_time;
                    
                }else{
                    return [self.tableView_world computeTheCellHeight:@"GangChatResponseLeftTableViewCell" withObj:bean]+add_time;
                }
                break;
                
            case 4:
                if ([bean.userid isEqualToString:GangSDKInstance.userBean.data.userid]) {
                    return [self.tableView_world computeTheCellHeight:@"GangChatRightLinkTableViewCell" withObj:bean]+add_time;
                    
                }else{
                    return [self.tableView_world computeTheCellHeight:@"GangChatLeftLinkTableViewCell" withObj:bean]+add_time;
                }
                break;
                
            default:
                return [self.tableView_world computeTheCellHeight:@"GangChatDefaultTableViewCell" withObj:bean]+add_time;
                break;
        }
    }else{
        switch (bean.messagetype) {
            case 1:
                if ([bean.userid isEqualToString:@"0"]) {
                    return [self.tableView_single computeTheCellHeight:@"GangChatSystemTableViewCell" withObj:bean];
                }else{
                    if ([bean.userid isEqualToString:GangSDKInstance.userBean.data.userid]) {
                        return [self.tableView_single computeTheCellHeight:@"GangChatRightTableViewCell" withObj:bean]+add_time;
                    }else{
                        return [self.tableView_single computeTheCellHeight:@"GangChatLeftTableViewCell" withObj:bean]+add_time;
                    }
                }
                break;
                
            case 2:
                if ([bean.userid isEqualToString:GangSDKInstance.userBean.data.userid]) {
                    return [self.tableView_single computeTheCellHeight:@"GangChatRightVoiceTableViewCell" withObj:bean]+add_time;
                }else{
                    return [self.tableView_single computeTheCellHeight:@"GangChatLeftVoiceTableViewCell" withObj:bean]+add_time;
                }
                break;
                
            case 3:
                if ([bean.userid isEqualToString:GangSDKInstance.userBean.data.userid]) {
                    return [self.tableView_single computeTheCellHeight:@"GangChatResponseRightTableViewCell" withObj:bean]+add_time;
                    
                }else{
                    return [self.tableView_single computeTheCellHeight:@"GangChatResponseLeftTableViewCell" withObj:bean]+add_time;
                }
                break;
                
            case 4:
                if ([bean.userid isEqualToString:GangSDKInstance.userBean.data.userid]) {
                    return [self.tableView_single computeTheCellHeight:@"GangChatRightLinkTableViewCell" withObj:bean]+add_time;
                    
                }else{
                    return [self.tableView_single computeTheCellHeight:@"GangChatLeftLinkTableViewCell" withObj:bean]+add_time;
                }
                break;
                
            default:
                return [self.tableView_single computeTheCellHeight:@"GangChatDefaultTableViewCell" withObj:bean]+add_time;
                break;
        }
    }
    return 0;
}

#pragma mark - buttonAction

- (IBAction)btn_wordMessage_click:(UIButton *)sender {
    if (user_singleChating) {
        if (self.tv_input.text.length>[NSString stringWithFormat:@"@%@ ",user_singleChating.nickname].length) {
            self.btn_send.enabled = YES;
        }
    }else{
        self.btn_msgAndVoice.enabled = YES;
        if (self.tv_input.text.length>0) {
            self.btn_send.enabled = YES;
        }
    }
    
    [self.btn_worldMessage setTitleColor:[UIColor colorFromHexRGB:GangColor_gangChat_channelSelected] forState:UIControlStateNormal];
    [self.btn_worldMessage setBackgroundImage:[UIImage imageNamed:@"qm_btn_gangchat_selected"] forState:UIControlStateNormal];
    self.tableView_world.hidden = NO;
    [self.btn_singleMessage setTitleColor:[UIColor colorFromHexRGB:GangColor_gangChat_channelNormal] forState:UIControlStateNormal];
    [self.btn_singleMessage setBackgroundImage:[UIImage imageNamed:@"qm_btn_gangchat_normal"] forState:UIControlStateNormal];
    self.tableView_single.hidden = YES;
    self.chatType = 1;
    [self scrollChatsToBottom];
}

- (IBAction)btn_singleMessage_click:(UIButton *)sender {
    self.btn_msgAndVoice.enabled = NO;
    self.btn_msgAndVoice.enabled = NO;
    if (user_singleChating&&(self.tv_input.text.length>[NSString stringWithFormat:@"@%@ ",user_singleChating.nickname].length)) {
        self.btn_send.enabled = YES;
    }else{
        self.btn_send.enabled = NO;
    }
    
    [self.btn_worldMessage setTitleColor:[UIColor colorFromHexRGB:GangColor_gangChat_channelNormal] forState:UIControlStateNormal];
    [self.btn_worldMessage setBackgroundImage:[UIImage imageNamed:@"qm_btn_gangchat_normal"] forState:UIControlStateNormal];
    self.tableView_world.hidden = YES;
    [self.btn_singleMessage setTitleColor:[UIColor colorFromHexRGB:GangColor_gangChat_channelSelected] forState:UIControlStateNormal];
    [self.btn_singleMessage setBackgroundImage:[UIImage imageNamed:@"qm_btn_gangchat_selected"] forState:UIControlStateNormal];
    self.tableView_single.hidden = NO;
    self.chatType = 3;
    [self scrollChatsToBottom];
}


- (IBAction)btn_msgAndVoice_click:(UIButton *)sender {
    [self.tv_input resignFirstResponder];
    if (0==self.btn_msgAndVoice.tag) {
        [self.btn_msgAndVoice setImage:[UIImage imageNamed:@"qm_btn_gangchat_keyboard"] forState:UIControlStateNormal];
        [self.tv_input endEditing:YES];
        self.label_tvPlaceHolder.hidden = YES;
        self.tv_input.hidden = YES;
        self.iv_bg_inputTextField.hidden = YES;
        self.btn_send.hidden = YES;
        self.btn_record.hidden = NO;
        self.bg_record.hidden = NO;
        self.btn_msgAndVoice.tag = 1;
    }else{
        [self.btn_msgAndVoice setImage:[UIImage imageNamed:@"qm_btn_gangchat_voice"] forState:UIControlStateNormal];
        [self.tv_input becomeFirstResponder];
        self.label_tvPlaceHolder.hidden = self.tv_input.text.length>0;
        self.tv_input.hidden = NO;
        self.btn_send.hidden = NO;
        self.iv_bg_inputTextField.hidden = NO;
        self.btn_record.hidden = YES;
        self.bg_record.hidden = YES;
        self.btn_msgAndVoice.tag = 0;
    }
}

- (IBAction)btn_sendClick:(UIButton *)sender {
    NSString *str_message;
    if (user_singleChating) {
        str_message = [self.tv_input.text substringFromIndex:[NSString stringWithFormat:@"@%@ ",user_singleChating.nickname].length];
    }else{
        str_message = self.tv_input.text;
    }
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
    self.btn_send.enabled = NO;
    if (user_singleChating) {
        [GangSDKInstance.chatManager sendSingleChatTextMessage:str_message toUserId:user_singleChating.userid success:^{
            //            [self gang_removeLoading];
            if (self.chatType==3) {
                self.tv_input.text = [NSString stringWithFormat:@"@%@ ",user_singleChating.nickname];
            }else{
                user_singleChating = nil;
                self.tv_input.text = nil;
                self.label_tvPlaceHolder.hidden = NO;
                self.btn_msgAndVoice.enabled = YES;
            }
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
    }else{
        [GangSDKInstance.chatManager sendTextMessage:str_message inChannel:self.chatType success:^{
            //            [self gang_removeLoading];
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
}

#pragma basecelldelegate
-(void)selector1:(id)obj{
    if ([obj isKindOfClass:[GangChatMessageBean class]]) {
        GangChatMessageBean *bean = obj;
        [GangChatHeadClickView getInstance].delegate = self;
        [GangChatHeadClickView getInstance].obj = obj;
        [GangChatHeadClickView getInstance].constraint_x.constant = bean.x;
        [GangChatHeadClickView getInstance].constraint_y.constant = bean.y;
        [[GangChatHeadClickView getInstance].iv_head setImageWithURLString:bean.iconurl];
        [[GangChatHeadClickView getInstance] showInView:[UIApplication sharedApplication].keyWindow];
    }
}

#pragma mark - headClickDelegate
-(void)singleChat:(id)obj{
    [self.btn_msgAndVoice setImage:[UIImage imageNamed:@"qm_btn_gangchat_voice"] forState:UIControlStateNormal];
    [self.tv_input becomeFirstResponder];
    self.tv_input.hidden = NO;
    self.btn_send.hidden = NO;
    self.iv_bg_inputTextField.hidden = NO;
    self.btn_record.hidden = YES;
    self.bg_record.hidden = YES;
    self.btn_msgAndVoice.tag = 0;
    
    GangChatMessageBean *bean = obj;
    user_singleChating = bean;
    self.label_tvPlaceHolder.hidden = YES;
    self.tv_input.text = [NSString stringWithFormat:@"@%@ ",bean.nickname];
    self.btn_send.enabled = NO;
    self.btn_msgAndVoice.enabled = NO;
    [self.tv_input becomeFirstResponder];
    
}
-(void)showUserInfo:(id)obj{
    GangChatMessageBean *bean = obj;
    GangMemberInfoViewController *vc = [[GangMemberInfoViewController alloc] init];
    vc.userid = bean.userid;
    vc.consortiaid = bean.consortiaid;
    [self pushViewController:vc];
}
-(void)showGangInfo:(id)obj{
    GangChatMessageBean *bean = obj;
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
}

-(void)dealloc{
    if (self.hander) {
        [self.hander stop];
        self.hander = nil;
    }
    if (self.hander_WorldScroll) {
        [self.hander_WorldScroll stop];
        self.hander_WorldScroll = nil;
    }
    if (self.hander_SingleScroll) {
        [self.hander_SingleScroll stop];
        self.hander_SingleScroll = nil;
    }
    GangSDKInstance.chatManager.messages_world = nil;
    GangSDKInstance.chatManager.messages_single = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
