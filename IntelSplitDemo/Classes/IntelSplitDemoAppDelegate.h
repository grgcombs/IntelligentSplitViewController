//
//  IntelSplitDemoAppDelegate.h
//  IntelSplitDemo
//
//  Created by Gregory Combs on 5/22/11.
//  Released under the Creative Commons Attribution 3.0 Unported License
//  Please see the included license page for more information.
//

#import <UIKit/UIKit.h>

@class MasterViewController;

@interface IntelSplitDemoAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>

@property (nonatomic, strong) IBOutlet UITabBarController *tabBarController;

// Convenience Methods / Accessors
@property (nonatomic, readonly) UISplitViewController *splitViewController;
@property (nonatomic, readonly) UIViewController *currentMasterViewController;
@property (nonatomic, readonly) UINavigationController *masterNavigationController;
@property (nonatomic, readonly) UINavigationController *detailNavigationController;

@end
