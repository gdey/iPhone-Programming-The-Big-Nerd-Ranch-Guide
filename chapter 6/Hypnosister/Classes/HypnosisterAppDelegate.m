//
//  HypnosisterAppDelegate.m
//  Hypnosister
//
//  Created by Gautam Dey on 5/15/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "HypnosisterAppDelegate.h"

@implementation HypnosisterAppDelegate

#pragma mark -
#pragma mark synthesize
@synthesize window;


#pragma mark -
#pragma mark Application Delegate Methods 
- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


#pragma mark -
#pragma mark Memory Management Methods
- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
