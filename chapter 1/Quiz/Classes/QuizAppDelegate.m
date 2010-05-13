//
//  QuizAppDelegate.m
//  Quiz
//
//  Created by Gautam Dey on 5/12/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "QuizAppDelegate.h"

@implementation QuizAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
