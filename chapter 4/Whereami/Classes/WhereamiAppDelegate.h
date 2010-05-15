//
//  WhereamiAppDelegate.h
//  Whereami
//
//  Created by Gautam Dey on 5/13/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>


@interface WhereamiAppDelegate : NSObject <UIApplicationDelegate, CLLocationManagerDelegate, MKMapViewDelegate, MKReverseGeocoderDelegate> {
    UIWindow *window;
    CLLocationManager *locationManager;
    MKReverseGeocoder *reverseGeocoder;
    
    MKMapView *mapView;
    UIActivityIndicatorView *activityIndicator;
    UITextField *locationTitleField;
    UILabel *cityLabel;
    UILabel *stateLabel;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) IBOutlet UITextField *locationTitleField;
@property (nonatomic, retain) IBOutlet UILabel *cityLabel;
@property (nonatomic, retain) IBOutlet UILabel *stateLabel;

#pragma mark Action Methods

-(IBAction) changeMapView:(id)sender;

#pragma mark MKReverseGeocoderDelegate Methods
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error;
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark;
@end

