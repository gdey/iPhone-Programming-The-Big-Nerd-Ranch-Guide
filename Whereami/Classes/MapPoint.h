//
//  MapPoint.h
//  Whereami
//
//  Created by Gautam Dey on 8/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MapPoint : NSObject <MKAnnotation,MKReverseGeocoderDelegate> {

    NSString *title;
    CLLocationCoordinate2D coordinate;
    NSString *tagDateString;
    NSString *city;
    NSString *state;

    MKReverseGeocoder *geoCoder;

}


@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *state;

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (id) initWithCoordinate: (CLLocationCoordinate2D)c andTitle:(NSString *)t;

@end
