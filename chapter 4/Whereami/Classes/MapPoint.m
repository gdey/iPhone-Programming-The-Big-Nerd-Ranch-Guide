//
//  MapPoint.m
//  Whereami
//
//  Created by Gautam Dey on 5/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapPoint.h"


@implementation MapPoint

#pragma mark -
#pragma mark synthesize
@synthesize title;
@synthesize coordinate;

- (id)initWithCoordinate:(CLLocationCoordinate2D)c andTitle:(NSString *)title {
    if (self = [super init]) {
        [self setTitle:title];
        coordinate = c;
    }
    return self;
}

#pragma mark -
#pragma mark Memory Management
- (void) dealloc {
    [self setTitle:nil];
    [super dealloc];
}

@end
