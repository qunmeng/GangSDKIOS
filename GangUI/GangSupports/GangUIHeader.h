//
//  GangUIHeader.h
//  GangSDK
//
//  Created by codone on 2017/8/16.
//  Copyright © 2017年 qm. All rights reserved.
//

#ifndef GangUIHeader_h
#define GangUIHeader_h

#import <GangSDK/GangSDK.h>
#import "GangUIFont.h"
#import "GangTools.h"
#import "UIView+GangNormalToastView.h"
#import "UIView+GangNormalLoadingView.h"

#define GangPageSize 20

#pragma 广播
#define Gang_notify_userInfoChanged @"GangUserInfoChanged"  /**<需要刷新用户信息*/
#define Gang_notify_infoChanged     @"GangInfoChanged"      /**<需要刷新社群信息*/
#define Gang_notify_MembersChanged  @"GangMembersChanged"   /**<需要刷新成员列表*/
#define Gang_notify_playAVoice      @"GangPlayAVoice"       /**<播放一条语音*/

#endif /* GangUIHeader_h */
