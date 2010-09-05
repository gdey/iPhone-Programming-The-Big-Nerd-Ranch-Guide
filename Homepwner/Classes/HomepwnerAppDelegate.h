//
//  HomepwnerAppDelegate.h
//  Homepwner
//
//  Created by Gautam Dey on 9/4/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemsViewController;
@interface HomepwnerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ItemsViewController *itemsViewController;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

