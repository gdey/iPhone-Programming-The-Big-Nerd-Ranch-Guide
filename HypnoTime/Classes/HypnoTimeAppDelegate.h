//
//  HypnoTimeAppDelegate.h
//  HypnoTime
//
//  Created by Gautam Dey on 9/1/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HypnoTimeAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UITabBarController *tabBarController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

