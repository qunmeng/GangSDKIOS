//
//  GangSDK+UI.h
//  GangSDK
//
//  Created by codone on 2017/11/14.
//  Copyright © 2017年 qm. All rights reserved.
//

#import <GangSDK/GangSDK.h>
#import <UIKit/UIKit.h>

@interface GangSDK (UI)

/**
 登录并跳转到GangUI
 *  @param controller  用来进行跳转的controller,如果是navigationcontroller则会直接进行push,否则会先prsent
 *  @param gameUserid  接入应用中的用户id(用来区别用户的唯一标识符，可以为空则会自动生成)
 *  @param nickname    接入应用中的用户昵称(可以为空则在进入界面前会弹出设置昵称界面)
 *  @param headIconUrl 接入应用中的用户头像(用来初始化头像,可以为空则使用默认头像；想要修改已有头像需主动调用修改头像的接口)
 *  @param gameLevel   接入应用中的用户等级(可以为0则在界面中不显示这个信息)
 *  @param gameRole    接入应用中的用户角色(可以为空则在界面中不显示这个信息)
 *  @param extDic      用户的一些额外信息，这些信息会在以后获取与用户相关信息的时候返回
 *  @param success     成功的回调
 *  @param failure     失败的回调
 */
- (void)startUI:(UIViewController *_Nonnull)controller
             userId:(NSString *_Nullable)gameUserid
           nickname:(NSString *_Nullable)nickname
        headIconUrl:(NSString *_Nullable)headIconUrl
          gameLevel:(NSInteger)gameLevel
           gameRole:(NSString *_Nullable)gameRole
          extParams:(NSDictionary *_Nullable)extDic
            success:(void (^_Nullable)(void))success
            failure:(void (^_Nullable)(NSError * _Nullable error))failure;


#pragma mark - 重载方法
/**
 登录并跳转到GangUI,自动生成一个用户唯一标识符，在跳转GangUI时会弹出对话框让用户输入昵称，头像使用默认头像，应用内等级为0，没有应用内角色等
 *  @param controller  用来进行跳转的controller,如果是navigationcontroller则会直接进行push,否则会先prsent
 *  @param success     成功的回调
 *  @param failure     失败的回调
 */
- (void)startUI:(UIViewController *_Nonnull)controller
            success:(void (^_Nullable)(void))success
            failure:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 登录并跳转到GangUI，头像使用默认头像，应用内等级为0，没有应用内角色等
 *  @param controller  用来进行跳转的controller,如果是navigationcontroller则会直接进行push,否则会先prsent
 *  @param gameUserid  接入应用中的用户id(用来区别用户的唯一标识符，可以为空则会自动生成)
 *  @param success     成功的回调
 *  @param failure     失败的回调
 */
- (void)startUI:(UIViewController *_Nonnull)controller
         userId:(NSString *_Nullable)gameUserid
        success:(void (^_Nullable)(void))success
        failure:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 登录并跳转到GangUI，头像使用默认头像，应用内等级为0，没有应用内角色等
 *  @param controller  用来进行跳转的controller,如果是navigationcontroller则会直接进行push,否则会先prsent
 *  @param gameUserid  接入应用中的用户id(用来区别用户的唯一标识符，可以为空则会自动生成)
 *  @param nickname    接入应用中的用户昵称(可以为空则在进入界面前会弹出设置昵称界面)
 *  @param success     成功的回调
 *  @param failure     失败的回调
 */
- (void)startUI:(UIViewController *_Nonnull)controller
             userId:(NSString *_Nullable)gameUserid
           nickname:(NSString *_Nullable)nickname
            success:(void (^_Nullable)(void))success
            failure:(void (^_Nullable)(NSError * _Nullable error))failure;

/**
 登录并跳转到GangUI，应用内等级为0，没有应用内角色等
 *  @param controller  用来进行跳转的controller,如果是navigationcontroller则会直接进行push,否则会先prsent
 *  @param gameUserid  接入应用中的用户id(用来区别用户的唯一标识符，可以为空则会自动生成)
 *  @param nickname    接入应用中的用户昵称(可以为空则在进入界面前会弹出设置昵称界面)
 *  @param headIconUrl 接入应用中的用户头像(用来初始化头像,可以为空则使用默认头像；想要修改已有头像需主动调用修改头像的接口)
 *  @param success     成功的回调
 *  @param failure     失败的回调
 */
- (void)startUI:(UIViewController *_Nonnull)controller
             userId:(NSString *_Nullable)gameUserid
           nickname:(NSString *_Nullable)nickname
        headIconUrl:(NSString *_Nullable)headIconUrl
            success:(void (^_Nullable)(void))success
            failure:(void (^_Nullable)(NSError * _Nullable error))failure;
/**
 跳转到GangUI
 在已经登录GangSDK的前提下(调用了[[GangSDK instance]login]方法)，只能调用下面的方法进入GangUI
 *  @param controller  用来进行跳转的controller,如果是navigationcontroller则会直接进行push,否则会先prsent
 */
- (void)startUI:(UIViewController *_Nonnull)controller;


#pragma mark - 一些快捷显示界面的方法
/**
 显示社群信息
 @param controller 用来present的controller
 @param consortiaid 要显示的社群id
 */
-(void)showGangInfo:(UIViewController *_Nonnull)controller ofId:(NSString *_Nonnull)consortiaid;

@end
