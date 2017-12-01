//
//  GangSDK+UI.m
//  GangSDK
//
//  Created by codone on 2017/11/14.
//  Copyright © 2017年 qm. All rights reserved.
//

#import "GangSDK+UI.h"
#import "GangUI.h"

@implementation GangSDK (UI)
-(void)startUI:(UIViewController *)controller userId:(NSString *)gameUserid nickname:(NSString *)nickname headIconUrl:(NSString *)headIconUrl gameLevel:(NSInteger)gameLevel gameRole:(NSString *)gameRole extParams:(NSDictionary *)extDic success:(void (^)(void))success failure:(void (^)(NSError * _Nullable))failure{
    [GangUI startUI:controller userId:gameUserid nickname:nickname headIconUrl:headIconUrl gameLevel:gameLevel gameRole:gameRole extParams:extDic success:success failure:failure];
}

-(void)startUI:(UIViewController *)controller success:(void (^)(void))success failure:(void (^)(NSError * _Nullable))failure{
    [GangUI startUI:controller success:success failure:failure];
}

-(void)startUI:(UIViewController *)controller userId:(NSString *)gameUserid success:(void (^)(void))success failure:(void (^)(NSError * _Nullable))failure{
    [GangUI startUI:controller userId:gameUserid success:success failure:failure];
}

-(void)startUI:(UIViewController *)controller userId:(NSString *)gameUserid nickname:(NSString *)nickname success:(void (^)(void))success failure:(void (^)(NSError * _Nullable))failure{
    [GangUI startUI:controller userId:gameUserid nickname:nickname success:success failure:failure];
}

-(void)startUI:(UIViewController *)controller userId:(NSString *)gameUserid nickname:(NSString *)nickname headIconUrl:(NSString *)headIconUrl success:(void (^)(void))success failure:(void (^)(NSError * _Nullable))failure{
    [GangUI startUI:controller userId:gameUserid nickname:nickname headIconUrl:headIconUrl success:success failure:failure];
}

-(void)startUI:(UIViewController *)controller{
    [GangUI startUI:controller];
}

-(void)showGangInfo:(UIViewController *)controller ofId:(NSString *)consortiaid{
    [GangUI showGangInfo:controller ofId:consortiaid];
}
@end
