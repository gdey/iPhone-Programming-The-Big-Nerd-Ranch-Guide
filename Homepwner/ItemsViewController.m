    //
//  ItemsViewController.m
//  Homepwner
//
//  Created by Gautam Dey on 9/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ItemsViewController.h"
#import "Possession.h"

@implementation ItemsViewController


- (id) init {
    
        // Call the suersclasses's designated initializer
    [super initWithStyle:UITableViewStyleGrouped];
    
        // Create an array of 10 random possession objects
    possessions = [[NSMutableArray alloc] initWithCapacity:10];
    
    for (int i = 0; i < 10; i++) {
        [possessions addObject:[Possession newRandomPossession]];
    }
    return self;
}

- (id) initWithStyle:(UITableViewStyle)style   {
    return [self init];
}


#pragma mark -
#pragma mark TableViewController DataSource Methods

- (NSInteger) tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger) section {
    return [possessions count];
}
                         
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Create an instance of UITableViewCell, with default apperance
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if(!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:@"UITableViewCell"] autorelease];
    }
    
        // Set the text on the cell with the description of the possession
        // that is at the nth index of the possessions, where n = row this cell
        // will appear in on the tableView
    Possession *p = (Possession *)[possessions objectAtIndex:[indexPath row]];
    [[cell textLabel] setText: [p description]];
    return cell;
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
}


- (void)dealloc {
    [super dealloc];
}


@end
