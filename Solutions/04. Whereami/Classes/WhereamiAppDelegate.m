//
//  WhereamiAppDelegate.m
//  Whereami
//
//  Created by Joe Conway on 8/10/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import "WhereamiAppDelegate.h"

@implementation WhereamiAppDelegate

@synthesize window;


- (BOOL)application:(UIApplication *)application 
	didFinishLaunchingWithOptions:(NSDictionary *)launchOptions  
{    
    // Create location manager object -
    // it will send its messages to our WhereamiAppDelegate
    locationManager = [[CLLocationManager alloc] init];
    [locationManager setDelegate:self];
    
    // We want all results from the location manager
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    
    // And we want it to take as much time/power to get us those results
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
	// Tell our manager to start looking for its location immediately
    [locationManager startUpdatingLocation];
	
    [window makeKeyAndVisible];
	return YES;
}
- (void)locationManager:(CLLocationManager *)manager
		didFailWithError:(NSError *)error
{
	NSLog(@"Could not find location: %@", error);
}
- (void)locationManager:(CLLocationManager *)manager 
	didUpdateToLocation:(CLLocation *)newLocation 
		   fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"%@", newLocation);
}

- (void)dealloc {
	[locationManager release];
    [window release];
    [super dealloc];
}


@end
