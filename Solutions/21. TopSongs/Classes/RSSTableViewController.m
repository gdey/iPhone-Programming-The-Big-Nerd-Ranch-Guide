//
//  RSSTableViewController.m
//  AppleRSS
//
//  Created by Joe Conway on 1/25/10.
//  Copyright 2010 Big Nerd Ranch. All rights reserved.
//

#import "RSSTableViewController.h"


@implementation RSSTableViewController

- (id)initWithStyle:(UITableViewStyle)style 
{
    if (self = [super initWithStyle:style]) {
		songs = [[NSMutableArray alloc] init];
    }
    return self;
}
/*
	Temp songs:
		
*/
- (void)viewWillAppear:(BOOL)animated 
{
    [super viewWillAppear:animated];
	[self loadSongs];
}
- (void)loadSongs
{
/*	[songs addObject:@"Break On Through - The Doors"];
	[songs addObject:@"Brown Eyed Girl - Van Morrison"];
	[songs addObject:@"Come On Eileen - Dexys Midnight Runners"];
	[songs addObject:@"Hotel California - Eagles"];
	[songs addObject:@"Break On Through - The Doors"];
	[songs addObject:@"Jump Around - House of Pain"];
	[songs addObject:@"Layla - Eric Clapton"];
	[songs addObject:@"Dock of the Bay - Otis Redding"];
*/
	// In case the view will appear multiple times (if you used this class in another app)
	// Clear the song list 
	[songs removeAllObjects];
	[[self tableView] reloadData];

	// Construct the web service URL
	NSURL *url = [NSURL URLWithString:@"http://ax.itunes.apple.com/"
									  @"WebObjects/MZStoreServices.woa/ws/RSS/topsongs/"
									  @"limit=10/xml"];
									  
	// Create a request object with that URL								  
	NSURLRequest *request = [NSURLRequest requestWithURL:url 
										 cachePolicy:NSURLRequestReloadIgnoringCacheData 
									 timeoutInterval:30]; 

    // Clear out the existing connection if there is one 
    if (connectionInProgress) { 
        [connectionInProgress cancel]; 
        [connectionInProgress release]; 
    } 
	
	// Create and initiate the connection
    connectionInProgress = [[NSURLConnection alloc] initWithRequest:request 
                                                           delegate:self 
                                                   startImmediately:YES]; 

	// Instantiate the object to hold all incoming data
    [xmlData release]; 
    xmlData = [[NSMutableData alloc] init]; 
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{ 
    [xmlData appendData:data]; 
} 
- (void)connectionDidFinishLoading:(NSURLConnection *)connection 
{ 
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData]; 
    [parser setDelegate:self]; 
    [parser parse]; 
    [parser release]; 
	[[self tableView] reloadData];
} 
- (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName 
    attributes:(NSDictionary *)attributeDict 
{ 
	if([elementName isEqual:@"entry"])
	{
		NSLog(@"Found a song entry");
		waitingForEntryTitle = YES;
	}	
    if ([elementName isEqual:@"title"] && waitingForEntryTitle) { 
        NSLog(@"found title!"); 
        titleString = [[NSMutableString alloc] init]; 
    } 
} 
- (void)parser:(NSXMLParser *)parser 
foundCharacters:(NSString *)string 
{ 
    [titleString appendString:string]; 
} 
- (void)parser:(NSXMLParser *)parser 
 didEndElement:(NSString *)elementName 
  namespaceURI:(NSString *)namespaceURI 
 qualifiedName:(NSString *)qName 
{ 
    if ([elementName isEqual:@"title"] && waitingForEntryTitle) { 
        NSLog(@"ended title: %@", titleString); 
		[songs addObject:titleString];
        [titleString release]; 
        titleString = nil; 
    } 
	if([elementName isEqual:@"entry"])
	{
		NSLog(@"ended a song entry");
		waitingForEntryTitle = NO;
	}
} 

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{ 
    [connectionInProgress release]; 
    connectionInProgress = nil; 
    [xmlData release]; 
    xmlData = nil; 
    NSString *errorString = [NSString stringWithFormat:@"Fetch failed: %@", 
                             [error localizedDescription]]; 
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:errorString 
                                                             delegate:nil 
                                                    cancelButtonTitle:@"OK" 
                                               destructiveButtonTitle:nil 
                                                    otherButtonTitles:nil]; 
    [actionSheet showInView:[[self view] window]];
    [actionSheet autorelease]; 
}    

#pragma mark Table view methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [songs count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
									   reuseIdentifier:@"UITableViewCell"] autorelease];
    }
    
	[[cell textLabel] setText:[songs objectAtIndex:[indexPath row]]];
		
    return cell;
}

- (void)dealloc {
    [super dealloc];
}


@end

