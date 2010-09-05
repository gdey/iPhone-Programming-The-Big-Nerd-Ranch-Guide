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
    possessionsAbove50 = [[NSMutableArray alloc] initWithCapacity:5];
    possessionsBelow50 = [[NSMutableArray alloc] initWithCapacity:5];
    
    for (int i = 0; i < 10; i++) {
        Possession *p = [Possession newRandomPossession];
        if( [p valueInDollars] >= 50 ){
            [possessionsAbove50 addObject:p];
        } else {
            [possessionsBelow50 addObject:p];
        }
        [p release];
    }
    return self;
}

- (id) initWithStyle:(UITableViewStyle)style   {
    return [self init];
}


#pragma mark -
#pragma mark TableViewController DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger) tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger) section {
    
    if (section == 0 ) {
        return [possessionsAbove50 count];
    }
    return [possessionsBelow50 count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if( section == 0 ){
        return @"$50 amd Above";
    }
    return @"Below $50";
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
    Possession *p;
    if( [indexPath section] == 0 ){
        p = [possessionsAbove50 objectAtIndex:[indexPath row]];
    } else {
        p = [possessionsBelow50 objectAtIndex:[indexPath row]];
    }

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
