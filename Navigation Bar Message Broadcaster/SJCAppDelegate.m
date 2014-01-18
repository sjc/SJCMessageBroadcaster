//
//  SJCAppDelegate.m
//  Navigation Bar Message Broadcaster
//
//  Created by Stuart Crook on 17/01/2014.
//  Copyright (c) 2014 Stuart Crook. All rights reserved.
//

#import "SJCAppDelegate.h"
#import "SJCRootViewController.h"
#import "SJCMessageBroadcaster.h"

@implementation SJCAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // create some view controllers
    NSMutableArray *controllers = [NSMutableArray new];
    for(NSString *title in @[ @"One", @"Two", @"Three", @"Four" ]) {
        SJCMessageRecieverViewController *vc = [SJCRootViewController new];
        vc.title = title;
        [controllers addObject: [[UINavigationController alloc] initWithRootViewController: vc]];
    }
    
    // put the view controllers into a tab bar controller
    UITabBarController *tbc = [UITabBarController new];
    tbc.viewControllers = controllers;

    // display the same series of messages in each of those those view controllers' nav bars
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^(void){
        [[SJCMessageBroadcaster shared] broadcastMessages: @[ @"Hello", @"World", @"!!!" ]];
    });

    _window = [[UIWindow alloc] initWithFrame: [UIScreen mainScreen].bounds];
    _window.rootViewController = tbc;
    [_window makeKeyAndVisible];

    return YES;
}
			
@end
