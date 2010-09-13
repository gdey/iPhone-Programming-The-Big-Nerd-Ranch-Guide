//
//  Possession.m
//  RandomPossessions
//
//  Created by bhardy on 7/29/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "Possession.h"
#import "ImageCache.h"
#import <QuartzCore/QuartzCore.h>

@implementation Possession

@synthesize possessionName, serialNumber, valueInDollars, dateCreated, imageKey, accessoryMode;

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

- (void)toggleAccessoryMode {
    [self setAccessoryMode:![self accessoryMode]];
}

- (NSString *)imageThumbKey {
    return [NSString stringWithFormat:@"%@_thumb",[self imageKey]];
}

- (UIImage *) _generateThumbnailFrom:(UIImage *)image {
        // Generate a new thumbnail
    
    float height = [image size].height;
    float width = [image size].width;

    CGRect imageRect = CGRectMake(0,0,70,70);
    if (height > width) {
        imageRect.size.width = 70 * width/height;
    } else {
        imageRect.size.height = 70 * height/width;
    }

    

    UIGraphicsBeginImageContext(imageRect.size);
    [image drawInRect:imageRect];
    UIImage *thumb = UIGraphicsGetImageFromCurrentImageContext();

    
    
    [[ImageCache sharedImageCache] setImage:thumb forKey:[self imageThumbKey]];
    return thumb;
}
- (void) setImage:(UIImage *)image {
    
    if (imageKey) {
        [[ImageCache sharedImageCache] deleteImageForKey:imageKey];
        [[ImageCache sharedImageCache] deleteImageForKey:[self imageThumbKey]];
        [imageKey release];
        imageKey = nil;
    }
    if (!image) {
        return;
    }
        // Create a CFUUID object 
    CFUUIDRef newUniqueID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef newUniqueIDString = CFUUIDCreateString(kCFAllocatorDefault, newUniqueID);
    imageKey = (NSString *)newUniqueIDString;
    [imageKey retain];
    CFRelease(newUniqueID);
    CFRelease(newUniqueIDString);
    
    [[ImageCache sharedImageCache] setImage:image forKey:imageKey];
    [self _generateThumbnailFrom:image];
    
}

- (UIImage *)image {
    return [[ImageCache sharedImageCache] imageForKey:[self imageKey]];
}

- (UIImage *)thumbnail {
    UIImage *thumb = [[ImageCache sharedImageCache] imageForKey:[self imageThumbKey]];
    if (!thumb) {
            // Check to see if full image exists.
        UIImage *image = [[ImageCache sharedImageCache] imageForKey:[self imageKey]];
        if (image) {
            thumb = [self _generateThumbnailFrom:image];
        }
    }
    return thumb;
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
    imageKey = [[aDecoder decodeObjectForKey:@"imageKey"] retain];
    
    dateCreated = [[aDecoder decodeObjectForKey:@"dateCreated"] retain];
    accessoryMode = NO;
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
	accessoryMode = NO;
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
