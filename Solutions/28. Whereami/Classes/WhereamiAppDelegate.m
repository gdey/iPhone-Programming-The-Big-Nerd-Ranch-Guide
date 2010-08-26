//
//  WhereamiAppDelegate.m
//  Whereami
//
//  Created by Joe Conway on 8/10/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import "WhereamiAppDelegate.h"
#import "MapPoint.h"

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
	//[locationManager startUpdatingLocation];
	[mapView setShowsUserLocation:YES];
	
    [window makeKeyAndVisible];
	return YES;
}
- (void)findLocation
{
	[locationManager startUpdatingLocation];
	[activityIndicator startAnimating];
	[locationTitleField setHidden:YES];
}
- (void)foundLocation
{
	[locationTitleField setText:@""];
	[activityIndicator stopAnimating];
	[locationTitleField setHidden:NO];
	[locationManager stopUpdatingLocation];
}
- (BOOL)textFieldShouldReturn:(UITextField *)tf
{
	[self findLocation];
	[tf resignFirstResponder];
	return YES;
}
- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views
{
    MKAnnotationView *annotationView = [views objectAtIndex:0];
    id <MKAnnotation> mp = [annotationView annotation];
    MKCoordinateRegion region = 
        MKCoordinateRegionMakeWithDistance([mp coordinate], 250, 250);
    [mv setRegion:region animated:YES];
}
- (void)locationManager:(CLLocationManager *)manager
		didFailWithError:(NSError *)error
{
	NSLog(@"Could not find location: %@", error);
	[self foundLocation];
}
- (void)locationManager:(CLLocationManager *)manager 
	didUpdateToLocation:(CLLocation *)newLocation 
		   fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"%@", newLocation);
	
    // How many seconds ago was this new location created?
    NSTimeInterval t = [[newLocation timestamp] timeIntervalSinceNow];
    // CLLocationManagers will return the last found location of the 
    // device first, you don't want that data in this case.
    // If this location was made was more than 3 minutes ago, ignore it. 
    if (t < -180) {
        // This is cached data, you don't want it, keep looking
        return;
    }
    MapPoint *mp = [[MapPoint alloc] 
                        initWithCoordinate:[newLocation coordinate] 
                                     title:[locationTitleField text]];
    [mapView addAnnotation:mp];
    [mp release];

    [self foundLocation];
}

- (void)dealloc {
	[mapView release];
	[activityIndicator release];
	[locationTitleField release];
	[locationManager release];
    [window release];
    [super dealloc];
}


@end
