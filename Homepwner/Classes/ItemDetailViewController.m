//
//  ItemDetailViewController.m
//  Homepwner
//
//  Created by Gautam Dey on 9/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "Possession.h"

@implementation ItemDetailViewController

@synthesize editingPossession;

- (id) init {
    [super initWithNibName:nil bundle:nil];
    
    return self;
    
}


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    return [self init];
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [nameField setText:[editingPossession possessionName]];
    [serialNumberField setText:[editingPossession serialNumber]];
    [valueField setText:[NSString stringWithFormat:@"%d", [editingPossession valueInDollars]]];
    
    
        // Create a NSDateFormatter
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
        // Use filtered NSDate object to set dateLabel contents
    [dateLabel setText:[dateFormatter stringFromDate:[editingPossession dateCreated]]];
    
        // Change the navigation item to display name of possession
    [[self navigationItem] setTitle:[editingPossession possessionName]];
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [nameField resignFirstResponder];
    [serialNumberField resignFirstResponder];
    [valueField resignFirstResponder];
    
        // "Save" changes to the editingPossession
    [editingPossession setPossessionName:[nameField text]];
    [editingPossession setSerialNumber:[serialNumberField text]];
    [editingPossession setValueInDollars:[[valueField text] intValue]];
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
    
    [nameField release];
    nameField = nil;
    
    [serialNumberField release];
    serialNumberField = nil;
    
    [valueField release];
    valueField = nil;
    
    [dateLabel release];
    dateLabel = nil;
}


- (void)dealloc {

    [nameField release];
    [serialNumberField release];
    [valueField release];
    [dateLabel release];
    [super dealloc];
}


@end
