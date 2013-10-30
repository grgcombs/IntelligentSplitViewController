//
//  IntelligentSplitViewController.m
//  From TexLege by Gregory S. Combs
//
//  Released under the Creative Commons Attribution 3.0 Unported License
//  Please see the included license page for more information.
//
//  In a nutshell, you can use this, just attribute this to me in your "thank you" notes or about box.
//

#import "IntelligentSplitViewController.h"
#import <objc/message.h>

@interface IntelligentSplitViewController()
@property (strong, nonatomic) UIView *popoverSuperview;
@end

@implementation IntelligentSplitViewController

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {

		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(willRotate:)
													 name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(didRotate:)
													 name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
	}
	return self;
}

- (void)awakeFromNib {
	[super awakeFromNib];

	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(willRotate:)
												 name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];

	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(didRotate:)
												 name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
	
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // part of a bugfix hack -- for more details, see the Landscape orientation condition of willRotate
    UIView *popoverSuperview = ((UIPopoverController*)[super valueForKey:@"_hiddenPopoverController"]).contentViewController.view.superview;
    if (popoverSuperview) {
        _popoverSuperview = popoverSuperview;
    }
}

- (void)willRotate:(NSNotification*)notification {
	if (![self isViewLoaded] || notification == nil) { return; }
	
	UIInterfaceOrientation toOrientation = [[notification.userInfo valueForKey:UIApplicationStatusBarOrientationUserInfoKey] intValue];

	UITabBarController *tabBar = self.tabBarController;
	BOOL notModal = (!tabBar.modalViewController);
	BOOL isSelectedTab = [self.tabBarController.selectedViewController isEqual:self];
	
	NSTimeInterval duration = [[UIApplication sharedApplication] statusBarOrientationAnimationDuration];
	
	if (!isSelectedTab || !notModal)  {
		// SplitVC is not visible, propogate rotation info:
		[super willAnimateRotationToInterfaceOrientation:toOrientation duration:duration];
		
		UIViewController *master = [self.viewControllers objectAtIndex:0];
		id<UISplitViewControllerDelegate> theDelegate = self.delegate;
		
#define YOU_DONT_FEEL_QUEAZY_ABOUT_THIS_BECAUSE_IT_PASSES_THE_APP_STORE 1

#if YOU_DONT_FEEL_QUEAZY_ABOUT_THIS_BECAUSE_IT_PASSES_THE_APP_STORE
		UIBarButtonItem *button = [super valueForKey:@"_barButtonItem"];
		
#else
		UIBarButtonItem *button = [[[[[self.viewControllers objectAtIndex:1] 
									  viewControllers] objectAtIndex:0] 
									navigationItem] leftBarButtonItem];
#endif
		
		if (UIInterfaceOrientationIsPortrait(toOrientation)) {
            @try {
                UIPopoverController *popover = [super valueForKey:@"_hiddenPopoverController"];
                objc_msgSend(theDelegate, @selector(splitViewController:willHideViewController:withBarButtonItem:forPopoverController:), self, master, button, popover);
            }
            @catch (NSException * e) {
                NSLog(@"Encounterd an error while notifyng splitVC of orientation change: %@", [e description]);
            }
		}
		else if (UIInterfaceOrientationIsLandscape(toOrientation)) {
            @try {
                objc_msgSend(theDelegate, @selector(splitViewController:willShowViewController:invalidatingBarButtonItem:), self, master, button);
                
                if (!master.view.superview) {
                    
                    // NOTE: This is a bugfix hack to prevent the master VC from disappearing on certain tabBar events.
                    // Bug repro: 1) comment out this if statement. 2) Launch the app in Portrait mode. 3) Tap on the 'Colors' tab. 4) tap on the star icon to open the popover. 5) Tap anywhere to close the popover. 6) Tap on the 'Controls' tab. 7) Rotate the app to Landscape mode. 8) Tap on the 'Colors' tab. RESULT: there's an empty spot where the MasterVC is supposed to be!
                    
                    [self.popoverSuperview addSubview:master.view];
                }
            }
            @catch (NSException * e) {
                NSLog(@"Encounterd an error while notifyng splitVC of orientation change: %@", [e description]);
            }
		}
	}
}

- (void)didRotate:(NSNotification*)notification {
	if (![self isViewLoaded] || notification == nil) { return; }
    
	UIInterfaceOrientation fromOrientation = [[notification.userInfo valueForKey:UIApplicationStatusBarOrientationUserInfoKey] integerValue];
	
	UITabBarController *tabBar = self.tabBarController;
	BOOL notModal = (!tabBar.modalViewController);
	BOOL isSelectedTab = [self.tabBarController.selectedViewController isEqual:self];
	
	if (!isSelectedTab || !notModal)  { 
		// SplitVC is not visible, propogate rotation info:
		[super didRotateFromInterfaceOrientation:fromOrientation];
	}
}

@end
