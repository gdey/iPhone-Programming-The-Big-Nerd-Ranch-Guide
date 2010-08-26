//
//  NayshunzAppDelegate.h
//  Nayshunz
//
//  Created by Joe Conway on 7/30/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h> 

@interface NayshunzAppDelegate : NSObject <UIApplicationDelegate, 
                          UISearchBarDelegate, UITableViewDataSource> { 
    // Outlets 
    IBOutlet UIWindow *window; 
    IBOutlet UITableView *countryTable; 
    IBOutlet UISearchBar *searchBar; 
 
    // Model 
    NSMutableArray *continents; 
    // Database stuff 
    sqlite3 *database; 
    sqlite3_stmt *statement; 
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

