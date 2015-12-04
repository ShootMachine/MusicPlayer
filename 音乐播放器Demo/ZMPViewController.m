//
//  ZMPViewController.m
//  音乐播放器Demo
//
//  Created by jjj1123 on 14-10-10.
//  Copyright (c) 2014年 jjj1123. All rights reserved.
//

#import "ZMPViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ZMPlrc.h"

@interface ZMPViewController ()<UITableViewDataSource,UITableViewDelegate>{
    //音乐播放器
    AVAudioPlayer *player;
    
    ZMPlrc *lrc;
    
    NSInteger currentRow;
}

@end

@implementation ZMPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self initPlayer];
    
    //侦听当前时间
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
    
    lrc = [[ZMPlrc alloc] init];
    [lrc parselrc];
    
    
    [self.lrcTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELL"];
    [self.lrcTableView reloadData];
    
}

- (void)updateTime{
    CGFloat currentTime = player.currentTime;
    
    //
    self.currentTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",(int)currentTime / 60, (int)currentTime % 60];
    self.timeSlider.value = currentTime / player.duration;
    
    for (int i = 0; i < lrc.timeArray.count; i ++) {
        
        NSArray *arr = [lrc.timeArray[i] componentsSeparatedByString:@":"];
        
        CGFloat compTime = [arr[0] integerValue]*60 + [arr[1] floatValue];
        
        if (player.currentTime > compTime)
        {
            currentRow = i;
        }
        else
        {
            break;
        }
    }
    
    [self.lrcTableView reloadData];
    [self.lrcTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:currentRow inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

/**
 初始化音乐播放器
 */
- (void)initPlayer{
    
    
        //后台播放音频设置
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
        //让app支持接受远程控制事件
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"梁静茹-偶阵雨" ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    //声道 -1------左声道，1-----右声道
    player.pan = 0;
    
    //音量:0~1
    player.volume = 1;
    
    //单曲循环(负数表示单曲循环)
    player.numberOfLoops = -1;
    
    //速率（默认为1）
    //player.enableRate = YES;
    //player.rate = 1.0;
    
    //总时间
    CGFloat totalSeconds = player.duration;
    self.totalTimeLabel.text = [NSString stringWithFormat:@"%02d:%02d",(int)totalSeconds / 60, (int)totalSeconds % 60];
    
    //当前时间
    player.currentTime;
    
#if 0
    //播放
    [player play];
    
    //停止
    [player stop];
    
    //暂停
    [player pause];

#endif
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)playBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        [player prepareToPlay];
        [player play];
    }else{
        [player pause];
    }
}

- (IBAction)preMusicBtnClick:(id)sender {
    [self initPlayer];
}

- (IBAction)valueChange:(UISlider *)sender {
       player.currentTime = player.duration * sender.value;
}

- (IBAction)nextMusicBtnClick:(id)sender {
    [self initPlayer];
}

#pragma mark - TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return lrc.wordArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    if (indexPath.row == currentRow)
    {
        cell.textLabel.textColor = [UIColor redColor];
    }
    else
    {
        cell.textLabel.textColor = [UIColor blackColor];
    }
    
    
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    
    cell.textLabel.text = lrc.wordArray[indexPath.row];
    
    return cell;
}

@end
