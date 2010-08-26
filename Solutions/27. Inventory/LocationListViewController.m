//
//  LocationListViewController.m
//  Inventory
//
//  Created by Aaron Hillegass on 10/22/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "LocationListViewController.h"
#import "AppController.h"
#import "LabelSettingViewController.h"
#import "AssetListViewController.h"

@implementation LocationListViewController


- (id)init
{
    [super initWithStyle:UITableViewStylePlain];
    
    // Fetch the location list
    AppController *ac = [AppController sharedAppController];
    NSArray *list = [ac allInstancesOf:@"Location" orderedBy:@"label"];
    locationList = [list mutableCopy];
    
    [self setTitle:@"Locations"];
    
    // Create the Add navigation item
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                          target:self
                                                                          action:@selector(createNewLocation:)];
    [[self navigationItem] setRightBarButtonItem:item];
    [item release];
    
    return self;
}

// Override the superclass's designated initializer
- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)dealloc
{
    [locationList release];
    [super dealloc];
}


#pragma mark Action methods

- (void)createNewLocation:(id)sender
{
    labelSettingViewController = [[LabelSettingViewController alloc] init];
    [[self navigationController] pushViewController:labelSettingViewController animated:YES];
}

#pragma View Controller Lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    // Am I coming back from the LabelSettingViewController?
    if (labelSettingViewController) {
        NSString *value = [labelSettingViewController value];
        
        // Did the user give a value for the label?
        if ([value length] > 0) {
            
            AppController *ac = [AppController sharedAppController];
            NSManagedObjectContext *moc = [ac managedObjectContext];
            
            // Create a new object and insert it into the managed object context
            NSManagedObject *newLoc = [NSEntityDescription insertNewObjectForEntityForName:@"Location"
                                                                    inManagedObjectContext:moc];
            [newLoc setValue:value forKey:@"label"];
            [locationList addObject:newLoc];
            
            // Resort the array
            NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:@"label"
                                                               ascending:YES];
            NSArray *sds = [NSArray arrayWithObject:sd];
            [sd release];
            [locationList sortUsingDescriptors:sds];
            
            // Redisplay the table view
            [[self tableView] reloadData];
        }
        [labelSettingViewController release];
        labelSettingViewController = nil;
    }
    
    // Clear the selection
    NSIndexPath *selectedPath = [[self tableView] indexPathForSelectedRow];
    if (selectedPath) {
        [[self tableView] deselectRowAtIndexPath:selectedPath animated:NO];
    }
}


#pragma mark Table view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return [locationList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)ip
{
    
    static NSString *CellIdentifier = @"LocationCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                      reuseIdentifier:CellIdentifier];
        [cell autorelease];
    }
    
    NSManagedObject *location = [locationList objectAtIndex:[ip row]];
    [[cell textLabel] setText:[location valueForKey:@"label"]];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)ip 
{
    AssetListViewController *anotherViewController = [[AssetListViewController alloc] init];
    [anotherViewController setLocation:[locationList objectAtIndex:[ip row]]];
    [[self navigationController] pushViewController:anotherViewController animated:YES];
    [anotherViewController release];
}

@end

