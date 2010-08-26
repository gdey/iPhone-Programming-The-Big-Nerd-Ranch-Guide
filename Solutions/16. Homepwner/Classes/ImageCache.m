//
//  ImageCache.m
//  Homepwner
//
//  Created by Aaron Hillegass on 11/6/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "ImageCache.h"
#import "FileHelpers.h"

static ImageCache *sharedImageCache;

@implementation ImageCache

- (id)init
{
    [super init];
    dictionary = [[NSMutableDictionary alloc] init];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(clearCache:)
                                                 name:UIApplicationDidReceiveMemoryWarningNotification
                                               object:nil];
    
    return self;
}

- (void)clearCache:(NSNotification *)note
{
    NSLog(@"flushing %d images out of the cache", [dictionary count]);
    [dictionary removeAllObjects];
}

#pragma mark Accessing the cache

- (void)setImage:(UIImage *)i forKey:(NSString *)s
{
    // Put it in the dictionary
    [dictionary setObject:i forKey:s];
    
    // Create full path for image
	NSString *imagePath = pathInDocumentDirectory(s);
	    
    // Turn image into JPEG data,
	NSData *d = UIImageJPEGRepresentation(i, 1.0);
	
	// Write it to full path
	[d writeToFile:imagePath atomically:YES];
}

- (UIImage *)imageForKey:(NSString *)s
{
    // If possible, get it from the dictionary
    UIImage *result = [dictionary objectForKey:s];
    
    if (!result) {
        // Create UIImage object from file
        result = [UIImage imageWithContentsOfFile:pathInDocumentDirectory(s)];
        
        // If we found an image on the file system, place it in to the cache
        if (result)
            [dictionary setObject:result forKey:s];
        else 
            NSLog(@"Error: unable to find %@", pathInDocumentDirectory(s));
    }
    
    return result;
}

- (void)deleteImageForKey:(NSString *)s
{
    [dictionary removeObjectForKey:s];
    NSString *path = pathInDocumentDirectory(s);
    [[NSFileManager defaultManager] removeItemAtPath:path
                                               error:NULL];
}


#pragma mark Singleton stuff

+ (ImageCache *)sharedImageCache
{
    if (!sharedImageCache) {
        sharedImageCache = [[ImageCache alloc] init];
	}
    return sharedImageCache;
}

+ (id)allocWithZone:(NSZone *)zone
{
    if (!sharedImageCache) {
        sharedImageCache = [super allocWithZone:zone];
        return sharedImageCache;
    } else {
        return nil;
    }
}

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}

- (void)release
{
    // No op
}

@end
