    //
//  ItemsViewController.m
//  Homepwner
//
//  Created by Gautam Dey on 9/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ItemsViewController.h"
#import "ItemDetailViewController.h"
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
    
    [[self navigationItem] setTitle:@"Homepwner"];
    [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];
    
    return self;
}

- (id) initWithStyle:(UITableViewStyle)style   {
    return [self init];
}




- (void) setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[possessions count] inSection:0];
    
    if( editing ){
        
        [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                withRowAnimation:UITableViewRowAnimationLeft];
    } else {
        
        [[self tableView] deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                                withRowAnimation:UITableViewRowAnimationFade];
    }

}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

#pragma mark -
#pragma mark TableView Delegeate Methods



- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self isEditing] && [indexPath row] == [possessions count]) {
        return UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleDelete;
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    if ([proposedDestinationIndexPath row] < [possessions count]) {
        return proposedDestinationIndexPath;
    }
    return [NSIndexPath indexPathForRow:[possessions count] - 1 inSection:0];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!detailViewController) {
        detailViewController = [[ItemDetailViewController alloc] init];
    }
    
    [detailViewController setEditingPossession:[possessions objectAtIndex:[indexPath row]]];
    
    [[self navigationController] pushViewController:detailViewController animated:YES];
}

#pragma mark -
#pragma mark TableView DataSource Methods

- (NSInteger) tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger) section {
    if ([self isEditing]) {
        return [possessions count] + 1;
    }
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
    if ([indexPath row] < [possessions count]) {
        
        Possession *p = (Possession *)[possessions objectAtIndex:[indexPath row]];
        [[cell textLabel] setText: [p description]];
    } else {
        [[cell textLabel] setText:@"Add New Item"];
    }

    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [possessions removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    Possession *p = [[possessions objectAtIndex:[fromIndexPath row]] retain];
    
    [possessions removeObjectAtIndex:[fromIndexPath row]];
    [possessions insertObject:p atIndex:[toIndexPath row]];
    
    [p release];
    
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] < [possessions count]) {
        return YES;
    }
    return NO;
}

#pragma mark -
#pragma mark Actions Methods
- (void) editingButtonPressed:(id)sender {
        // If we are currently in editing mode..
    if([self isEditing]){
            // Change the text to edit
        [sender setTitle:@"Edit" forState:UIControlStateNormal];
            // Turn off editing Mode
        [self setEditing:NO animated:YES];
    } else {
        [sender setTitle:@"Done" forState:UIControlStateNormal];
        [self setEditing:YES animated:YES];
    }

}

#pragma mark -
#pragma mark Memory Management Methods

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
    [headerView release];
    [super dealloc];
}


@end
