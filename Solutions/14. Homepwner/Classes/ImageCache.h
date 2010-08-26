//
//  ImageCache.h
//  Homepwner
//
//  Created by Aaron Hillegass on 11/6/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageCache : NSObject {
    NSMutableDictionary *dictionary;
}
+ (ImageCache *)sharedImageCache;
- (void)setImage:(UIImage *)i forKey:(NSString *)s;
- (UIImage *)imageForKey:(NSString *)s;
- (void)deleteImageForKey:(NSString *)s;

@end
