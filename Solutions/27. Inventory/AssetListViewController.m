//
//  AssetListViewController.m
//  Inventory
//
//  Created by Aaron Hillegass on 10/22/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "AssetListViewController.h"
#import "AppController.h"
#import "LabelSettingViewController.h"
#import "CountViewController.h"

// All instances of AssetListViewController will share a single
// instance of NSDateFormatter
static NSDateFormatter *dateFormatter;

@implementation AssetListViewController

- (id)init
{
    [super initWithStyle:UITableViewStylePlain];
    
    AppController *ac = [AppController sharedAppController];
    
    // Fetch all the assets
    NSArray *list = [ac allInstancesOf:@"Asset" orderedBy:@"label"];
    assetList = [list mutableCopy];
    
    // Set the navigation items
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                          target:self
                                                                          action:@selector(createNewAsset:)];
    
    [[self navigationItem] setRightBarButtonItem:item];
    [item release];
    
    // Is the dateFormatter nil?
    if (!dateFormatter) {
        
        // Create a date formatter
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    }
    
    return self;
}


- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}


- (void)dealloc 
{
    [location release];
    [assetList release];
    [super dealloc];
}


- (NSManagedObject *)inventoryForAsset:(NSManagedObject *)asset
{
    NSArray *inventoriesForLocation = [location valueForKey:@"inventories"];
    for (NSManagedObject *mo in inventoriesForLocation) {
        if ([mo valueForKey:@"asset"] == asset) {
            return mo;
        }
    }
    return nil;
}

- (void)setLocation:(NSManagedObject *)loc
{
    [loc retain];
    [location release];
    location = loc;
    
    [self setTitle:[location valueForKey:@"label"]];
}

#pragma mark Action methods

- (void)createNewAsset:(id)sender
{
    labelSettingViewController = [[LabelSettingViewController alloc] init];
    [[self navigationController] pushViewController:labelSettingViewController animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    // Am I coming back from the LabelSettingViewController?
    if (labelSettingViewController) {
        NSString *value = [labelSettingViewController value];
        if ([value length] > 0) {
            
            AppController *ac = [AppController sharedAppController];
            NSManagedObjectContext *moc = [ac managedObjectContext];
            
            NSManagedObject *newAsset = [NSEntityDescription insertNewObjectForEntityForName:@"Asset"
                                                                      inManagedObjectContext:moc];
            [newAsset setValue:value forKey:@"label"];
            [assetList addObject:newAsset];
            
            NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:@"label"
                                                               ascending:YES];
            NSArray *sds = [NSArray arrayWithObject:sd];
            [sd release];
            [assetList sortUsingDescriptors:sds];
            [[self tableView] reloadData];
        }
        [labelSettingViewController release];
        labelSettingViewController = nil;
    }
    
    // Am I coming back from the CountViewController?
    if (countViewController) {
        NSNumber *count = [countViewController count];
        if (count) {
            NSManagedObject *asset = [countViewController asset];
            NSManagedObject *inventory = [self inventoryForAsset:asset];
            
            if (!inventory) {
                AppController *ac = [AppController sharedAppController];
                NSManagedObjectContext *moc = [ac managedObjectContext];
                
                inventory = [NSEntityDescription insertNewObjectForEntityForName:@"Inventory"
                                                          inManagedObjectContext:moc];
                [[asset mutableSetValueForKey:@"inventories"] addObject:inventory];
                [[location mutableSetValueForKey:@"inventories"] addObject:inventory];
            }
            [inventory setValue:count forKey:@"count"];
            NSDate *now = [NSDate date];
            [inventory setValue:now forKey:@"date"];
            
            [[self tableView] reloadData];
        }
        [countViewController release];
        countViewController = nil;
    }
    NSIndexPath *selectedPath = [[self tableView] indexPathForSelectedRow];
    if (selectedPath) {
        [[self tableView] deselectRowAtIndexPath:selectedPath animated:NO];
    }
}

#pragma mark Table view methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)ip 
{
    countViewController = [[CountViewController alloc] init];
    [countViewController setLocation:location];
    NSManagedObject *asset = [assetList objectAtIndex:[ip row]];
    [countViewController setAsset:asset];
    
    [[self navigationController] pushViewController:countViewController animated:YES];
    // Will release countViewController in viewWillAppear: when it is popped
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
    return [assetList count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)ip
{
    
    static NSString *CellIdentifier = @"InventoryCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
        [cell autorelease];
    }
    
    NSManagedObject *asset = [assetList objectAtIndex:[ip row]];
	
    NSManagedObject *inventory = [self inventoryForAsset:asset];
    
    NSString *assetName = [asset valueForKey:@"label"];
    
    if (inventory) {
        NSDate *date = [inventory valueForKey:@"date"];
        NSString *inventorySummary = [NSString stringWithFormat:@"%@ %@ - %@",
                                      [inventory valueForKey:@"count"],
                                      assetName,
                                      [dateFormatter stringFromDate:date]];
        [[cell textLabel] setText:inventorySummary];
    } else {
        [[cell textLabel] setText:assetName];
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}



@end
