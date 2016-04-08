//
//  AppDelegate.h
//  PushPushPoPo
//
//  Created by yang mu on 12-1-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    // 根视图控制器
    RootViewController *rootViewController;
}

@property (strong, nonatomic) UIWindow *window;

@end
