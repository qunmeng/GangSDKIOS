//
//  CodoneNetWatcher.h
//  CodoneNetWorkDetector
//
//  Created by codone on 2017/8/8.
//  Copyright © 2017年 qm. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    NoNetWork,
    WiFiConnect,
    CellularConnect,
    NetWorkCannotUse
} CodoneNetStatus;

typedef  void(^block)(CodoneNetStatus statu);

@interface GangNetWatcher : NSObject
+(instancetype)instance;
-(void)watchNetWithBlock:(block)block withKey:(NSString*)key needRemove:(BOOL)remove;
-(void)removeWatcherForKey:(NSString*)key;
-(void)removeAllWatchers;

@end
