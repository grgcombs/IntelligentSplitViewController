//
//  IntelSplitDemoAppDelegate.m
//  IntelSplitDemo
//
//  Created by Gregory Combs on 5/22/11.
//  Released under the Creative Commons Attribution 3.0 Unported License
//  Please see the included license page for more information.
//

#import "IntelSplitDemoAppDelegate.h"
#import "DemoMasterViewController.h"

@implementation IntelSplitDemoAppDelegate
@synthesize window = _window;

#pragma mark -
#pragma mark Convenience Methods / Accessors

////// IPAD ONLY
- (UISplitViewController *) splitViewController {
	if (![self.tabBarController.selectedViewController isKindOfClass:[UISplitViewController class]]) {
		NSLog(@"Unexpected navigation controller class in tab bar controller hierarchy, check nib.");
		return nil;
	}
	return (UISplitViewController *)self.tabBarController.selectedViewController;
}

- (UINavigationController *) masterNavigationController {
	UISplitViewController *split = [self splitViewController];
	if (split && split.viewControllers && [split.viewControllers count])
		return split.viewControllers[0];
	return nil;
}

- (UINavigationController *) detailNavigationController {
	UISplitViewController *split = [self splitViewController];
	if (split && split.viewControllers && [split.viewControllers count]>1)
		return split.viewControllers[1];
	return nil;
}

- (UIViewController *) currentMasterViewController {
	UINavigationController *nav = [self masterNavigationController];
	if (nav && nav.viewControllers && [nav.viewControllers count])
		return nav.viewControllers[0];
	return nil;
}

#pragma mark -
#pragma mark UITabBarControllerDelegate methods

- (BOOL)tabBarController:(UITabBarController *)tbc shouldSelectViewController:(UIViewController *)viewController {
	if (!viewController.tabBarItem.enabled)
		return NO;
	
	if (![viewController isEqual:tbc.selectedViewController]) {
		UINavigationController *nav = [self detailNavigationController];
		if (nav && [nav.viewControllers count]>1)
			[nav popToRootViewControllerAnimated:YES];
	}
	
	return YES;
}

#pragma mark -
#pragma mark Setup App Tabs / Splits

- (void)setupSplitViews {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"IntelSplitDemo" bundle:[NSBundle  mainBundle]];
    self.tabBarController = [storyboard instantiateViewControllerWithIdentifier:@"DemoTabController"];
    self.window.rootViewController = self.tabBarController;
	[self.window makeKeyAndVisible];
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

    if (!self.window)
    {
        self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    }

	[self setupSplitViews];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
	NSLog(@"LOW_MEMORY_WARNING");
}

@end

