//
//  CurrentTimeViewController.m
//  HypnoTime
//
//  Created by Gautam Dey on 9/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CurrentTimeViewController.h"


@implementation CurrentTimeViewController

- (id) init {
        // Call the superclass's designated initializer
    [super initWithNibName:@"CurrentTimeViewController" bundle:nil];
    dateFormatterShort = nil;
    
        // Get the tab bar item
    UITabBarItem *tbi = [self tabBarItem];
        // Get it a label
    [tbi setTitle:@"Time"];

    UIImage *i = [UIImage imageNamed:@"Time.png"];
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


/*
    // Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {

    
    
    [super loadView];
    [[self view] setBackgroundColor:[UIColor redColor]];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (IBAction) showCurrentTime:(id)sender {
    NSDate *now = [NSDate date];
    
    if (!dateFormatterShort){
        dateFormatterShort = [[NSDateFormatter alloc] init];
        [dateFormatterShort setTimeStyle:NSDateFormatterShortStyle];
    }
    [timeLabel setText:[dateFormatterShort stringFromDate:now]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super  viewWillAppear:animated];
    [self showCurrentTime:nil];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    NSLog(@"Must have received a low-memory warning. Releasing timeLabel");
    [timeLabel release];
    timeLabel = nil;
}


- (void)dealloc {
    [dateFormatterShort release];
    [timeLabel release];
    [super dealloc];
}


@end
