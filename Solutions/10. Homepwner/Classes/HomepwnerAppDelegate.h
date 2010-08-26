//
//  HomepwnerAppDelegate.h
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemsViewController;

@interface HomepwnerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	ItemsViewController *itemsViewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

