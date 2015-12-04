//
//  ZMPViewController.h
//  音乐播放器Demo
//
//  Created by jjj1123 on 14-10-10.
//  Copyright (c) 2014年 jjj1123. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMPViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *lrcTableView;
@property (weak, nonatomic) IBOutlet UISlider *timeSlider;
@property (weak, nonatomic) IBOutlet UILabel *currentTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *totalTimeLabel;


@property (weak, nonatomic) IBOutlet UIButton *lastMusicBtnClick;
- (IBAction)playBtnClick:(UIButton *)sender;
- (IBAction)preMusicBtnClick:(id)sender;
- (IBAction)valueChange:(UISlider *)sender;

- (IBAction)nextMusicBtnClick:(id)sender;
@end
