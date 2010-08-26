//
//  HeavyViewController.m
//  HeavyRotation
//
//  Created by Alex Silverman on 7/28/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "HeavyViewController.h"


@implementation HeavyViewController

- (id)init
{
	[super initWithNibName:@"HeavyViewController" bundle:nil];
	return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	return [self init];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)x {
    return (x == UIInterfaceOrientationPortrait) || UIInterfaceOrientationIsLandscape(x);
}
- (void)viewDidLoad
{
	[[self view] setFrame:[[UIScreen mainScreen] applicationFrame]];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
