//
//  FirstViewController.h
//  IntelSplitDemo
//
//  Created by Gregory Combs on 5/22/11.
//  Released under the Creative Commons Attribution 3.0 Unported License
//  Please see the included license page for more information.
//

#import <UIKit/UIKit.h>


@interface MasterViewController : UIViewController {
	UIViewController *detailViewController;
	UILabel *vcLabel;
}

@property (nonatomic, retain) IBOutlet UIViewController *detailViewController;
@property (nonatomic, retain) IBOutlet UILabel *vcLabel;
@end
