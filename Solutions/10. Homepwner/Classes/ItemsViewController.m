//
//  ItemsViewController.m
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "ItemsViewController.h"
#import "Possession.h"

@implementation ItemsViewController

- (id)init {
	self = [super initWithStyle:UITableViewStyleGrouped];

	// Create an array of 10 random possession objects
	possessions = [[NSMutableArray alloc] init];
	for (int i = 0; i < 10; i++) {
		[possessions addObject:[Possession randomPossession]];
	}
	
	return self;
}
- (id)initWithStyle:(UITableViewStyle)style
{
	return [self init];
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


#pragma mark Table view methods

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [possessions count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	// Check for a reusable cell first, use that if it exists
    UITableViewCell *cell = 
        [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
        
    // If there is no reusable cell of this type, create a new one
    if (!cell) {
        cell = [[[UITableViewCell alloc] 
                    initWithStyle:UITableViewCellStyleDefault 
                  reuseIdentifier:@"UITableViewCell"] autorelease];
    }
    Possession *p = [possessions objectAtIndex:[indexPath row]];
    [[cell textLabel] setText:[p description]];
    return cell;
}


- (void)dealloc {
	[possessions release];
    [super dealloc];
}


@end

