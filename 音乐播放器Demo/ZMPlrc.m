//
//  ZMPlrc.m
//  音乐播放器Demo
//
//  Created by jjj1123 on 14-10-10.
//  Copyright (c) 2014年 jjj1123. All rights reserved.
//

#import "ZMPlrc.h"

@implementation ZMPlrc

- (instancetype)init
{
    self = [super init];
    if (self) {
        _timeArray = [NSMutableArray array];
        _wordArray = [NSMutableArray array];
    }
    return self;
}

/**
 歌词路径
 */
- (NSString *)getLrcPath{
    return [[NSBundle mainBundle] pathForResource:@"梁静茹-偶阵雨" ofType:@"lrc"];
}

/**
 解析歌词
 */
- (void)parselrc{
    NSString *content = [NSString stringWithContentsOfFile:[self getLrcPath] encoding:NSUTF8StringEncoding error:nil];
    
    NSArray *sepArray = [content componentsSeparatedByString:@"["];
    for (int i = 5; i < sepArray.count; i ++) {
        //有两个元素，一个是时间，一个是歌词
        NSArray *arr = [sepArray[i] componentsSeparatedByString:@"]"];
        //NSLog(@"%@",sepArray[i]);
        
        [_timeArray addObject:arr[0]];
        [_wordArray addObject:arr[1]];
        
    }
    
    //NSLog(@"%@",content);
}

@end
