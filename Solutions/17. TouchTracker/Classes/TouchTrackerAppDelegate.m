//
//  TouchTrackerAppDelegate.m
//  TouchTracker
//
//  Created by Alex Silverman on 7/28/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import "TouchTrackerAppDelegate.h"

@implementation TouchTrackerAppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application 
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch
    [window makeKeyAndVisible];
	return YES;
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
