//
//  main.m
//  IntelSplitDemo
//
//  Created by Gregory Combs on 5/22/11.
//  Released under the Creative Commons Attribution 3.0 Unported License
//  Please see the included license page for more information.
//

#import <UIKit/UIKit.h>
#import "IntelSplitDemoAppDelegate.h"

int main(int argc, char *argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, NSStringFromClass([IntelSplitDemoAppDelegate class]));
    [pool release];
    return retVal;
}

