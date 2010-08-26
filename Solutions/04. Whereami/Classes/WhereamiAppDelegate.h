//
//  WhereamiAppDelegate.h
//  Whereami
//
//  Created by Joe Conway on 8/10/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface WhereamiAppDelegate : NSObject 
	<UIApplicationDelegate, CLLocationManagerDelegate> 
{
    UIWindow *window;
	CLLocationManager *locationManager;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

