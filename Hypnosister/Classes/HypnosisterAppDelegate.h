//
//  HypnosisterAppDelegate.h
//  Hypnosister
//
//  Created by Gautam Dey on 8/30/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HypnosisView;

@interface HypnosisterAppDelegate : NSObject <UIApplicationDelegate, UIScrollViewDelegate> {
    UIWindow *window;
    HypnosisView *view;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

