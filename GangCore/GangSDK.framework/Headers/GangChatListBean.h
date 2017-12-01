//
//  GangChatListBean.h
//  GangSDK
//
//  Created by codone on 2017/11/28.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangChatMessageBean.h"

@interface GangChatListBean : GangBaseBean
@property(strong) NSArray<GangChatMessageBean*> *data;
@end
