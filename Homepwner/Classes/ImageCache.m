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
}

- (UIImage *)imageForKey:(NSString *)key {
    return [dictionary objectForKey:key];
}

-(void)deleteImageForKey:(NSString *)key {
    [dictionary removeObjectForKey:key];
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
