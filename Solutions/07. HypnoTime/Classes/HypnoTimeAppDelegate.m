//
//  HypnoTimeAppDelegate.m
//  HypnoTime
//
//  Created by Alex Silverman on 7/28/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import "HypnoTimeAppDelegate.h"
#import "HypnosisViewController.h"
#import "CurrentTimeViewController.h"

@implementation HypnoTimeAppDelegate

@synthesize window;


- (BOOL)application:(UIApplication *)application 
	didFinishLaunchingWithOptions:(NSDictionary *)launchOptions  
{    
	// Create the tabBarController
	tabBarController = [[UITabBarController alloc] init];
	
	// Create two view controllers
	UIViewController *vc1 = [[HypnosisViewController alloc] init];
	UIViewController *vc2 = [[CurrentTimeViewController alloc] init];
	
	// Make an array containing the two view controllers
	NSArray *viewControllers = [NSArray arrayWithObjects:vc1, vc2, nil];
	
	// Attach them to the tab bar controller
	[tabBarController setViewControllers:viewControllers];
	
	[vc1 release];
	[vc2 release];
	
	// Put the tabBarController's view on the window
	[window addSubview:[tabBarController view]];
	
    // Show the window
    [window makeKeyAndVisible];
	return YES;
}


- (void)dealloc {
	[tabBarController release];
    [window release];
    [super dealloc];
}


@end
