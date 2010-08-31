//
//  MapPoint.m
//  Whereami
//
//  Created by Gautam Dey on 8/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapPoint.h"


@implementation MapPoint

@synthesize title, coordinate;

- (id) initWithCoordinate: (CLLocationCoordinate2D)c andTitle:(NSString *)t {
    
    [super init];
    coordinate = c;
    [self setTitle:t];
    return self;
}

- (void) dealloc {
    [title release];
    [super dealloc];
}

@end
