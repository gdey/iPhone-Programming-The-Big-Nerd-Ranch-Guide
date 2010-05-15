//
//  MapPoint.h
//  Whereami
//
//  Created by Gautam Dey on 5/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapPoint : NSObject <MKAnnotation> {

    NSString *title;
    NSString *_tagDateString;
    CLLocationCoordinate2D coordinate;
}
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;


- (id)initWithCoordinate:(CLLocationCoordinate2D)c andTitle:(NSString *)title;
- (NSString *)subtitle;

@end
