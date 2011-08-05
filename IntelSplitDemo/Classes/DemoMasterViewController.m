//
//  DemoMasterViewController.m
//  IntelSplitDemo
//
//  Created by Gregory Combs on 8/5/14.
//
//

#import "DemoMasterViewController.h"

@interface DemoMasterViewController ()

@property (nonatomic, weak) IBOutlet UILabel *viewLabel;

@end

@implementation DemoMasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	self.viewLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Master View in Split-%@", @""), self.splitViewController.title];
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

- (UIViewController *)detailViewController
{
    if (!self.splitViewController || !self.splitViewController.viewControllers.count == 2)
        return nil;
    return self.splitViewController.viewControllers[1];
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

@end
