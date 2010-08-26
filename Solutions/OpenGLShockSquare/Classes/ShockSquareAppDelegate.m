//
//  ShockSquareAppDelegate.m
//  ShockSquare
//
//  Created by Joe Conway on 7/27/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import "ShockSquareAppDelegate.h"
#import "ShockSquareViewController.h"

@implementation ShockSquareAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application 
{    
    [application setStatusBarHidden:YES]; 
    
    viewController = [[ShockSquareViewController alloc] initWithNibName:nil bundle:nil]; 
    [window addSubview:[viewController view]]; 
    [window makeKeyAndVisible]; 
} 



- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
