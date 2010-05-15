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

#pragma mark -
#pragma mark methods

- (NSString *)subtitle {
    return [NSString stringWithFormat:@"Tagged: %@",_tagDateString];
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)c andTitle:(NSString *)newTitle {
    if (self = [super init]) {
        [self setTitle:newTitle];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterLongStyle];
        NSDate *now = [[NSDate alloc] init];
        _tagDateString = [[formatter stringFromDate:now] retain];
        [now release];
        [formatter release];
        coordinate = c;
    }
    return self;
}


#pragma mark -
#pragma mark Memory Management
- (void) dealloc {
    [self setTitle:nil];
    [_tagDateString release];
    [super dealloc];
}

@end
