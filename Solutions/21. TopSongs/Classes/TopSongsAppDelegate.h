//
//  TopSongsAppDelegate.h
//  TopSongs
//
//  Created by Joe Conway on 1/25/10.
//  Copyright Big Nerd Ranch 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopSongsAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

