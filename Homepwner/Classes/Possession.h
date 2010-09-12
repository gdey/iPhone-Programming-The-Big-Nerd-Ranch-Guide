//
//  Possession.h
//  RandomPossessions
//
//  Created by bhardy on 7/29/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Possession : NSObject <NSCoding>
{
	NSString *possessionName;
	NSString *serialNumber;
	int valueInDollars;
	NSDate *dateCreated;
	NSString *imageKey;
	
}
@property (nonatomic, copy) NSString *possessionName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, readonly) NSDate *dateCreated;
@property (nonatomic, copy) NSString *imageKey;

+ (id)newRandomPossession;

- (id)initWithPossessionName:(NSString *)name 
			  valueInDollars:(int)value
				serialNumber:(NSString *)sNumber;

- (id)initWithPossessionName:(NSString *)name;
@end
