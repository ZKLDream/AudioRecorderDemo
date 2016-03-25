//
//  ViewController.m
//  AudioRecorderDemo
//
//  Created by 千锋 on 16/3/23.
//  Copyright © 2016年 mobiletrain. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *audioImageView;
@property (weak, nonatomic) IBOutlet UILabel *audioTimeLable;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *playPauseButton;

- (IBAction)playPauseAction:(UIButton *)sender;

- (IBAction)recordAction:(UIButton *)sender;

- (IBAction)cancelRecordAction:(UIButton *)sender;

- (IBAction)deleteAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UILabel *msgLable;

@property (nonatomic,strong)AVAudioRecorder *audioRecorder;//录音
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupUI{
    
    //[UIImage imageNamed:] 图片创建后不会释放 直到程序退出 该方法创建的图片 缓存在内存中 当再次创建同样的图片时 直接从内存中获取 场景：材质图片 经常使用的图片 navigationbar tablebar
    //类似单例
//    [UIImage alloc]initWithData:<#(nonnull NSData *)#>]  图片创建后 如果没有强引用就会释放 场景：图片浏览
    
    
    //设置UIImageView的动画
   NSMutableArray *animationImages=[NSMutableArray array];
    for (int index=1; index<=3; index++) {
        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"voice_%d",index]];
        [animationImages addObject:image];
                         
    }
    self.audioImageView.animationImages=animationImages;
    self.audioImageView.animationDuration=1;
    
    //开启用户交互
    self.audioImageView.userInteractionEnabled=YES;
    
    //添加手势识别器
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(playRecordTap:)];
    [self.audioImageView addGestureRecognizer:tapGesture];
    
    
    
}




//UIImageView Tap 手势
-(void)playRecordTap:(UITapGestureRecognizer *)sender{
    //判断是否正在显示动画
    if ([self.audioImageView isAnimating]) {
        [self.audioImageView stopAnimating];
    }else{
        [self.audioImageView startAnimating];
    }
    
}


- (IBAction)testTap:(UITapGestureRecognizer *)sender {
    
}

- (IBAction)playPauseAction:(UIButton *)sender {
}

- (IBAction)recordAction:(UIButton *)sender {
    
    //创建录音对象
   //参数1：指定录音文件存放的路径
    //参数2：配置录音对象
    
    NSString * audioURL=[NSString stringWithFormat:@"%@/Documents/test.caf",NSHomeDirectory()];
    NSLog(@"%@",audioURL);
//    AVEncoderBitRateKey: 比特率
//    AVSampleRateKey 采样率
//    AVNumberOfChannelsKey 声道
    NSDictionary *settings=@{AVEncoderBitRateKey:[NSNumber numberWithInt:16],AVSampleRateKey:[NSNumber numberWithFloat:44100.0],AVNumberOfChannelsKey:@2};
    NSError * error;
    self.audioRecorder=[[AVAudioRecorder alloc]initWithURL:[NSURL URLWithString:audioURL] settings:settings error:&error];
    //准备录音
    if ( [self.audioRecorder prepareToRecord]) {
        [self.audioRecorder record];
    }else{
        NSLog(@"录音设备错误");
    }
    
}

- (IBAction)cancelRecordAction:(UIButton *)sender {
    
    //停止录音
    [self.audioRecorder stop];
}

- (IBAction)deleteAction:(UIButton *)sender {
}
@end
