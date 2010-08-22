//
//  HypnosisterAppDelegate.m
//  Hypnosister
//
//  Created by Gautam Dey on 5/15/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "HypnosisterAppDelegate.h"
#import "HypnosisView.h"

@implementation HypnosisterAppDelegate

#pragma mark -
#pragma mark synthesize
@synthesize window;
@synthesize view;


#pragma mark -
#pragma mark Application Delegate Methods 
- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    CGRect wholeWindow = [[self window] bounds];
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:wholeWindow];
    [[self window] addSubview:scrollView];
    
    CGRect bigRectView;
    bigRectView.origin = CGPointZero;
    bigRectView.size.width = wholeWindow.size.width * 3.0;
    bigRectView.size.height = wholeWindow.size.height * 3.0;
    [scrollView setContentSize:bigRectView.size];
    
    [scrollView setMaximumZoomScale:5];
    [scrollView setMinimumZoomScale:0.5];
    [scrollView setDelegate:self];
    
    CGPoint offset;
    offset.x = wholeWindow.size.width * 0.5;
    offset.y = wholeWindow.size.height * 0.5;
    [scrollView setContentOffset:offset];
    
    [self setView:[[HypnosisView alloc] initWithFrame:bigRectView]];
    [[self view] setBackgroundColor:[UIColor clearColor]];
    [scrollView addSubview:[self view]];
    [scrollView release];
    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [self view];
}

#pragma mark -
#pragma mark Memory Management Methods
- (void)dealloc {
    [self setView:nil];
    [self setWindow:nil];
    [super dealloc];
}


@end
