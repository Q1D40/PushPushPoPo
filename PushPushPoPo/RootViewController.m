//
//  RootViewController.m
//  PushPushPoPo
//
//  Created by yang mu on 12-1-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// 画背景
- (void)drawBackGround
{
    UIImageView *backGround=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
    [backGround setFrame:CGRectMake(0, 0, 320, 480)];
    [self.view addSubview:backGround];
}

// 画一些泡泡
- (void)drawSomePoPo
{
    // 纵向
    for (int d = 0; d<9; d++) {
        // 横向
        int n; // 每行泡泡个数
        int s; // 起始x坐标
        if (d % 2 == 0) {
            n = 6;
            s = 0;
        }else{
            n = 5;
            s = 25;
        }
        for (int r = 0; r < n; r ++) {
            int x = r * (50 + 4) + s;
            int y = d * 50;
            [self drawOnePoPoWithX:x andWithY:y];
        }
    }
}

// 画一个泡泡
- (void)drawOnePoPoWithX:(int)x andWithY:(int)y
{
    // 设置凸图
    // 随机选图
    int randNumber = random() % 10;
    NSString *picFileName = [[NSString alloc] initWithString:[NSString stringWithFormat:@"convex_%d.png", randNumber]];
    UIImageView *poPo=[[UIImageView alloc] initWithImage:[UIImage imageNamed:picFileName]];
    
    // 设置允许触摸
    [poPo setUserInteractionEnabled:YES];
    // 设置触摸事件
    UITapGestureRecognizer *onPushPoPo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushPoPo:)];
    [poPo addGestureRecognizer:onPushPoPo];
    
    // 设置泡泡标记
    poPo.tag = 0;
    // 画泡泡
    [poPo setFrame:CGRectMake(x, y, 50, 50)];
    [self.view addSubview:poPo];
}

// 画info按钮
- (void)drawInfoButton
{
    UIButton *infoButton = [[UIButton alloc] initWithFrame:CGRectMake(300, 460, 16, 16)];
    [infoButton setImage:[UIImage imageNamed:@"i.png"] forState:UIControlStateNormal];
    // 设置触摸事件
    [infoButton addTarget:self action:@selector(showInfoView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:infoButton];
}

// 画new按钮
- (void)drawNewButton
{
    UIButton *newButton = [[UIButton alloc] initWithFrame:CGRectMake(129, 454, 62, 26)];
    [newButton setImage:[UIImage imageNamed:@"new.png"] forState:UIControlStateNormal];
    // 设置触摸事件
    [newButton addTarget:self action:@selector(newPage:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:newButton];
}

// 捏泡泡
- (void)pushPoPo:(UIGestureRecognizer *)sender 
{
    UIImageView *poPo = (UIImageView *)[sender.view hitTest:[sender locationInView:sender.view] withEvent:nil];
    
    if (poPo.tag == 0) {
        // 换凹图
        // 随机选图
        int randNumber = random() % 10;
        NSString *picFileName = [[NSString alloc] initWithString:[NSString stringWithFormat:@"concave_%d.png", randNumber]];
        [poPo setImage:[UIImage imageNamed:picFileName]];
        // 播放凸时声音
        [self playConvexSound];
        // 设置泡泡标记
        poPo.tag = 1;
    }else{
        // 播放凹时声音
        [self playConcaveSound];
    }
}

// 播放凸时声音
- (void)playConvexSound
{
    NSURL  *url = [NSURL fileURLWithPath:[NSString  
                                          stringWithFormat:@"%@/convex.m4a",  [[NSBundle mainBundle]  resourcePath]]];
    NSError  *error;
    audioPlayer  = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [audioPlayer  play];
}

// 播放凹时声音
- (void)playConcaveSound
{
    NSURL  *url = [NSURL fileURLWithPath:[NSString  
                                          stringWithFormat:@"%@/concave.m4a",  [[NSBundle mainBundle]  resourcePath]]];
    NSError  *error;
    audioPlayer  = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [audioPlayer  play];
}

// 播放新一页声音
- (void)playNewPageSound
{
    NSURL  *url = [NSURL fileURLWithPath:[NSString  
                                          stringWithFormat:@"%@/NewPage.m4a",  [[NSBundle mainBundle]  resourcePath]]];
    NSError  *error;
    audioPlayer  = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [audioPlayer  play];
}

// 显示关于信息
- (void)showInfoView:(id)sender
{
    // 显示关于信息
    [self.view addSubview:infoView];
    
    // 开始设置动画
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 动画开始
    [UIView beginAnimations:nil context:context];
    // 设置动画快慢
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    // 设置动画时间
    [UIView setAnimationDuration:0.7];
    // 动画类型
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
    // 提交动画
    [UIView commitAnimations];
}

// 移除关于信息
- (IBAction)removeInfoView:(id)sender
{
    // 移除关于信息
    [infoView removeFromSuperview];
    
    // 开始设置动画
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 动画开始
    [UIView beginAnimations:nil context:context];
    // 设置动画快慢
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    // 设置动画时间
    [UIView setAnimationDuration:0.7];
    // 动画类型
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
    // 提交动画
    [UIView commitAnimations];
}

// 新一页
- (void)newPage:(id)sender
{
    // 重新开始游戏
    [self restartGame];
    // 播放新一页声音
    [self playNewPageSound];
    
    // 开始设置动画
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 动画开始
    [UIView beginAnimations:nil context:context];
    // 设置动画快慢
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    // 设置动画时间
    [UIView setAnimationDuration:0.7];
    // 动画类型
    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
    // 提交动画
    [UIView commitAnimations];
}

// 移除画面所有内容
- (void)removeAllThings
{
    for (UIView *view in [self.view subviews])
    {
        [view removeFromSuperview];
    }
}

// 画所有内容
- (void)drawAllThings
{
    // 画背景
    [self drawBackGround];
    // 画泡泡
    [self drawSomePoPo];
    // 画info按钮
    [self drawInfoButton];
    // 画new按钮
    [self drawNewButton];
}

// 开始游戏
- (void)startGame
{
    // 画所有内容
    [self drawAllThings];
}

// 重新开始游戏
- (void)restartGame
{
    // 移除画面所有内容
    [self removeAllThings];
    // 画所有内容
    [self drawAllThings];
}

// 联系我们
- (IBAction)sendMail:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto://yangmu373@gmail.com"]];
}

// 进入官网
- (IBAction)gotoWebsite:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.foul3.com"]];
}

// 给我评分
- (IBAction)doScoring:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=494201918"]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // 开始游戏
    [self startGame];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
