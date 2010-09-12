//
//  Possession.m
//  RandomPossessions
//
//  Created by bhardy on 7/29/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "Possession.h"


@implementation Possession

@synthesize possessionName, serialNumber, valueInDollars, dateCreated, imageKey;

+ (id)newRandomPossession 
{
	NSArray *randomAdjectiveList = [NSArray arrayWithObjects:@"Fluffy",
														  @"Rusty",
														  @"Shiny", nil];
	NSArray *randomNounList = [NSArray arrayWithObjects:@"Bear",
														@"Spork",
														@"Mac", nil];
	
	int adjectiveIndex = random() % [randomAdjectiveList count];
	int nounIndex = random() % [randomNounList count];
	NSString *randomName = [NSString stringWithFormat:@"%@ %@",
								[randomAdjectiveList objectAtIndex:adjectiveIndex],
								[randomNounList objectAtIndex:nounIndex]];
	int randomValue = random() % 100;
	NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c", 
													'0' + random() % 10,
													'A' + random() % 26,
													'0' + random() % 10,
													'A' + random() % 26,
													'0' + random() % 10];
	Possession *newPossession = 
		[[self alloc] initWithPossessionName:randomName
							  valueInDollars:randomValue
								serialNumber:randomSerialNumber];
	return newPossession;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
        // For each instance variable, archive it under its variable name
    [aCoder encodeObject:possessionName forKey:@"possessionName"];
    [aCoder encodeObject:serialNumber forKey:@"serialNumber"];
    [aCoder encodeInt:valueInDollars forKey:@"valueInDollars"];
    [aCoder encodeObject:dateCreated forKey:@"dateCreated"];
    [aCoder encodeObject:imageKey forKey:@"imageKey"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    [super init];
    
    [self setPossessionName:[aDecoder decodeObjectForKey:@"possessionName"]];
    [self setSerialNumber:[aDecoder decodeObjectForKey:@"serialNumber"]];
    [self setValueInDollars:[aDecoder decodeIntForKey:@"vlueInDollars"]];
    [self setImageKey:[aDecoder decodeObjectForKey:@"imageKey"]];
    
    dateCreated = [[aDecoder decodeObjectForKey:@"dateCreated"] retain];
    
    return self;
}

- (id)initWithPossessionName:(NSString *)name 
							valueInDollars:(int)value
								serialNumber:(NSString *)sNumber
{
	// Call the superclass's designated initializer 
	self = [super init];
	
	// Did the superclass's initialization fail? 
	if (!self)
		return nil;
	
	// Give the instance variables initial values 
	[self setPossessionName:name]; 
	[self setSerialNumber:sNumber]; 
	[self setValueInDollars:value];
	dateCreated = [[NSDate alloc] init];
	
	// Return the address of the newly initialized object
	return self;
}

- (id)initWithPossessionName:(NSString *)name {
	return [self initWithPossessionName:name 
						 valueInDollars:0
						   serialNumber:@""];
}
- (id)init
{
    return [self initWithPossessionName:@"Possession"
                         valueInDollars:0
                           serialNumber:@""];
}
- (NSString *)description {
	NSString *descriptionString = [[[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, Recorded on %@",
																 possessionName, serialNumber, valueInDollars, dateCreated] autorelease];
	return descriptionString;
}

- (void) dealloc {
	[imageKey release];
	[possessionName release];
	[serialNumber release];
	[dateCreated release];
	[super dealloc];
}

@end
