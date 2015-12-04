//
//  ZMPlrc.h
//  音乐播放器Demo
//
//  Created by jjj1123 on 14-10-10.
//  Copyright (c) 2014年 jjj1123. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMPlrc : NSObject

/**
 时间
 */
@property (nonatomic,strong)NSMutableArray *timeArray;
/**
 歌词
 */
@property (nonatomic,strong)NSMutableArray *wordArray;

/**
 解析歌词
 */
- (void)parselrc;

@end
