    //
    //  Possession.m
    //  RandomPossessions
    //
    //  Created by Gautam Dey on 5/13/10.
    //  Copyright 2010 __MyCompanyName__. All rights reserved.
    //

#import "Possession.h"


@implementation Possession

#pragma mark -
#pragma mark synthesize
@synthesize possessionName;
@synthesize serialNumber;
@synthesize valueInDollars;
@synthesize dateCreated;

+ (id) randomPossession {
    
    static NSString *randomAdjectiveList[4] = {
        @"Fluffy",
        @"Rusty",
        @"Shiny",
        @"Golden"
    };
    static NSString *randomNounList[4] =  {
        @"Bear",
        @"Spork",
        @"Mac",
        @"iPhone"
    };
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@",
                            randomAdjectiveList[ random() % 4 ],
                            randomNounList[ random() % 4 ]];
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c", 
                                    '0' + random() % 10,
                                    'A' + random() % 26,
                                    '0' + random() % 10,
                                    'A' + random() % 26,
                                    '0' + random() % 10];


    return [[[self alloc] initWithPossessionName:randomName 
                                  valueInDollars:[NSNumber numberWithInt:(random() % 100)] 
                                 andSerialNumber:randomSerialNumber] 
            autorelease];
}

- (id) init {
    
    return [self initWithPossessionName:@"New Possession" ];
}

- (id) initWithPossessionName:(NSString *)name {
    return [self initWithPossessionName:name valueInDollars:[NSNumber numberWithInt:0] andSerialNumber:@""];
} 

- (id) initWithPossessionName:(NSString *)name
               valueInDollars:(NSNumber *)value
              andSerialNumber:(NSString *) snumber {
    
    if (self = [super init]) {
        [self setPossessionName:name];
        [self setSerialNumber:snumber];
        [self setValueInDollars:value];
        dateCreated = [[NSDate alloc] init];
    }
    return self;
    
}

- (NSString *) description {
    return [NSString stringWithFormat:@"%@ (%@): Worth $%d, Recored on %@",
            possessionName,
            serialNumber,
            [valueInDollars integerValue],
            dateCreated];
}

- (void) dealloc {
    
    [self setPossessionName:nil];
    [self setSerialNumber:nil];
    [self setValueInDollars:nil];
    [dateCreated release];
    dateCreated = nil;
    [super dealloc];
}

@end
