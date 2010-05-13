//
//  WhereamiAppDelegate.m
//  Whereami
//
//  Created by Gautam Dey on 5/13/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "WhereamiAppDelegate.h"

@implementation WhereamiAppDelegate

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
