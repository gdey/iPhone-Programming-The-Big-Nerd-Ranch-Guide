//
//  MapViewController.m
//  HypnoTime
//
//  Created by Gautam Dey on 9/2/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"


@implementation MapViewController

- (id) init {
    
    
    NSLog(@"In init");
    
    [super initWithNibName:@"MapViewController" bundle:nil];

    NSLog(@"after init");
        // Get the tab bar item
    UITabBarItem *tbi = [self tabBarItem];
        // Get it a label
    [tbi setTitle:@"Map view"];
    
    UIImage *i = [UIImage imageNamed:@"Icon.png"];
    [tbi setImage:i];
    
    return self;
}

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    return [self init];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"In the viewWillAppear");
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"In viewDidLoad");
    [mapView setShowsUserLocation:YES];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    //[mapView release];
    // mapView  = nil;
}


- (void)dealloc {
        //[mapView release];
    [super dealloc];
}


@end
