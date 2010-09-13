//
//  MapPoint.m
//  Whereami
//
//  Created by Gautam Dey on 8/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapPoint.h"


@implementation MapPoint

@synthesize city, state, title, coordinate;

- (id) initWithCoder:(NSCoder *)dc {
    [super init];
    [self setTitle:[dc decodeObjectForKey:@"title"]];
    [self setCity:[dc decodeObjectForKey:@"city"]];
    [self setState:[dc decodeObjectForKey:@"state"]];
    NSDictionary *coordinateDict = [dc decodeObjectForKey:@"coordinateDict"];
    coordinate = CLLocationCoordinate2DMake([(NSNumber *)[coordinateDict objectForKey:@"latitude"]  doubleValue], 
                                                   [(NSNumber *)[coordinateDict objectForKey:@"longitude"] doubleValue]);
    tagDateString = [[dc decodeObjectForKey:@"tagDateString"] retain];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)ec {
    [ec encodeObject:[self title] forKey:@"title"];
    [ec encodeObject:[self city] forKey:@"city"];
    [ec encodeObject:[self state] forKey:@"state"];
    [ec encodeObject:tagDateString forKey:@"tagDateString"];
    [ec encodeObject:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:[NSNumber numberWithDouble:coordinate.latitude],[NSNumber numberWithDouble:coordinate.longitude],nil]
                                                 forKeys:[NSArray arrayWithObjects:@"latitude",@"longitude",nil]] 
              forKey:@"coordinateDict"];
    
}


- (id) initWithCoordinate: (CLLocationCoordinate2D)c andTitle:(NSString *)t {
    
    [super init];
    coordinate = c;
    [self setTitle:t];
    NSDate *tagDate = [NSDate date];
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    [dateFomatter setTimeStyle:NSDateFormatterMediumStyle];
    [dateFomatter setDateStyle:NSDateFormatterMediumStyle];
    
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFomatter setLocale:usLocale];
    [usLocale release];
    tagDateString = [[dateFomatter stringFromDate:tagDate] retain];
        
    [dateFomatter release];
    
        // Setup the Geocoder.
    geoCoder = [[MKReverseGeocoder alloc] initWithCoordinate:c];
    [geoCoder setDelegate:self];
    [geoCoder start];
    
    return self;
}


- (NSString *)subtitle {
    NSString *subtitle = [NSString stringWithFormat:@"Date: %@", tagDateString];
    if (city != nil && state != nil) {
        subtitle = [NSString stringWithFormat:@"%@, %@ -- %@",city,state,subtitle];
    }
    return subtitle;
}

- (void) dealloc {
    [geoCoder release];
    [tagDateString release];
    [city release];
    [state release];
    [title release];
    [super dealloc];
}

#pragma mark -
#pragma mark MKReverseGeocoder Delegate Method

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error {
    NSLog(@"We got the following errors: %@",error);
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark {
    [self setCity:[placemark locality]];
    [self setState:[placemark administrativeArea]];
}

@end
