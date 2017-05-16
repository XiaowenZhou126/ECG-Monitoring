//
//  AppDelegate.m
//  ECGMonitorPresentation
//
//  Created by mac on 2017/5/14.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "AppDelegate.h"
#import "monitorTVC.h"
#import "suggestTVC.h"
#import "persionCenterTVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //创建并初始化UITabBarController
    UITabBarController *tabBarOfECG = [[UITabBarController alloc] init];
    self.window.rootViewController = tabBarOfECG;
    
    //初始化4个视图的控制器
    monitorTVC *monitorVC = [[monitorTVC alloc] init];
    suggestTVC *suggestVC = [[suggestTVC alloc] init];
    persionCenterTVC *persionCenterVC = [[persionCenterTVC alloc] init];
    
    //为4个视图控制器添加导航栏控制器
    UINavigationController *monitorNav = [[UINavigationController alloc] initWithRootViewController:monitorVC];
    UINavigationController *suggestNav = [[UINavigationController alloc] initWithRootViewController:suggestVC];
    UINavigationController *aboutNav = [[UINavigationController alloc] initWithRootViewController:persionCenterVC];
    //为导航栏控制器设置title、image
    monitorNav.title = @"ECG Testing";
    monitorNav.tabBarItem.image = [UIImage imageNamed:@"c1"];
    suggestNav.title = @"Suggest";
    suggestNav.tabBarItem.image = [UIImage imageNamed:@"c2"];
    aboutNav.title = @"Persion Center";
    aboutNav.tabBarItem.image = [UIImage imageNamed:@"c4"];
    
    //创建一个数组包含4个导航栏控制器
    NSArray *navArray = [NSArray arrayWithObjects:monitorNav,suggestNav,aboutNav, nil];
    
    //将数组传递给tabBarOfECG
    tabBarOfECG.viewControllers = navArray;
    
//    self.window.backgroundColor = [UIColor redColor];
    [self.window makeKeyAndVisible];
    NSLog(@"bundleIdentifier:%@",[[NSBundle mainBundle]bundleIdentifier]);
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
