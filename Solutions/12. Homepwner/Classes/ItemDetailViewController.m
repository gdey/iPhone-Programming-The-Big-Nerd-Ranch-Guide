//
//  ItemDetailViewController.m
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "Possession.h"

@implementation ItemDetailViewController
@synthesize editingPossession;
- (id)init
{
	return [super initWithNibName:@"ItemDetailViewController" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
	return [self init];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]]; 
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	
	// Use properties of incoming possession to change user interface
	[nameField setText:[editingPossession possessionName]];
	[serialNumberField setText:[editingPossession serialNumber]];
	[valueField setText:[NSString stringWithFormat:@"%d", 
											 [editingPossession valueInDollars]]];
	
	// Create a NSDateFormatter... we filter NSDate objects through this formatted
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] 
											autorelease];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	
	// Use filtered NSDate object to return string to set dateLabel contents
	[dateLabel setText:
		[dateFormatter stringFromDate:[editingPossession dateCreated]]];
	// Change the nav item to display name of possession
	[[self navigationItem] setTitle:[editingPossession possessionName]];
}
- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];	
    
    [nameField resignFirstResponder];
    [serialNumberField resignFirstResponder];
    [valueField resignFirstResponder];
    
	// "Save" changes to editingPossession
	[editingPossession setPossessionName:[nameField text]];
	[editingPossession setSerialNumber:[serialNumberField text]];
	[editingPossession setValueInDollars:[[valueField text] intValue]];	
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
	
	[nameField release];
	nameField = nil;

	[serialNumberField release];
	serialNumberField = nil;

	[valueField release];
	valueField = nil;

	[dateLabel release];
	dateLabel = nil;
}


- (void)dealloc 
{
	[nameField release];
	[serialNumberField release];
	[valueField release];
	[dateLabel release];
    [super dealloc];
}


@end
