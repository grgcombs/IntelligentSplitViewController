//
//  FirstViewController.m
//  IntelSplitDemo
//
//  Created by Gregory Combs on 5/22/11.
//  Released under the Creative Commons Attribution 3.0 Unported License
//  Please see the included license page for more information.
//

#import "MasterViewController.h"


@implementation MasterViewController
@synthesize detailViewController;
@synthesize vcLabel;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.vcLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Master View in Split-%@", @""), 
						 self.splitViewController.title];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
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
	self.detailViewController = nil;
	self.vcLabel = nil;
    [super dealloc];
}

@end
