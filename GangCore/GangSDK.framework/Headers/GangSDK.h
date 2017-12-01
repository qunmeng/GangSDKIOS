//
//  gangsdk.h
//  gangsdk
//
//  Created by codone on 2017/7/31.
//  Copyright © 2017年 qm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GangUserManager.h"
#import "GangMemberManager.h"
#import "GangGroupManager.h"
#import "GangChatManager.h"
#import "GangSettingBean.h"

#define GangLog(...) \
if (GangSDKInstance.showLog) { \
NSLog(__VA_ARGS__);\
}

#pragma mark - 广播
#define Gang_notify_joinGang        @"GangJoinGang"                 /**<加入了社群*/
#define Gang_notify_leaveGang       @"GangLeaveGang"                /**<离开了社群(自己退出了、被踢了、社群被解散了等)*/

@interface GangSDK : NSObject
#pragma mark - 数据缓存
@property(assign) BOOL showLog;                                     /**<是否打印日志*/
@property(strong) NSString * _Nonnull gamekey;                      /**<申请到的key*/
@property(strong) GangSettingBean * _Nullable settingBean;          /**<设置信息,开发者在GangSDK管理平台上配置的所有信息*/
@property(strong) GangUserBean * _Nullable userBean;                /**<用户信息,登录用户的所有信息和状态*/
#pragma mark - 各管理类实例
#define GangSDKInstance [GangSDK instance]                          /**<GangSDK单例*/
@property(strong) GangUserManager *_Nullable userManager;           /**<用户管理类*/
@property(strong) GangMemberManager *_Nullable memberManager;       /**<成员管理类*/
@property(strong) GangGroupManager *_Nullable groupManager;         /**<社群管理类*/
@property(strong) GangChatManager *_Nullable chatManager;           /**<聊天管理类*/

+ (instancetype _Nonnull)instance;
- (instancetype _Nullable)init NS_UNAVAILABLE;

/**
 GangSDK 初始化
 *
 *  @param key    申请的key(必填)
 *  @param show   是否调试模式(日志输出)
 */
-(void)init:(NSString *_Nullable)key showDebug:(BOOL)show;

/**
 SDK 登录，如果切换了用户需要再次调用
 *
 *  @param gameUserid  接入应用中的用户id(用来区别用户的唯一标识符，可以为空则会自动生成)
 *  @param nickname    接入应用中的用户昵称(可以为空则在进入界面前会弹出设置昵称界面)
 *  @param headIconUrl 接入应用中的用户头像(用来初始化头像,可以为空则使用默认头像；想要修改已有头像需主动调用修改头像的接口)
 *  @param gameLevel   接入应用中的用户等级(可以为0则在界面中不显示这个信息)
 *  @param gameRole    接入应用中的用户角色(可以为空则在界面中不显示这个信息)
 *  @param extDic      用户的一些额外信息，这些信息会在以后获取与用户相关信息的时候返回
 *  @param success     成功的回调
 *  @param failure     失败的回调
 */
- (void)login:(NSString *_Nullable)gameUserid
            nickname:(NSString *_Nullable)nickname
         headIconUrl:(NSString *_Nullable)headIconUrl
           gameLevel:(NSInteger)gameLevel
            gameRole:(NSString *_Nullable)gameRole
           extParams:(NSDictionary *_Nullable)extDic
             success:(void (^_Nullable)(void))success
             failure:(void (^_Nullable)(NSError * _Nullable error))failure;


#pragma mark - 重载方法
/**
 SDK 登录,自动生成一个用户唯一标识符，头像使用默认头像，应用内等级为0，没有应用内角色等
 *  @param success     成功的回调
 *  @param failure     失败的回调
 */
- (void)login:(void (^_Nullable)(void))success
        failure:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 SDK 登录，头像使用默认头像，应用内等级为0，没有应用内角色等
 *  @param gameUserid  接入应用中的用户id(用来区别用户的唯一标识符，可以为空则会自动生成)
 *  @param success     成功的回调
 *  @param failure     失败的回调
 */
- (void)login:(NSString *_Nullable)gameUserid
      success:(void (^_Nullable)(void))success
      failure:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 SDK 登录，头像使用默认头像，应用内等级为0，没有应用内角色等
 *  @param gameUserid  接入应用中的用户id(用来区别用户的唯一标识符，可以为空则会自动生成)
 *  @param nickname    接入应用中的用户昵称(可以为空则在进入界面前会弹出设置昵称界面)
 *  @param success     成功的回调
 *  @param failure     失败的回调
 */
- (void)login:(NSString *_Nullable)gameUserid
       nickname:(NSString *_Nullable)nickname
        success:(void (^_Nullable)(void))success
        failure:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 SDK 登录，应用内等级为0，没有应用内角色等
 *  @param gameUserid  接入应用中的用户id(用来区别用户的唯一标识符，可以为空则会自动生成)
 *  @param nickname    接入应用中的用户昵称(可以为空则在进入界面前会弹出设置昵称界面)
 *  @param headIconUrl 接入应用中的用户头像(用来初始化头像,可以为空则使用默认头像；想要修改已有头像需主动调用修改头像的接口)
 *  @param success     成功的回调
 *  @param failure     失败的回调
 */
- (void)login:(NSString *_Nullable)gameUserid
       nickname:(NSString *_Nullable)nickname
    headIconUrl:(NSString *_Nullable)headIconUrl
        success:(void (^_Nullable)(void))success
        failure:(void (^_Nullable)(NSError * _Nullable error))failure;

@end
