//
//  GangPBHelper.h
//  protobuf.codec
//
//  Created by ETiV on 13-4-16.
//  Copyright (c) 2013年 ETiV. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GangPBCodec.h"

@interface GangPBHelper : NSObject

+ (BOOL) isSimpleType:(ProtoBufType)pbType;

+ (ProtoBufType) translatePBTypeFromStr:(NSString *)typeStr;

@end
