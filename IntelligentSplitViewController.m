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

@implementation IntelligentSplitViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]))
    {
        [self registerObservations];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];

    [self registerObservations];
}


- (void)registerObservations {
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(willRotate:)
												 name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];

	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(didRotate:)
												 name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


- (void)dealloc {
	@try {
		[[NSNotificationCenter defaultCenter] removeObserver:self];
	}
	@catch (NSException * e) {
		NSLog(@"IntelligentSplitViewController DE-OBSERVING CRASHED: %@ ... error:%@", self.title, e);
	}
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return (UIInterfaceOrientationMaskAll);
}

- (void)willRotate:(id)sender {
	if (![self isViewLoaded]) // we haven't even loaded up yet, let's turn away from this place
		return;
		  
	NSNotification *notification = sender;
	if (!notification)
		return;
	
	UIInterfaceOrientation toOrientation = [[notification.userInfo valueForKey:UIApplicationStatusBarOrientationUserInfoKey] integerValue];
	//UIInterfaceOrientation fromOrientation = [UIApplication sharedApplication].statusBarOrientation;

	UITabBarController *tabBar = self.tabBarController;
	BOOL notModal = (!tabBar.presentedViewController);
	BOOL isSelectedTab = [self.tabBarController.selectedViewController isEqual:self];
	
	NSTimeInterval duration = [[UIApplication sharedApplication] statusBarOrientationAnimationDuration];
	

	if (!isSelectedTab || !notModal)  { 
		// Looks like we're not "visible" ... propogate rotation info
		[super willRotateToInterfaceOrientation:toOrientation duration:duration];
		
		UIViewController *master = [self.viewControllers objectAtIndex:0];
		NSObject *theDelegate = (NSObject *)self.delegate;

        if (!theDelegate ||
            ![theDelegate isKindOfClass:[UIViewController class]] ||
            ![theDelegate conformsToProtocol:@protocol(UISplitViewControllerDelegate)])
        {
            NSLog(@"Be sure to set the split view controller delegate to its detail view controller");
            return;
        }

		UIBarButtonItem *button = nil;

        if ([[(UIViewController *)theDelegate navigationItem] rightBarButtonItem])
        {
            button = [[(UIViewController *)theDelegate navigationItem] rightBarButtonItem];
        }
        else
        {
            // A last-ditch effort to get the bar button item -- sometimes it works when the previous does not.

            #define YOU_DONT_FEEL_QUEAZY_ABOUT_THIS_BECAUSE_IT_PASSES_THE_APP_STORE 1
            #if YOU_DONT_FEEL_QUEAZY_ABOUT_THIS_BECAUSE_IT_PASSES_THE_APP_STORE
            @try {
                button = [super valueForKey:@"_barButtonItem"];
            }
            @catch (NSException *e) {
                NSLog(@"Exception occurred while to identify the split view popover button: %@", e);
            }
            #endif
        }

        @try {
            if (UIInterfaceOrientationIsPortrait(toOrientation)) {
                if ([theDelegate respondsToSelector:@selector(splitViewController:willHideViewController:withBarButtonItem:forPopoverController:)]) {
					UIPopoverController *popover = nil;
                    @try {
                        popover = [super valueForKey:@"_hiddenPopoverController"];
                    }
                    @catch (NSException *e) {
                        NSLog(@"Exception occurred while to identify the split view popover controller: %@", e);
                    }
                    void (*response)(id, SEL, id, id, id, id) = (void (*)(id, SEL, id, id, id, id)) objc_msgSend;
                    response(theDelegate, @selector(splitViewController:willHideViewController:withBarButtonItem:forPopoverController:), self, master, button, popover);
                }
            }
            else if (UIInterfaceOrientationIsLandscape(toOrientation)) {
                if ([theDelegate respondsToSelector:@selector(splitViewController:willShowViewController:invalidatingBarButtonItem:)]) {
                    void (*response)(id, SEL, id, id, id) = (void (*)(id, SEL, id, id, id)) objc_msgSend;
                    response(theDelegate, @selector(splitViewController:willShowViewController:invalidatingBarButtonItem:), self, master, button);
                }
            }
        }
        @catch (NSException * e) {
            NSLog(@"There was a nasty error while notifyng splitviewcontrollers of an orientation change: %@", e);
        }

	}
}

- (void)didRotate:(id)sender {
	if (![self isViewLoaded]) // we haven't even loaded up yet, let's turn away from this place
		return;

	NSNotification *notification = sender;
	if (!notification)
		return;
	UIInterfaceOrientation fromOrientation = [[notification.userInfo valueForKey:UIApplicationStatusBarOrientationUserInfoKey] integerValue];

	UITabBarController *tabBar = self.tabBarController;
	BOOL notModal = (!tabBar.presentedViewController);
	BOOL isSelectedTab = [self.tabBarController.selectedViewController isEqual:self];
	
	if (!isSelectedTab || !notModal)  { 
		// Looks like we're not "visible" ... broadcast rotation info
		[super didRotateFromInterfaceOrientation:fromOrientation];
	}
}

@end
