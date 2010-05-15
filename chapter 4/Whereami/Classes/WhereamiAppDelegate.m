//
//  WhereamiAppDelegate.m
//  Whereami
//
//  Created by Gautam Dey on 5/13/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "WhereamiAppDelegate.h"
#import "MapPoint.h"


@implementation WhereamiAppDelegate

#pragma mark -
#pragma mark synthesize
@synthesize window;
@synthesize mapView;
@synthesize activityIndicator;
@synthesize locationTitleField;
@synthesize stateLabel;
@synthesize cityLabel;


#pragma mark -
#pragma mark Methods

- (void) findLocation {
    [locationManager startUpdatingLocation];
    [activityIndicator startAnimating];
    [locationTitleField setHidden:YES];
}

- (void) foundLocation {
    [locationTitleField setText:@""];
    [activityIndicator stopAnimating];
    [locationTitleField setHidden:NO];
    [locationManager stopUpdatingLocation];
}

#pragma mark -
#pragma mark IB Actions

- (IBAction) changeMapView:(id)sender {
    UISegmentedControl *control = (UISegmentedControl *)sender;
    [mapView setMapType:[control selectedSegmentIndex]];
}

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
#pragma mark TextView Delegate Methods

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    [self findLocation];
    [textField resignFirstResponder];
    return YES;
}

#pragma mark -
#pragma mark LocationManager Delegate Methods
- (void) locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Could not find locaiton %@",error);
}

- (void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSLog(@" moving to: %@",newLocation);
    NSTimeInterval t = [[newLocation timestamp] timeIntervalSinceNow];
    if( t < -180 ){
        return; // cache data
    }
    MapPoint *mp = [[MapPoint alloc] initWithCoordinate:[newLocation coordinate] andTitle:[locationTitleField text]];
    [mapView addAnnotation:mp];
    [mp release];
    if( reverseGeocoder != nil ){
        [reverseGeocoder cancel];
        [reverseGeocoder release];
        reverseGeocoder = nil;
    }
    reverseGeocoder = [[MKReverseGeocoder alloc] initWithCoordinate:[newLocation coordinate]];
    [reverseGeocoder setDelegate:self];
    [reverseGeocoder start];
    [self foundLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    NSLog(@" new heading is: %@",newHeading);
}

#pragma mark -
#pragma mark MKReverseGeocoderDelegate Methods
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error {
    NSLog(@"Could not find reverse info");
}
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark {
    NSLog(@"Setting labels to: %@, %@",[placemark locality], [placemark administrativeArea]);
    [[self stateLabel] setText:[placemark administrativeArea]];
    [[self stateLabel] setHidden:NO];
    [[self cityLabel] setText:[placemark locality]];
    [[self cityLabel] setHidden:NO];
    [reverseGeocoder release];
    reverseGeocoder = nil;
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
    if (reverseGeocoder != nil ) {
        if ([reverseGeocoder isQuerying]) {
            [reverseGeocoder cancel];
        }
        [reverseGeocoder release];
        reverseGeocoder = nil;
    }
    [super dealloc];
}


@end
