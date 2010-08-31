//
//  MapPoint.m
//  Whereami
//
//  Created by Gautam Dey on 8/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapPoint.h"


@implementation MapPoint

@synthesize subtitle, title, coordinate;


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
    [self setSubtitle:[dateFomatter stringFromDate:tagDate] ];
        
    [dateFomatter release];
    [tagDate release];
    
    return self;
}


- (void) dealloc {
    [subtitle release];
    [title release];
    [super dealloc];
}

@end
