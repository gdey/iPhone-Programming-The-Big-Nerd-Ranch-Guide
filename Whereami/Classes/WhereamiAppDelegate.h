//
//  WhereamiAppDelegate.h
//  Whereami
//
//  Created by Gautam Dey on 8/28/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface WhereamiAppDelegate : NSObject <UIApplicationDelegate, CLLocationManagerDelegate, MKMapViewDelegate> {
    UIWindow *window;
    CLLocationManager *locationManager;
    
    IBOutlet MKMapView *mapView;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    IBOutlet UITextField *locationField;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) IBOutlet UITextField *locationField;


- (void) findLocation;
- (void) foundLocation;

@end

