    //
//  IntelligentSplitViewController.m
//  From TexLege by Gregory S. Combs (last updated 9/21/10)
//
//  Released under the Creative Commons Attribution-ShareAlide 3.0 Unported License
//  Please see the included license page for more information.
//  In a nutshell, you can use this, just attribute this class to me in your thank you notes or about box.
//

#import "IntelligentSplitViewController.h"
#import <objc/message.h>

@implementation IntelligentSplitViewController
//@synthesize isListening;

- (void)awakeFromNib {
	[super awakeFromNib];
	//debug_NSLog(@"IntelligentSplitViewController awoke from NIB: %@", self.title);

//	self.isListening = YES;	
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(willRotate:)
												 name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(didRotate:)
												 name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];	
	
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//debug_NSLog(@"IntelligentSplitViewController loaded: %@", self.title);
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
	//debug_NSLog(@"IntelligentSplitViewController unloaded: %@", self.title);

    [super viewDidUnload];
}


- (void)dealloc {
/*	if (self.isListening) {
		self.isListening = NO;
*/		
		@try {
			//debug_NSLog(@"Splitview unloading ??? title = %@", self.title);
			[[NSNotificationCenter defaultCenter] removeObserver:self /*forKeyPath:UIApplicationWillChangeStatusBarOrientationNotification */];
			[[NSNotificationCenter defaultCenter] removeObserver:self /*forKeyPath:UIApplicationDidChangeStatusBarOrientationNotification */];
		}
		@catch (NSException * e) {
			debug_NSLog(@"IntelligentSplitViewController DE-OBSERVING CRASHED: %@ ... error:%@", self.title, [e description]);
		}
//	}

	[super dealloc];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
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
	BOOL notModal = (!tabBar.modalViewController);
	BOOL isSelectedTab = [self.tabBarController.selectedViewController isEqual:self];
	
	NSTimeInterval duration = [[UIApplication sharedApplication] statusBarOrientationAnimationDuration];
	
	if (!isSelectedTab || !notModal)  { // I don't think we're visible...
		[super willRotateToInterfaceOrientation:toOrientation duration:duration];
		
		UIViewController *master = [self.viewControllers objectAtIndex:0];
		UIBarButtonItem *button = [super valueForKey:@"_barButtonItem"];
		NSObject *theDelegate = (NSObject *)self.delegate;
		//UIBarButtonItem *buttonUgly = [[[[[self.viewControllers objectAtIndex:1] viewControllers] objectAtIndex:0] navigationItem] rightBarButtonItem];
		
		if (UIInterfaceOrientationIsPortrait(toOrientation)) {
			if (theDelegate && [theDelegate respondsToSelector:@selector(splitViewController:willHideViewController:withBarButtonItem:forPopoverController:)]) {

				@try {
					UIPopoverController *popover = [super valueForKey:@"_hiddenPopoverController"];
					objc_msgSend(theDelegate, @selector(splitViewController:willHideViewController:withBarButtonItem:forPopoverController:), self, master, button, popover);
				}
				@catch (NSException * e) {
					NSLog(@"There was a nasty error while notifyng splitviewcontrollers of an orientation change: %@", [e description]);
				}
			}
		}
		else if (UIInterfaceOrientationIsLandscape(toOrientation)) {
			if (theDelegate && [theDelegate respondsToSelector:@selector(splitViewController:willShowViewController:invalidatingBarButtonItem:)]) {
				@try {
					objc_msgSend(theDelegate, @selector(splitViewController:willShowViewController:invalidatingBarButtonItem:), self, master, button);
				}
				@catch (NSException * e) {
					NSLog(@"There was a nasty error while notifyng splitviewcontrollers of an orientation change: %@", [e description]);
				}
			}
		}
	}
	
	//debug_NSLog(@"MINE WillRotate ---- sender = %@  to = %d   from = %d", [sender class], toOrientation, fromOrientation);
}

/*
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	//debug_NSLog(@"Theirs --- will rotate");
}
*/
- (void)didRotate:(id)sender {
	if (![self isViewLoaded]) // we haven't even loaded up yet, let's turn away from this place
		return;

	NSNotification *notification = sender;
	if (!notification)
		return;
	UIInterfaceOrientation fromOrientation = [[notification.userInfo valueForKey:UIApplicationStatusBarOrientationUserInfoKey] integerValue];
	//UIInterfaceOrientation toOrientation = [UIApplication sharedApplication].statusBarOrientation;
	
	UITabBarController *tabBar = self.tabBarController;
	BOOL notModal = (!tabBar.modalViewController);
	BOOL isSelectedTab = [self.tabBarController.selectedViewController isEqual:self];
	
	if (!isSelectedTab || !notModal)  { // I don't think we're visible...
		[super didRotateFromInterfaceOrientation:fromOrientation];
	}
	
	//debug_NSLog(@"MINE DidRotate ---- sender = %@  from = %d   to = %d", [sender class], fromOrientation, toOrientation);
}
/*
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	//debug_NSLog(@"Theirs --- did rotate");
}
*/
@end
