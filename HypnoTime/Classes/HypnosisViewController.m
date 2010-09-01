    //
//  HypnosisViewController.m
//  HypnoTime
//
//  Created by Gautam Dey on 9/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HypnosisViewController.h"


@implementation HypnosisViewController



- (id) init {
        // Call the superclass's designated initializer
    [super initWithNibName:nil bundle:nil];
    
        // Get the tab bar item
    UITabBarItem *tbi = [self tabBarItem];
        // Get it a label
    [tbi setTitle:@"Hypnosis"];
    
    UIImage *i = [UIImage imageNamed:@"Hypno.png"];
    [tbi setImage:i];

    
    return self;
}

    // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    /*    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
     // Custom initialization
     }
     return self;
     */
    return [self init];
}


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {


    [super loadView];
    [[self view] setBackgroundColor:[UIColor orangeColor]];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

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
}


- (void)dealloc {
    [super dealloc];
}


@end
