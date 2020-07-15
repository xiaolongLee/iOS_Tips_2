//
//  ViewController.m
//  iOS_Tips_2
//
//  Created by yuanshi on 2020/7/15.
//  Copyright © 2020 yuanshi. All rights reserved.
//

#import "ViewController.h"

#import<AVFoundation/AVFoundation.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:NSTemporaryDirectory()];
    NSDictionary *results = [fileURL resourceValuesForKeys:@[NSURLVolumeAvailableCapacityForImportantUsageKey] error:nil];

    // 这里拿到的值单位是bytes，iOS 11是按照1000进制算的
    CGFloat data = [results[NSURLVolumeAvailableCapacityForImportantUsageKey] floatValue];

    // bytes->KB->MB->G
    NSLog(@"剩余可用空间:%@",@(data / 1000.0 / 1000.0/ 1000.0));
    
    
    UIView *view = [[UIView alloc] init];
    NSLog(@"%@", [view performSelector:@selector(_shortMethodDescription)]);
    NSLog(@"%@", [view performSelector:@selector(_methodDescription)]);
    NSLog(@"%@", [view performSelector:@selector(_ivarDescription)]);
    
    
    //监听系统音量变化
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryAmbient error:nil];
    [session setActive:YES error:nil];
    NSError *error;
    [[AVAudioSession sharedInstance] setActive:YES error:&error];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeChangeNotification:)name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
}


- (void)volumeChangeNotification:(NSNotification *)notification {
    float volume = [[[notification userInfo] objectForKey:@"AVSystemController_AudioVolumeNotificationParameter"] floatValue];
    NSLog(@"系统音量:%f", volume);
}

@end
