//
//  Possession.h
//  RandomPossessions
//
//  Created by Gautam Dey on 5/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Possession : NSObject {

    NSString *possessionName;
    NSString *serialNumber;
    NSNumber *valueInDollars;
    NSDate   *dateCreated;
}

@property (copy) NSString *possessionName;
@property (copy) NSString *serialNumber;
@property (copy) NSNumber *valueInDollars;
@property (retain, readonly) NSDate   *dateCreated;

@end
