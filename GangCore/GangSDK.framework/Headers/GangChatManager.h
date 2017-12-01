//
//  GangChatManager.h
//  GangSDK
//
//  Created by codone on 2017/10/30.
//  Copyright © 2017年 qm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GangAttackBean.h"
#import "GangChatMessageBean.h"
#import "GangChatListBean.h"

#pragma mark - 广播
#define Gang_notify_receiveGangMessage         @"GangReceiveGangMessaged"     /**<收到社群频道消息,这条消息会被放入messages_gang中，同时会携带在notification.userInfo<@"data":GangChatMessageBean>*/
#define Gang_notify_receiveWorldMessage        @"GangReceiveWorldMessaged"    /**<收到招募频道消息,这条消息会被放入messages_world中，同时会携带在notification.userInfo<@"data":GangChatMessageBean>*/
#define Gang_notify_receiveGangTip             @"GangReceiveGangTip"          /**<收到公告,这条消息会被放入messages_gangTips中，同时会携带在notification.userInfo<@"data":NSString>*/
#define Gang_notify_receiveGangInvite          @"GangReceiveGangInvite"       /**<收到加入社群邀请*/
#define Gang_notify_receiveGangAgree           @"GangReceiveGangAgree"        /**<收到同意加入社群回复,会携带在notification.userInfo<@"data":NSString>*/
#define Gang_notify_receiveGangTask            @"GangReceiveGangTask"         /**<有新的公会任务*/
#define Gang_notify_receiveGangAttack          @"GangReceiveGangAttack"       /**<突发事件,这条消息会被放入messages_gangTips中，同时会携带在notification.userInfo<@"data":GangAttackBean>*/
#define Gang_notify_receiveLoginOnOtherPlat    @"GangReceiveLoginOnOtherPlat"  /**<账号异地登录*/
#define Gang_notify_receiveKickOut             @"GangReceiveKickOut"           /**<被踢出*/
#define Gang_notify_receiveGangDissolved       @"GangReceiveGangDissolved"     /**<社群被解散*/

@interface GangChatManager : NSObject
#pragma mark - 数据缓存
@property(strong) NSMutableArray * _Nullable messages_gangTips;     /**<公告(NSString)、突发任务缓存(GangAttackBean)*/
@property(strong) NSMutableArray<GangChatMessageBean*> * _Nullable messages_world;        /**<招募频道消息缓存*/
@property(strong) NSMutableArray<GangChatMessageBean*> * _Nullable messages_gang;         /**<社群频道消息缓存*/
+ (instancetype _Nonnull)instance;
- (instancetype _Nullable)init NS_UNAVAILABLE;

/**
 *  发送文字消息
 *  @param message  发言内容
 *  @param channel  频道(1-招募频道，2-社群频道)
 */

- (void)sendTextMessage:(NSString *_Nonnull)message
              inChannel:(int)channel
                success:(void (^_Nullable)(void))success
                   fail:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 *  发送语音消息
 *  @param fileData  语音数据
 *  @param fileName  语音数据的文件名
 *  @param voiceTime 语音消息的时间
 *  @param channel   频道(1-招募频道，2-社群频道)
 *  @param progress  上传语音文件的进度
 */
- (void)sendVoiceMessage:(NSData *_Nonnull)fileData
                withName:(NSString *_Nonnull)fileName
                 ofTimes:(int)voiceTime
               inChannel:(int)channel
                 success:(void (^_Nullable)(void))success
                    fail:(void (^_Nullable)(NSError * _Nullable error))failure
                progress:(void (^_Nullable)(double percent))progress;

/**
 *  获取社群聊天记录
 *  @param  endTime   分页  起始时间戳，获取第一页为 @""
 *  @param  pageSize  每页条数
 *  @param channel   频道(1-招募频道，2-社群频道)
 */
- (void)getChatHistory:(NSString *_Nullable)endTime
                        pageSize:(int)pageSize
                       inChannel:(int)channel
                         success:(void (^_Nullable)(GangChatListBean *_Nullable data))success
                            fail:(void (^_Nullable)(NSError * _Nullable error))failure;
@end
