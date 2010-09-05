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

- (UIView *)headerView {
    if(headerView)
        return headerView;
        // Create a UIButton object, simple rounded rect style
    UIButton *editButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
        // Set the title of this button to "Edit"
    [editButton setTitle:@"Edit" forState:UIControlStateNormal];
    
        // How wide is the screen?
    float w = [[UIScreen mainScreen] bounds].size.width;
    
        // Create a rectangle for the button
    CGRect editButtonFrame = CGRectMake(8.0, 8.0, w - 16.0, 30.0);
    [editButton setFrame:editButtonFrame];
    
    
    [editButton addTarget:self
                   action:@selector(editingButtonPressed:) 
         forControlEvents:UIControlEventTouchUpInside];
    
    CGRect headerViewFrame = CGRectMake(0,0,w,48);
    
    headerView = [[UIView alloc] initWithFrame:headerViewFrame];
    
    [headerView addSubview:editButton];
    
    return headerView;
}


#pragma mark -
#pragma mark TableView Delegeate Methods

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectio {
    return [self headerView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [[self headerView] frame].size.height;
}

#pragma mark -
#pragma mark TableView DataSource Methods

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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
  
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [possessions removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
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
