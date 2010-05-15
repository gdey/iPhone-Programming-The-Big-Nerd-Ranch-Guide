//
//  HypnosisterAppDelegate.m
//  Hypnosister
//
//  Created by Gautam Dey on 5/15/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "HypnosisterAppDelegate.h"
#import "HypnosisView.h"

@implementation HypnosisterAppDelegate

#pragma mark -
#pragma mark synthesize
@synthesize window;
@synthesize view;


#pragma mark -
#pragma mark Application Delegate Methods 
- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    [self setView:[[HypnosisView alloc] initWithFrame:[window bounds]]];
    [[self view] setBackgroundColor:[UIColor clearColor]];
    [[self window] addSubview:[self view]];
    
    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


#pragma mark -
#pragma mark Memory Management Methods
- (void)dealloc {
    [self setView:nil];
    [self setWindow:nil];
    [super dealloc];
}


@end
