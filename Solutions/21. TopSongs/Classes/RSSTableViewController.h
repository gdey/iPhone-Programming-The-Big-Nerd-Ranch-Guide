//
//  RSSTableViewController.h
//  AppleRSS
//
//  Created by Joe Conway on 1/25/10.
//  Copyright 2010 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RSSTableViewController : UITableViewController <NSXMLParserDelegate> {
	BOOL waitingForEntryTitle;
	NSMutableArray *songs;
    NSMutableData *xmlData; 
	NSURLConnection *connectionInProgress; 
	NSMutableString *titleString;
}
- (void)loadSongs;
@end
