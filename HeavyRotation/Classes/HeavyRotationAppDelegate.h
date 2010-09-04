//
//  HeavyRotationAppDelegate.h
//  HeavyRotation
//
//  Created by Gautam Dey on 9/3/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HeavyViewController;

@interface HeavyRotationAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    HeavyViewController *hv;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

