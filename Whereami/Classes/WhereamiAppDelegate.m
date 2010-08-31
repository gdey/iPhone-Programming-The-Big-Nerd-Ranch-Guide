//
//  WhereamiAppDelegate.m
//  Whereami
//
//  Created by Gautam Dey on 8/28/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "WhereamiAppDelegate.h"
#import "MapPoint.h"

@implementation WhereamiAppDelegate

@synthesize window;
@synthesize mapView;
@synthesize activityIndicator;
@synthesize locationField;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	
        // Create location manager object - 
    locationManager = [[CLLocationManager alloc] init];
    
        // Make this instance of WhereamiAppDelegate the delegate
        // it will send its messages to our WhereamiAppDelegate
    [locationManager setDelegate:self];
    
        // We want all results from the location manager
    [locationManager setDistanceFilter:kCLDistanceFilterNone];
    
        // And we want it to be as accurate as possible
        // regardless of how much time/power it takes
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
        // Tell our manager to start looking for its location immediately
        // [locationManager startUpdatingLocation];
    [mapView setShowsUserLocation:YES];
    
    
    [locationManager setHeadingFilter:kCLHeadingFilterNone];
    
        // Tell our manager to start looking for heading inforamtion
    [locationManager startUpdatingHeading];
    
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark -
#pragma mark workhorses


- (void) findLocation {
    
    [locationManager startUpdatingLocation];
    [activityIndicator startAnimating];
    [locationField setHidden:YES];
}


- (void) foundLocation {
    
    [locationField setText:@""];
    [activityIndicator stopAnimating];
    [locationField setHidden:NO];
    [locationManager stopUpdatingLocation];
    
}

#pragma mark -
#pragma mark UITextField Delegate Methods

- (BOOL) textFieldShouldReturn:(UITextField *)tf {
    
    [self findLocation];
    [tf resignFirstResponder];
    return YES;
}

#pragma mark -
#pragma mark MapView Delegate Methods

- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views {

    MKAnnotationView *annotationView = [views objectAtIndex:0];
    id <MKAnnotation> mp = [annotationView annotation];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance([mp coordinate], 250, 250);
    [mv setRegion:region animated:YES];
}

#pragma mark -
#pragma mark CoreLocation Delegate Methods 

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"%@",newLocation);
    
    NSTimeInterval t = [[newLocation timestamp] timeIntervalSinceNow];
    
    if (t < -180) {
        return;
    }
    MapPoint *mp = [[MapPoint alloc] initWithCoordinate:[newLocation coordinate] andTitle:[locationField text]];
    [mapView addAnnotation:mp];
    [mp release];
    
    [self foundLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"Could not find location: %@",error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    NSLog(@"New heading is %#",newHeading);
}
#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    
    [locationManager setDelegate:nil];
    [window release];
    [super dealloc];
}


@end
