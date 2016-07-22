//
//  AppDelegate.m
//  SYB
//
//  Created by WangJincai on 16/6/13.
//  Copyright © 2016年 WJC.com. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "KSJXTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


//初始化配置参数
+ (void)initialize{
    
    NSDictionary *data = @{kEntId:@"f37231af99384af2bcfb6c11fe12f290",
                           };
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:data];
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
     self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    [[UINavigationBar appearance] setBarTintColor:kALL_COLOR];
//    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont fontWithName:kFontName size:20],NSFontAttributeName,@0.0,NSBaselineOffsetAttributeName, nil]];
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    


//    BOOL IsFirstLoginFlag = [[NSUserDefaults standardUserDefaults] boolForKey:kIsFirstLoginFlag];
//    if (IsFirstLoginFlag) {
        [self showLoginViewController];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)loginView{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginViewController];
    self.window.rootViewController = navController;
}

- (void)showLoginViewController {
    [self loginView];
}

@end
