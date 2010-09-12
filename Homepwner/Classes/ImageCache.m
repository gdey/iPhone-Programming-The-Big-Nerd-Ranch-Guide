//
//  ImageCache.m
//  Homepwner
//
//  Created by Gautam Dey on 9/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ImageCache.h"

static ImageCache *sharedImageCache;

@implementation ImageCache


- (id)init {
    
    [super init];
    dictionary = [[NSMutableDictionary alloc] init];
    return self;
}

#pragma mark Accessing the cache

- (void)setImage:(UIImage *)i forKey:(NSString *)key {
    [dictionary setObject:i forKey:key];
    
    NSString *imagePath = pathInDocumentDirectory(key);
    
        // Turn image into JPEG data
    NSData *d = UIImageJPEGRepresentation(i, 0.5);
    [d writeToFile:imagePath atomically:YES];
}

- (UIImage *)imageForKey:(NSString *)key {
    if (!key) {
        return nil;
    }
    UIImage *image= [dictionary objectForKey:key];
    if (!image) {
        image = [UIImage imageWithContentsOfFile:pathInDocumentDirectory(key)];
        if (image) {
            [dictionary setObject:image forKey:key];
        }
    }
    return image;
}

-(void)deleteImageForKey:(NSString *)key {
    
    [dictionary removeObjectForKey:key];
    NSString *imagePath = pathInDocumentDirectory(key);
    [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
}


#pragma mark Singleton stuff

+ (ImageCache *)sharedImageCache {
    
    if( !sharedImageCache ){
        sharedImageCache = [[ImageCache alloc] init];
    }
    
    return sharedImageCache;
}

+ (id)allocWithZone:(NSZone *)zone {
    
    if (!sharedImageCache) {
        sharedImageCache = [super allocWithZone:zone];
        return sharedImageCache;
    } else {
        return nil;
    }
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (void)release {
        // no op
}
@end
