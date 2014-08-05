//
//  IntelSplitTests.m
//  IntelSplitTests
//
//  Created by Gregory Combs on 8/5/14.
//  Copyright (c) 2014 Gregory S Combs. All rights reserved.
//

@import XCTest;
#import "IntelSplitDemoAppDelegate.h"

@interface IntelSplitTests : XCTestCase

@end

@implementation IntelSplitTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
    IntelSplitDemoAppDelegate *appDelegate = (IntelSplitDemoAppDelegate *)[[UIApplication sharedApplication] delegate];
    UITabBarController *tabController = appDelegate.tabBarController;

    XCTAssertNotNil(tabController, @"No tab controller found");

    XCTAssertEqual(tabController.viewControllers.count, 3, @"Expected 3 content controllers in demo");

    [tabController setSelectedIndex:0];

    UIViewController *firstController = tabController.selectedViewController;
    XCTAssertNotNil(firstController, @"No content controller at index 0");

    [tabController setSelectedIndex:1];
    UIViewController *secondController = tabController.selectedViewController;
    XCTAssertNotNil(secondController, @"No content controller at index 1");

    XCTAssertNotEqualObjects(firstController, secondController, @"Expected different content controllers at indexes 1 and 2");

    [tabController setSelectedIndex:2];
    UIViewController *thirdController = tabController.selectedViewController;
    XCTAssertNotNil(thirdController, @"No content controller at index 2");

    XCTAssertNotEqualObjects(firstController, thirdController, @"Expected different content controllers at indexes 1 and 3");
    XCTAssertNotEqualObjects(secondController, thirdController, @"Expected different content controllers at indexes 2 and 3");
}

@end