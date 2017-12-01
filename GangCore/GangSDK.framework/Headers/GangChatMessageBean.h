//
//  GangChatMessageBean.h
//  GangSDK
//
//  Created by codone on 2017/8/31.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangBaseBean.h"

typedef enum : NSUInteger {
    Gang_MessageState_sending,//正在发送
    Gang_MessageState_sended,//发送成功
    Gang_MessageState_received,//对方收到了
    Gang_MessageState_normal,//收到的
} Gang_MessageState;

@interface GangChatMessageBean : GangBaseBean
@property(assign) int messagetype;            /**<消息类型1-文字，2-语音*/
@property(strong) NSString *gameid;           /**<游戏id*/
@property(strong) NSString *gameuserid;       /**<接入应用中的用户唯一标识符*/
@property(strong) NSString *userid;           /**<用户id*/
@property(strong) NSString *nickname;         /**<用户昵称*/
@property(strong) NSString *iconurl;          /**<用户头像*/
@property(strong) NSString *consortiaiconurl; /**<社群图标*/
@property(strong) NSString *consortiaid;      /**<社群id*/
@property(strong) NSDictionary *ext;          /**<用户额外信息*/
@property(strong) NSString *rolename;         /**<成员职务*/
@property(assign) int voicetime;              /**<语音时长*/
@property(assign) BOOL isPlaying;             /**<正在播放语音*/
@property(strong) NSString *createtime;       /**<发送时间*/
@property(assign) Gang_MessageState state;    /**<消息的状态*/
@end
