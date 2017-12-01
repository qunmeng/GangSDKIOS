//
//  GangRecordTool.h
//  RecordAndPlayVoice
//
//  Created by PBOC CS on 15/3/14.
//  Copyright (c) 2015年 liuchunlao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@class GangRecordTool;
@protocol LVRecordToolDelegate <NSObject>

@optional
- (void)recordTool:(GangRecordTool *)recordTool didstartRecoring:(int)no;

@end

@interface GangRecordTool : NSObject

/** 录音工具的单例 */
+ (instancetype)sharedRecordTool;

/** 开始录音 */
- (void)startRecording;

/** 停止录音 */
- (void)stopRecording;

/** 播放录音文件 */
- (void)playRecordingFile;
- (void)playRecordingFile:(NSURL*)file;

/** 停止播放录音文件 */
- (void)stopPlaying;

/** 销毁录音文件 */
- (void)destructionRecordingFile;
- (void)destructionRecordingFileAtPath:(NSString*)path;

- (NSString*) toMp3;

/** 录音对象 */
@property (nonatomic, strong) AVAudioRecorder *recorder;


/** 录音文件地址 */
@property (nonatomic, strong) NSURL *recordFileUrl;

/** 更新图片的代理 */
@property (nonatomic, weak) id<LVRecordToolDelegate> delegate;

@end
