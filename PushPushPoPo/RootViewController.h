//
//  RootViewController.h
//  PushPushPoPo
//
//  Created by yang mu on 12-1-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface RootViewController : UIViewController
{
    // 关于信息UIView
    IBOutlet UIView *infoView;
    AVAudioPlayer  *audioPlayer;
}

// 画背景
- (void)drawBackGround;
// 画一个泡泡
- (void)drawOnePoPoWithX:(int)x andWithY:(int)y;
// 画一些泡泡
- (void)drawSomePoPo;
// 画info按钮
- (void)drawInfoButton;
// 画new按钮
- (void)drawNewButton;
// 捏泡泡
- (void)pushPoPo:(UIGestureRecognizer *)sender;
// 显示关于信息
- (void)showInfoView:(id)sender;
// 移除关于信息
- (IBAction)removeInfoView:(id)sender;
// 新一页
- (void)newPage:(id)sender;
// 移除画面所有内容
- (void)removeAllThings;
// 画所有内容
- (void)drawAllThings;
// 开始游戏
- (void)startGame;
// 重新开始游戏
- (void)restartGame;
// 播放凸时声音
- (void)playConvexSound;
// 播放凹时声音
- (void)playConcaveSound;
// 播放新一页声音
- (void)playNewPageSound;
// 联系我们
- (IBAction)sendMail:(id)sender;
// 进入官网
- (IBAction)gotoWebsite:(id)sender;
// 给我评分
- (IBAction)doScoring:(id)sender;

@end
