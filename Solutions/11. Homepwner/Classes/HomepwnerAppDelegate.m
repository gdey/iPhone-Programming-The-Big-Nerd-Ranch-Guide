//
//  HomepwnerAppDelegate.m
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import "HomepwnerAppDelegate.h"
#import "ItemsViewController.h"

@implementation HomepwnerAppDelegate

@synthesize window;


- (BOOL)application:(UIApplication *)application 
	didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    

	// Create a ItemsViewController
	itemsViewController = [[ItemsViewController alloc] init];
	// Place ItemsViewController's table view in the window hierarchy
	[window addSubview:[itemsViewController view]];
	[window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
