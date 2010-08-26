//
//  ShockSquareAppDelegate.h
//  ShockSquare
//
//  Created by Joe Conway on 7/27/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ShockSquareViewController;
@interface ShockSquareAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	ShockSquareViewController *viewController; 

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

