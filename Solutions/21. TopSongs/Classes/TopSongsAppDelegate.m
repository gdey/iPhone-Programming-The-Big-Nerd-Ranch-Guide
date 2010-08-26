//
//  TopSongsAppDelegate.m
//  TopSongs
//
//  Created by Joe Conway on 1/25/10.
//  Copyright Big Nerd Ranch 2010. All rights reserved.
//

#import "TopSongsAppDelegate.h"
#import "RSSTableViewController.h"

@implementation TopSongsAppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
	RSSTableViewController *tvc = [[RSSTableViewController alloc] initWithStyle:UITableViewStylePlain];
	[window addSubview:[tvc view]];
    [window makeKeyAndVisible];
	return YES;
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
