//
//  Line.m
//  TouchTracker
//
//  Created by Gautam Dey on 9/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Line.h"


@implementation Line
@synthesize begin, end;


- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeCGPoint:begin forKey:@"begin"];
    [aCoder encodeCGPoint:end forKey:@"end"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    [super init];
    begin = [aDecoder decodeCGPointForKey:@"begin"];
    end = [aDecoder decodeCGPointForKey:@"end"];
    return self;
}

@end
