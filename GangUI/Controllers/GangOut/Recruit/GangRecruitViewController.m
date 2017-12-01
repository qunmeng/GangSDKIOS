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
#import "GangRecruitLeftTableViewCell.h"
#import "GangRecruitLeftVoiceTableViewCell.h"
#import "GangRecruitRightTableViewCell.h"
#import "GangRecruitRightVoiceTableViewCell.h"
#import "GangRecruitSystemTableViewCell.h"
#import <GangSDK/GangChatMessageBean.h>
#import <GangSupport/CodoneTimerHander.h>

@interface GangRecruitViewController ()<UITableViewDataSource,UITableViewDelegate,TableViewTopLoadMoreDelegate,LVRecordToolDelegate>{
    BOOL isRecording;
}

@property(strong)CodoneTimerHander *hander_WorldScroll;/**<禁止world滚动*/
@property (weak, nonatomic) IBOutlet GangChatTopLoadMoreTableView *tableView;
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
}

- (void)setTheSubviews{
    [super setTheSubviews];
    
    UILongPressGestureRecognizer *pressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressGestureRecognize:)];
    pressGestureRecognizer.minimumPressDuration = 0;
    [self.btn_record addGestureRecognizer:pressGestureRecognizer];
    
    self.tableView.parentController = self;
    self.tableView.loadMoreDelegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    
    if (GangSDKInstance.chatManager.messages_world.count==0) {
        [self.tableView startLoad];
    }
}

//world滚动计时
-(void)handerWorld{
    __weak GangRecruitViewController *weakSelf = self;
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

- (void)scrollChatsToBottom{
    float y = self.tableView.contentSize.height - self.tableView.bounds.size.height;
    if (y < 0) {
        y = 0;
    }
    [self.tableView scrollRectToVisible:CGRectMake(0, y, self.tableView.bounds.size.width, self.tableView.bounds.size.height) animated:NO];
}

#pragma mark - loadmore delegate
-(void)loadMoreDatas:(id)sender{
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
            [self.tableView reloadData];
            if (GangSDKInstance.chatManager.messages_world.count==data.data.count) {
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:GangSDKInstance.chatManager.messages_world.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            }else{
                [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:data.data.count inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
            }
        }
        if (data.data.count==GangPageSize) {
            [self.tableView endLoadMoreDatas:NO];
        }else{
            [self.tableView hideTheRefreshHeader:YES];
        }
    } fail:^(NSError * _Nullable error) {
        [self.tableView endLoadMoreDatas:NO];
        if (error) {
            [self gang_toast:error.domain];
        }
    }];
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
    [self.tableView reloadData];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:GangSDKInstance.chatManager.messages_world.count-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)tvTextChanged:(id)sender{
    self.label_tvPlaceHolder.hidden = self.tv_input.text.length >0;
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
            [self.bg_record setImage:[UIImage imageNamed:@"qm_btn_recruit_stop_talk"]];
            [self.btn_record setBackgroundImage:[UIImage imageNamed:@"qm_btn_recruit_stop_talk"] forState:UIControlStateNormal];
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
        [self.bg_record setImage:[UIImage imageNamed:@"qm_btn_recruit_stop_talk"]];
        [self.btn_record setBackgroundImage:[UIImage imageNamed:@"qm_btn_recruit_stop_talk"] forState:UIControlStateNormal];
        [self.btn_record setTitle:@"松开手指，取消录音" forState:UIControlStateNormal];
        [self.btn_record setTitleColor:[UIColor colorFromHexRGB:GangColor_recruit_endVoiceButtonTitle] forState:UIControlStateNormal];
    }
}

#pragma mark -提示松开发送语音消息-
- (void)btn_record_touchEvent_dragEnter:(UIButton *)sender {
    if (isRecording) {
        [self.bg_record setImage:[UIImage imageNamed:@"qm_btn_recruit_stop_talk"]];
        [self.btn_record setBackgroundImage:[UIImage imageNamed:@"qm_btn_recruit_stop_talk"] forState:UIControlStateNormal];
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
        [self.bg_record setImage:[UIImage imageNamed:@"qm_btn_recruit_press_on"]];
        [self.btn_record setBackgroundImage:[UIImage imageNamed:@"qm_btn_recruit_press_on"] forState:UIControlStateNormal];
        [self.btn_record setTitle:@"按住 说话" forState:UIControlStateNormal];
        [self.btn_record setTitleColor:[UIColor colorFromHexRGB:GangColor_recruit_voiceButtonTitle] forState:UIControlStateNormal];
        isRecording = NO;
    }
}

- (void)btn_record_touchEvent_upInside:(UIButton *)sender {
    if (isRecording) {
        self.view_showRecord.hidden = YES;
        [GangRecordTool sharedRecordTool].delegate = nil;
        [self.btn_record setBackgroundImage:[UIImage imageNamed:@"qm_btn_recruit_press_on"] forState:UIControlStateNormal];
        [self.bg_record setImage:[UIImage imageNamed:@"qm_btn_recruit_press_on"]];
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
    [GangSDKInstance.chatManager sendVoiceMessage:data withName:@"iphone.mp3" ofTimes:voiceSeconds inChannel:1 success:^{
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
    [self handerWorld];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return GangSDKInstance.chatManager.messages_world.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GangChatMessageBean *bean = GangSDKInstance.chatManager.messages_world[indexPath.row];
    BOOL needShowTime = NO;
//    if (indexPath.row>0) {
//        GangChatMessageBean *beforeBean = GangSDKInstance.chatManager.messages_world[indexPath.row-1];
//        if (([bean.createtime integerValue]-[beforeBean.createtime integerValue])/1000>60*2) {
//            needShowTime = YES;
//        }
//    }
    switch (bean.messagetype) {
        case 1:{
            if ([bean.userid isEqualToString:@"0"]) {
                GangRecruitSystemTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"recruitSystemCell"];
                if (!cell) {
                    [tableView registerNib:[UINib nibWithNibName:@"GangRecruitSystemTableViewCell" bundle:nil] forCellReuseIdentifier:@"recruitSystemCell"];
                    cell =[tableView dequeueReusableCellWithIdentifier:@"recruitSystemCell"];
                }
                [cell setTheObj:bean];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            } else if ([bean.userid isEqualToString:GangSDKInstance.userBean.data.userid]) {
                GangRecruitRightTableViewCell *cell =[self.tableView dequeueReusableCellWithIdentifier:@"recruitRightCell"];
                if (!cell) {
                    [self.tableView registerNib:[UINib nibWithNibName:@"GangRecruitRightTableViewCell" bundle:nil] forCellReuseIdentifier:@"recruitRightCell"];
                    cell =[self.tableView dequeueReusableCellWithIdentifier:@"recruitRightCell"];
                }
                cell.parentTableView = self.tableView;
                [cell setTheObj:bean];
                [cell showTime:needShowTime];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                GangRecruitLeftTableViewCell *cell =[self.tableView dequeueReusableCellWithIdentifier:@"recruitLeftCell"];
                if (!cell) {
                    [self.tableView registerNib:[UINib nibWithNibName:@"GangRecruitLeftTableViewCell" bundle:nil] forCellReuseIdentifier:@"recruitLeftCell"];
                    cell =[self.tableView dequeueReusableCellWithIdentifier:@"recruitLeftCell"];
                }
                cell.parentTableView = self.tableView;
                [cell setTheObj:bean];
                [cell showTime:needShowTime];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
            break;
        case 2:{
            if ([bean.userid isEqualToString:GangSDKInstance.userBean.data.userid]) {
                GangRecruitRightVoiceTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"recruitRightVoiceCell"];
                if (!cell) {
                    [tableView registerNib:[UINib nibWithNibName:@"GangRecruitRightVoiceTableViewCell" bundle:nil] forCellReuseIdentifier:@"recruitRightVoiceCell"];
                    cell =[tableView dequeueReusableCellWithIdentifier:@"recruitRightVoiceCell"];
                }
                cell.parentTableView = self.tableView;
                [cell setTheObj:bean];
                [cell showTime:needShowTime];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }else{
                GangRecruitLeftVoiceTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"recruitLeftVoiceCell"];
                if (!cell) {
                    [tableView registerNib:[UINib nibWithNibName:@"GangRecruitLeftVoiceTableViewCell" bundle:nil] forCellReuseIdentifier:@"recruitLeftVoiceCell"];
                    cell =[tableView dequeueReusableCellWithIdentifier:@"recruitLeftVoiceCell"];
                }
                cell.parentTableView = self.tableView;
                [cell setTheObj:bean];
                [cell showTime:needShowTime];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                return cell;
            }
        }
            break;
        default:
            break;
    }
    return nil;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    GangChatMessageBean *bean = GangSDKInstance.chatManager.messages_world[indexPath.row];
    switch (bean.messagetype) {
        case 1:{
            if ([bean.userid isEqualToString:@"0"]) {
                return [self.tableView computeTheCellHeight:@"GangRecruitSystemTableViewCell" withObj:bean];
            } else {
                if ([bean.userid isEqualToString:GangSDKInstance.userBean.data.userid]) {
                    return [self.tableView computeTheCellHeight:@"GangRecruitRightTableViewCell" withObj:bean];
                } else {
                    return [self.tableView computeTheCellHeight:@"GangRecruitLeftTableViewCell" withObj:bean];
                }
            }
        }
            break;
        case 2:{
            if ([bean.userid isEqualToString:GangSDKInstance.userBean.data.userid]) {
                return [self.tableView computeTheCellHeight:@"GangRecruitRightVoiceTableViewCell" withObj:bean];
            } else {
                return [self.tableView computeTheCellHeight:@"GangRecruitLeftVoiceTableViewCell" withObj:bean];
            }
        }
            break;
        default:
            break;
    }
    return 0;
}

#pragma mark - buttonAction
- (IBAction)btn_msgAndVoice_click:(UIButton *)sender {
    [self.tv_input resignFirstResponder];
    if (0==self.btn_msgAndVoice.tag) {
        [self.btn_msgAndVoice setImage:[UIImage imageNamed:@"qm_bg_recruit_keyboard"] forState:UIControlStateNormal];
        [self.tv_input endEditing:YES];
        self.label_tvPlaceHolder.hidden = YES;
        self.tv_input.hidden = YES;
        self.iv_bg_inputTextField.hidden = YES;
        self.btn_send.hidden = YES;
        self.btn_record.hidden = NO;
        self.bg_record.hidden = NO;
        self.btn_msgAndVoice.tag = 1;
    }else{
        [self.btn_msgAndVoice setImage:[UIImage imageNamed:@"qm_icon_recruit_mac"] forState:UIControlStateNormal];
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
    NSString *str_message = self.tv_input.text;
    if ([GangTools stringFromString:str_message deleteCharSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length==0) {
        if ([self.tv_input isFirstResponder]) {
            [self.view toastTheMsg:@"请输入内容!" atPosition:POSITION_TOP duration:1.5];
        }else{
            [self gang_toast:@"请输入内容!"];
        }
        return;
    }else if ([CodoneTools countTheStrLength:str_message]>50) {
        [self gang_toast:@"最多输入50个字!"];
        return;
    }
    self.btn_send.enabled = NO;
    [GangSDKInstance.chatManager sendTextMessage:str_message inChannel:1 success:^{
        self.btn_send.enabled = YES;
        self.tv_input.text = nil;
        self.label_tvPlaceHolder.hidden = NO;
    } fail:^(NSError * _Nullable error) {
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
