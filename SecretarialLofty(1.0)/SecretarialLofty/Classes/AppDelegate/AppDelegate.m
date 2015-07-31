//
//  AppDelegate.m
//  SecretarialLofty
//
//  Created by SecretarialLofty on 15/7/8.
//  Copyright (c) 2015年 文书轩. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarViewController.h"
#import "GuideViewController.h"

@interface AppDelegate ()

#define kWidthScree [UIScreen mainScreen].bounds.size.width
#define kHeightScree [UIScreen mainScreen].bounds.size.height

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  //  NSLog(@"%@", NSTemporaryDirectory());
    // 创建window窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [[UIScreen mainScreen] bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
    if ([user valueForKey:@"first"]==nil) {
        GuideViewController *guide=[[GuideViewController alloc]init];
        self.window.rootViewController=guide;
        [user setBool:YES forKey:@"first"];
    }
    else{
    self.window.rootViewController = [[RootTabBarViewController alloc] init];
        [user setBool:NO forKey:@"first"];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
