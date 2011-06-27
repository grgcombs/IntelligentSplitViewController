//
//  IntelSplitDemoAppDelegate.m
//  IntelSplitDemo
//
//  Created by Gregory Combs on 5/22/11.
//  Released under the Creative Commons Attribution 3.0 Unported License
//  Please see the included license page for more information.
//

#import "IntelSplitDemoAppDelegate.h"
#import "MasterViewController.h"

@implementation IntelSplitDemoAppDelegate

@synthesize mainWindow;
@synthesize tabBarController;
@synthesize aMasterVC, bMasterVC, cMasterVC;


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
		return [split.viewControllers objectAtIndex:0];
	return nil;
}

- (UINavigationController *) detailNavigationController {
	UISplitViewController *split = [self splitViewController];
	if (split && split.viewControllers && [split.viewControllers count]>1)
		return [split.viewControllers objectAtIndex:1];
	return nil;
}

- (UIViewController *) currentMasterViewController {
	UINavigationController *nav = [self masterNavigationController];
	if (nav && nav.viewControllers && [nav.viewControllers count])
		return [nav.viewControllers objectAtIndex:0];
	return nil;
}

#pragma mark -
#pragma mark UITabBarControllerDelegate methods

- (BOOL)tabBarController:(UITabBarController *)tbc shouldSelectViewController:(UIViewController *)viewController {
	if (!viewController.tabBarItem.enabled)
		return NO;
	
	if (![viewController isEqual:tbc.selectedViewController]) {
		//debug_NSLog(@"About to switch tabs, popping to root view controller.");
		UINavigationController *nav = [self detailNavigationController];
		if (nav && [nav.viewControllers count]>1)
			[nav popToRootViewControllerAnimated:YES];
	}
	
	return YES;
}

#pragma mark -
#pragma mark Setup App Tabs / Splits

- (void)setupSplitViews {
	NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"SplitViews" owner:self options:nil];

	if (!nibObjects || [nibObjects count] == 0) {
		NSLog(@"Error loading user interface NIB components! Can't find the nib file and can't continue this comical charade.");
		exit(0);
	}
	
	NSArray *VCs = [[NSArray alloc] initWithObjects:self.aMasterVC, self.bMasterVC, self.cMasterVC, nil];
	NSArray *names = [NSArray arrayWithObjects:
					  @"A", 
					  @"B",
					  @"C", nil];
	
	NSMutableArray *splitViewControllers = [[NSMutableArray alloc] initWithCapacity:[VCs count]];
	NSInteger index = 0;
	for (MasterViewController * controller in VCs) {
		UISplitViewController * split = [controller splitViewController];
		if (split) {
			// THIS SETS UP THE TAB BAR ITEMS/IMAGES AND SET THE TAG FOR TABBAR_ITEM_TAGS
			NSString *tabName = [names objectAtIndex:index];
			UIImage *tabImage = [UIImage imageNamed:[NSString stringWithFormat:@"Split-%@.png", tabName]];
			split.title = tabName;
			UITabBarItem *tempTab = [[UITabBarItem alloc] initWithTitle:tabName 
																  image:tabImage 
																	tag:index];
			split.tabBarItem = tempTab;
			[tempTab release];
			
			[splitViewControllers addObject:split];
		}
		index++;
	}
	[self.tabBarController setViewControllers:splitViewControllers];
	[splitViewControllers release];
	[VCs release];

	[self.mainWindow addSubview:self.tabBarController.view];	
	[self.mainWindow makeKeyAndVisible];

}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
	// Set up the mainWindow and content view
	UIWindow *localMainWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.mainWindow = localMainWindow;
	[localMainWindow release];
	
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

- init {
	if ((self = [super init])) {
		// initialize  to nil
		mainWindow = nil;
	}
	return self;
}


- (void)dealloc {
    self.tabBarController = nil;
    self.mainWindow = nil;
	self.aMasterVC = self.bMasterVC = self.cMasterVC = nil;
    [super dealloc];
}

@end

