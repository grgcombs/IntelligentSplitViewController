//
//  SecondViewController.m
//  IntelSplitDemo
//
//  Created by Gregory Combs on 5/22/11.
//  Released under the Creative Commons Attribution 3.0 Unported License
//  Please see the included license page for more information.
//

#import "DetailViewController.h"


@implementation DetailViewController
@synthesize vcLabel;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.vcLabel.text = [NSString stringWithFormat:@"Detail View in Split-%@", 
						 self.splitViewController.title];

}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


#pragma mark -
#pragma mark SplitViewDelegate

- (void)splitViewController: (UISplitViewController*)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem*)barButtonItem forPopoverController: (UIPopoverController*)pc {
	/*
	 //debug_NSLog(@"Entering portrait, showing the button: %@", [aViewController class]);
	 barButtonItem.title = @"Things";
	 [self.navigationItem setRightBarButtonItem:barButtonItem animated:YES];
	 self.masterPopover = pc;
	 */
}


// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController: (UISplitViewController*)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
	/*
	 //debug_NSLog(@"Entering landscape, hiding the button: %@", [aViewController class]);
	 [self.navigationItem setRightBarButtonItem:nil animated:YES];
	 self.masterPopover = nil;
	 */
}

- (void) splitViewController:(UISplitViewController *)svc popoverController: (UIPopoverController *)pc
   willPresentViewController: (UIViewController *)aViewController
{
	if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
		self.interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
		NSLog(@"ERR_POPOVER_IN_LANDSCAPE");
	}
}	


#pragma mark -
#pragma mark Memory management

- (void)viewDidUnload {
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
	self.vcLabel = nil;
    [super dealloc];
}

@end
