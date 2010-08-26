//
//  HeavyRotationAppDelegate.m
//  HeavyRotation
//
//  Created by Alex Silverman on 7/28/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import "HeavyRotationAppDelegate.h"
#import "HeavyViewController.h"

@implementation HeavyRotationAppDelegate

@synthesize window;


- (BOOL)application:(UIApplication *)application 
	didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
	// Get hold of the device object
	UIDevice *device = [UIDevice currentDevice];
	
	// Tell it to start monitoring the accelerometer for orientation
	[device beginGeneratingDeviceOrientationNotifications];
	
	// Get hold of the notification center for the app
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	
	// Add yourself as an observer
	[nc addObserver:self 
		   selector:@selector(orientationChanged:) 
			   name:UIDeviceOrientationDidChangeNotification 
			 object:device];
	
	HeavyViewController *hvc = [[HeavyViewController alloc] init];
	[window addSubview:[hvc view]];
    [window makeKeyAndVisible];
	
	return YES;
}

- (void)orientationChanged:(NSNotification *)note
{
	// Log the constant that represents the current orientation
	NSLog(@"orientationChanged: %d", [[note object] orientation]);
}

- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
