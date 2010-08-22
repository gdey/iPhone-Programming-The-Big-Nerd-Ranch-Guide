//
//  HypnosisterAppDelegate.h
//  Hypnosister
//
//  Created by Gautam Dey on 5/15/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HypnosisView;
@interface HypnosisterAppDelegate : NSObject <UIApplicationDelegate, UIScrollViewDelegate> {
    UIWindow *window;
    HypnosisView *view;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet HypnosisView *view;

@end

