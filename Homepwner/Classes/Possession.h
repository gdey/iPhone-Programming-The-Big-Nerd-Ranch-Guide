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
    BOOL accessoryMode;
	
}
@property (nonatomic, copy) NSString *possessionName;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic) BOOL accessoryMode;
@property (nonatomic, readonly) NSDate *dateCreated;
@property (nonatomic, readonly) NSString *imageKey;

+ (id)newRandomPossession;

- (id)initWithPossessionName:(NSString *)name 
			  valueInDollars:(int)value
				serialNumber:(NSString *)sNumber;

- (id)initWithPossessionName:(NSString *)name;
- (UIImage *)image;
- (void)setImage:(UIImage *)image;
- (UIImage *)thumbnail;
- (void) toggleAccessoryMode;
@end
