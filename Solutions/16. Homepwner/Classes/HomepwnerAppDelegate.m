//
//  HomepwnerAppDelegate.m
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import "HomepwnerAppDelegate.h"
#import "ItemsViewController.h"
#import "FileHelpers.h"

@implementation HomepwnerAppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// Get the full path of our possession archive file
	NSString *possessionPath = [self possessionArrayPath];
	
	// Unarchive it in to an array
	NSMutableArray *possessionArray = 
	[NSKeyedUnarchiver unarchiveObjectWithFile:possessionPath];
	
	// If the file did not exist, our possession array will not either
	// Create one in its absence.
	if (!possessionArray)
		possessionArray = [[NSMutableArray alloc] init];
	
	// Create an instance of ItemsViewController
	itemViewController = [[ItemsViewController alloc] init];
	
	// Give it the possessionArray
	[itemViewController setPossessions:possessionArray];
	
	// Create an instance of a UINavigationController
	// its stack contains only itemsViewController
	UINavigationController *navController = [[UINavigationController alloc] 
																					 initWithRootViewController:itemViewController];
	
	// itemViewController is retained by navController
	[itemViewController release];
	
	// Place navigation controller's view in to window hierarchy
	[window addSubview:[navController view]];
	[window makeKeyAndVisible];
	return YES;
}

- (NSString *)possessionArrayPath
{
	return pathInDocumentDirectory(@"Possessions.data");
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Get full path of possession archive
	NSString *possessionPath = [self possessionArrayPath];
	
	// Get the possession list
	NSMutableArray *possessionArray = [itemViewController possessions];
	
	// Archive possession list to file
	[NSKeyedArchiver archiveRootObject:possessionArray toFile:possessionPath];
}

- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
