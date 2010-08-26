//
//  InventoryAppDelegate.m
//  Inventory
//
//  Created by Aaron Hillegass on 10/22/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import "AppController.h"
#import "LocationListViewController.h"

#import "LocationListViewController.h"

static AppController *sharedInstance;

@implementation AppController


@synthesize window;

- (id)init
{
    if (sharedInstance) {
        NSLog(@"Error: You are creating a second AppController");
    }
    
    [super init];
    sharedInstance = self;
    
    Class privateClass;
    privateClass = NSClassFromString(@"NSSQLCore");
    // You will get a compiler warning here, ignore it
    [privateClass setDebugDefault:YES];
    return self;
}

+ (AppController *)sharedAppController
{
    return sharedInstance;
}

- (NSArray *)allInstancesOf:(NSString *)entityName orderedBy:(NSString *)attName
{
    NSManagedObjectContext *moc = [[AppController sharedAppController] managedObjectContext];
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName
                                              inManagedObjectContext:moc];
    [fetch setEntity:entity];
    
    if (attName) {
        NSSortDescriptor *sd = [[NSSortDescriptor alloc] initWithKey:attName
                                                           ascending:YES];
        
        NSArray *sortDescriptors = [NSArray arrayWithObject:sd];
        [sd release];
        
        [fetch setSortDescriptors:sortDescriptors];
    }
    
    NSError *error;
    NSArray *result = [moc executeFetchRequest:fetch
                                         error:&error];
    [fetch release];
    
    if (!result) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Fetch Failed"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView autorelease];
        [alertView show];
        return nil;
    }
    return result;
}
#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    LocationListViewController *rvc = [[LocationListViewController alloc] init];
    
    navigationController = [[UINavigationController alloc] initWithRootViewController:rvc];
    [rvc release];
    
    [window addSubview:[navigationController view]];
	[window makeKeyAndVisible];
    
	[window makeKeyAndVisible];
}

/**
 applicationWillTerminate: saves changes in the application's managed object context before the application terminates.
 */
- (void)applicationWillTerminate:(UIApplication *)application {
	
    NSError *error = nil;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
			/*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
			NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
			abort();
        } 
    }
}


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
	
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
	
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
	
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    managedObjectModel = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];    
    return managedObjectModel;
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
	
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
	
    NSURL *storeUrl = [NSURL fileURLWithPath: [[self applicationDocumentsDirectory] stringByAppendingPathComponent: @"Inventory.sqlite"]];
	
	NSError *error = nil;
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error:&error]) {
		/*
		 Replace this implementation with code to handle the error appropriately.
		 
		 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
		 
		 Typical reasons for an error here include:
		 * The persistent store is not accessible
		 * The schema for the persistent store is incompatible with current managed object model
		 Check the error message to determine what the actual problem was.
		 */
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		abort();
    }    
	
    return persistentStoreCoordinator;
}


#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the path to the application's Documents directory.
 */
- (NSString *)applicationDocumentsDirectory {
	return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	
    [managedObjectContext release];
    [managedObjectModel release];
    [persistentStoreCoordinator release];
    
	[window release];
	[super dealloc];
}


@end

