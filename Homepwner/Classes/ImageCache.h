//
//  ImageCache.h
//  Homepwner
//
//  Created by Gautam Dey on 9/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ImageCache : NSObject {
    
    NSMutableDictionary *dictionary;

}

+ (ImageCache *)sharedImageCache;
- (void)setImage:(UIImage *)i forKey:(NSString *)key;
- (UIImage *)imageForKey:(NSString *)key;
- (void)deleteImageForKey:(NSString *)key;

@end
