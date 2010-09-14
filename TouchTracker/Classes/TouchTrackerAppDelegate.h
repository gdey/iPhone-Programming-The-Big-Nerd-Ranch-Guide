//
//  TouchTrackerAppDelegate.h
//  TouchTracker
//
//  Created by Gautam Dey on 9/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TouchDrawView;

@interface TouchTrackerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    IBOutlet TouchDrawView *touchView;
    IBOutlet UISegmentedControl  *drawingType;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

-(IBAction) selectionChanged:(id)sender;


@end

