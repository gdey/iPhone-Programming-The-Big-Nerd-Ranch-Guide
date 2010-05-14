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
@synthesize mapView;
@synthesize activityIndicator;
@synthesize locationTitleField;



#pragma mark -
#pragma mark Application Delegate Methods 
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    

        // Create location manager object -
    locationManager = [[CLLocationManager alloc] init];
    
    [locationManager setDelegate:self];
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        //    [locationManager startUpdatingLocation];
    [[self mapView] setShowsUserLocation:YES];
    if ([locationManager headingAvailable]) {
        [locationManager setHeadingFilter:kCLHeadingFilterNone];
        [locationManager startUpdatingHeading];
    } else {
        NSLog(@"Heading is not supported on this device.");
    }

    [window makeKeyAndVisible];
    return YES;
}

#pragma mark -
#pragma mark MapView Delegate Methods
- (void)mapView:(MKMapView *)aMapView didAddAnnotationViews:(NSArray *)views {
    MKAnnotationView *annotationView = [views objectAtIndex:0];
    id <MKAnnotation> mp = [annotationView annotation];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate], 250, 50);
    [aMapView setRegion:region animated:YES];
}

#pragma mark -
#pragma mark LocationManager Delegate Methods
- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Could not find locaiton %@",error);
}

- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@" moving to: %@",newLocation);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    NSLog(@" new heading is: %@",newHeading);
}
#pragma mark -
#pragma mark Memory Management Methods
- (void)dealloc {
    [window release];
    [locationManager setDelegate:nil];
    [locationManager release];
    [self setMapView:nil];
    [self setActivityIndicator:nil];
    [self setLocationTitleField:nil];
    [super dealloc];
}


@end
