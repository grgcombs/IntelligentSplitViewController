//
//  DemoDetailViewController.m
//  IntelSplitDemo
//
//  Created by Gregory Combs on 8/5/14.
//
//

#import "DemoDetailViewController.h"

@interface DemoDetailViewController ()
@property (nonatomic,weak) IBOutlet UILabel *viewLabel;
@property (nonatomic,strong) UIPopoverController *masterPopover;
@end

@implementation DemoDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.splitViewController)
    {
        self.splitViewController.delegate = self;
        self.viewLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Detail View in Split-%@", @""), self.splitViewController.title];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return (UIInterfaceOrientationMaskAll);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -
#pragma mark SplitViewDelegate

- (void)splitViewController: (UISplitViewController*)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem*)barButtonItem
       forPopoverController: (UIPopoverController*)pc
{
	 barButtonItem.title = @"Master View";
	 [self.navigationItem setRightBarButtonItem:barButtonItem animated:YES];
	 self.masterPopover = pc;
}


// Called when the view is shown again in the split view, invalidating the button and popover controller.
- (void)splitViewController:(UISplitViewController *)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
	 [self.navigationItem setRightBarButtonItem:nil animated:YES];
	 self.masterPopover = nil;
}

- (void)splitViewController:(UISplitViewController *)svc
          popoverController:(UIPopoverController *)pc
  willPresentViewController:(UIViewController *)aViewController
{
	if (UIInterfaceOrientationIsLandscape(self.interfaceOrientation)) {
		NSLog(@"ERR_POPOVER_IN_LANDSCAPE");
	}
}

@end
