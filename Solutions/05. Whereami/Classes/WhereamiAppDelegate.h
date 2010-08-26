//
//  WhereamiAppDelegate.h
//  Whereami
//
//  Created by Joe Conway on 8/10/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@class MapPoint;

@interface WhereamiAppDelegate : NSObject 
	<UIApplicationDelegate, CLLocationManagerDelegate, MKMapViewDelegate> 
{
    UIWindow *window;

	CLLocationManager *locationManager;
	
	IBOutlet MKMapView *mapView;
	IBOutlet UIActivityIndicatorView *activityIndicator;
	IBOutlet UITextField *locationTitleField;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (void)findLocation;
- (void)foundLocation;

@end

