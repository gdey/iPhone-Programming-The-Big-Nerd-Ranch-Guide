//
//  InventoryAppDelegate.h
//  Inventory
//
//  Created by Aaron Hillegass on 10/22/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppController : NSObject <UIApplicationDelegate> {

    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    UIWindow *window;
    
    UINavigationController *navigationController;
}

// Class method for convenience
+ (AppController *)sharedAppController;

- (NSArray *)allInstancesOf:(NSString *)entityName orderedBy:(NSString *)attName;


@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (NSString *)applicationDocumentsDirectory;

@end

