//
//  NayshunzAppDelegate.m
//  Nayshunz
//
//  Created by Joe Conway on 7/30/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import "NayshunzAppDelegate.h"

@implementation NayshunzAppDelegate

@synthesize window;
- (id)init 
{ 
    [super init]; 
    
    // Create the root of the tree 
    continents = [[NSMutableArray alloc] init]; 
	
	// Where do the documents go?
    NSArray *paths = 
        NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                            NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];

    
    // What would be the name of my database file? 
    NSString *fullPath = [path stringByAppendingPathComponent:@"countries.db"]; 
    
    // Get a file manager for file operations 
    NSFileManager *fm = [NSFileManager defaultManager]; 
    
    // Does the file already exist? 
    BOOL exists = [fm fileExistsAtPath:fullPath]; 
    
    // Does it already exist? 
    if (exists) { 
        NSLog(@"%@ exists -- just opening", fullPath); 
    } else { 
        NSLog(@"%@ does not exist -- copying and opening", fullPath); 
        
        // Where is the starting database in the app wrapper? 
        NSString *pathForStartingDB = [[NSBundle mainBundle] pathForResource:@"countries" 
                                                                      ofType:@"db"]; 
        
        // Copy it to the documents directory 
        BOOL success = [fm copyItemAtPath:pathForStartingDB 
                                   toPath:fullPath 
                                    error:NULL]; 
        if (!success) { 
            NSLog(@"database copy failed"); 
        } 
    } 
    
    // Open the database file
    const char *cFullPath = [fullPath cStringUsingEncoding:NSUTF8StringEncoding];
    if (sqlite3_open(cFullPath, &database) 
     != SQLITE_OK) {
        NSLog(@"unable to open database at %@", fullPath);
    }
    return self; 
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText 
{ 
    // Clear the data structures 
    [continents removeAllObjects]; 
    
    if ([searchText length] != 0) { 
        
        if (!statement) { 
            
            char *cQuery = "SELECT Continent, Name, Code FROM Country " 
                            "WHERE Name LIKE ? ORDER BY Continent, Name"; 
            
            if (sqlite3_prepare_v2(database,cQuery, -1, &statement, NULL) != SQLITE_OK) { 
                NSLog(@"query error: %s", statement); 
            }            
        } 
        
        searchText = [searchText stringByAppendingString:@"%"]; 
                
        const char *cSearchText = [searchText cStringUsingEncoding:NSUTF8StringEncoding]; 
        
        sqlite3_bind_text(statement, 1, cSearchText, -1, SQLITE_TRANSIENT); 
        
        NSString *lastContinentName = nil; 
        NSMutableArray *currentNationList; 
        
        while (sqlite3_step(statement) == SQLITE_ROW) { 
            
            const char *cContinentName = (const char *)sqlite3_column_text(statement, 0); 
            NSString *continentName = [[NSString alloc] initWithUTF8String:cContinentName]; 
            [continentName autorelease]; 
            
            // Is this a new continent? 
            if (!lastContinentName || ![lastContinentName isEqual:continentName]) { 
                // Create an array for the nations of this new continent 
                currentNationList = [[NSMutableArray alloc] init]; 
                
                // Put the name and the array in a dictionary 
                NSDictionary *continentalDict = [[NSDictionary alloc] initWithObjectsAndKeys: 
                                   continentName, @"name", currentNationList, @"list", nil]; 
                
                // Release array retained by the dictionary 
                [currentNationList release]; 
                
                // Add the new continent to the array of continents 
                [continents addObject:continentalDict]; 
                
                // Release the dictionary being retained by the array 
                [continentalDict release]; 
            } 
            
            // Note the continent name so that we know if we need to make a 
            // new continent dictionary next time throught the loop 
            lastContinentName = continentName; 
            
            const char *cCountryName = (const char *)sqlite3_column_text(statement, 1); 
            NSString *countryName = [[NSString alloc] initWithUTF8String:cCountryName]; 
            [countryName autorelease]; 
            
            const char *cCountryCode = (const char *)sqlite3_column_text(statement, 2); 
            NSString *countryCode = [[NSString alloc] initWithUTF8String:cCountryCode]; 
            [countryCode autorelease]; 
            // Create a dictionary for this nation 
            NSMutableDictionary *countryDict = [[NSMutableDictionary alloc] init]; 
            [countryDict setObject:countryName forKey:@"name"]; 
            [countryDict setObject:countryCode forKey:@"code"]; 
            
            // Put the nation's dictionary in the list for the current continent 
            [currentNationList addObject:countryDict]; 
            
            // Release the dictionary retained by the array 
            [countryDict release]; 
    
         } 
		sqlite3_reset(statement);        
    } 
    
    // Load the table with the new data 
    [countryTable reloadData]; 
} 

#pragma mark Table View Data Source Methods 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{ 
    // Return the number of continents 
    return [continents count]; 
} 
- (NSString *)tableView:(UITableView *)tableView 
titleForHeaderInSection:(NSInteger)section 
{ 
    // Get the dictionary for the continent for this section 
    NSDictionary *continentDict = [continents objectAtIndex:section]; 
    
    // Return the name of the continent
	return [continentDict objectForKey:@"name"]; 
} 

- (NSInteger)tableView:(UITableView *)table 
 numberOfRowsInSection:(NSInteger)section 
{ 
    // Get the dictionary for the continent for this section 
    NSDictionary *continentDict = [continents objectAtIndex:section]; 
    
    // Get the array of nations for this continent 
    NSArray *nations = [continentDict objectForKey:@"list"]; 
    
    // Return the number of nations on this continent 
    return [nations count]; 
} 
- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)ip 
{	
    // Get the dictionary for the continent for this section 
    NSDictionary *continentDict = [continents objectAtIndex:[ip section]]; 
    // Get the array of nations for this continent 
    NSArray *nations = [continentDict objectForKey:@"list"]; 
    
    // Which nation is at the required row? 
    NSDictionary *nationDict = [nations objectAtIndex:[ip row]]; 
   
    // What is its name? 
    NSString *nationName = [nationDict objectForKey:@"name"]; 
        
    // Try to reuse an existing cell 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"]; 
    
    // None available? 
    if (!cell) { 
        
        // Make a new cell 
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                      reuseIdentifier:@"UITableViewCell"]; 
        [cell autorelease]; 
    } 
    
    // Put the name of the country on the cell 
    [[cell textLabel] setText:nationName]; 
    
    return cell; 
} 

#pragma mark App Delegate Methods
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
    [window makeKeyAndVisible]; 
    
    // Bring up the keyboard immediately 
    [searchBar becomeFirstResponder]; 
	return YES;
} 
- (void)applicationWillTerminate:(UIApplication *)application 
{ 
    sqlite3_close(database); 
} 
- (void)dealloc { 
    [window release]; 
    [super dealloc]; 
} 



@end
