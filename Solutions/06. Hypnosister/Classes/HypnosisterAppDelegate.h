//
//  HypnosisterAppDelegate.h
//  Hypnosister
//
//  Created by Alex Silverman on 7/28/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HypnosisView;

@interface HypnosisterAppDelegate : NSObject <UIApplicationDelegate, UIScrollViewDelegate> {
    UIWindow *window;
	HypnosisView *view;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

