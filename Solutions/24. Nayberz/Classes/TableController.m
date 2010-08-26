//
//  TableController.m
//  Nayberz
//
//  Created by Joe Conway on 7/27/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "TableController.h"
#import <netinet/in.h>
#import <arpa/inet.h>


@implementation TableController

- (id)init 
{ 
    [super initWithStyle:UITableViewStylePlain]; 
 // Create an empty array 
    netServices = [[NSMutableArray alloc] init]; 
    // Create a net service browser 
    serviceBrowser = [[NSNetServiceBrowser alloc] init];

    // As the delegate, you will be told when services are found 
    [serviceBrowser setDelegate:self]; 
    // Start it up 
    [serviceBrowser searchForServicesOfType:@"_nayberz._tcp." 
                                   inDomain:@""]; 
    return self; 
} 
- (id)initWithStyle:(UITableViewStyle)style
{
	return [self init];
}
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section 
{ 
    return [netServices count]; 
} 
- (UITableViewCell *)tableView:(UITableView *)tv 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath 
{   
	NSNetService *ns = [netServices objectAtIndex:[indexPath row]];    
    NSString *message = nil; 
    // Try to get the TXT Record 
    NSData *data = [ns TXTRecordData]; 
    // Is the TXT data? (no TXT data in unresolved services) 
    if (data) { 
  
        // Convert it into a dictionary 
        NSDictionary *txtDict = [NSNetService dictionaryFromTXTRecordData:data]; 
        // Get the data that the publisher put in under the message key 
        NSData *mData = [txtDict objectForKey:@"message"]; 
        // Is there data? 
        if (mData) { 
            // Make a string 
            message = [[NSString alloc] initWithData:mData encoding:NSUTF8StringEncoding]; 
            [message autorelease]; 
        } 
    } 
    // Did I fail to get a string? 
    if (!message) { 
        // Use a default message 
        message = @"<No message>"; 
    } 

    UITableViewCell *cell = [[self tableView] dequeueReusableCellWithIdentifier:@"UITableViewCell"]; 
    if (!cell) { 
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 
                                      reuseIdentifier:@"UITableViewCell"]; 
        [cell autorelease]; 
    } 
    [[cell textLabel] setText:[ns name]]; 
    [[cell detailTextLabel] setText:message];
	return cell; 
} 
/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)browser 
           didFindService:(NSNetService *)aNetService 
               moreComing:(BOOL)moreComing 
{ 
    NSLog(@"adding %@", aNetService); 
    // Add it to the array 
    [netServices addObject:aNetService]; 
    // Update the interface 
    NSIndexPath *ip = [NSIndexPath indexPathForRow:[netServices count] - 1 
                                           inSection:0]; 
    [[self tableView] insertRowsAtIndexPaths:[NSArray arrayWithObject:ip] 
                            withRowAnimation:UITableViewRowAnimationRight]; 
    // Start resolution to get TXT record 
    [aNetService setDelegate:self]; 
    [aNetService resolveWithTimeout:30]; 
} 
- (void)netServiceDidResolveAddress:(NSNetService *)sender 
{ 
    // What row just resolved? 
    int row = [netServices indexOfObjectIdenticalTo:sender]; 
    NSIndexPath *ip = [NSIndexPath indexPathForRow:row inSection:0]; 
    NSArray *ips = [NSArray arrayWithObject:ip]; 
    // Reload that row 
    [[self tableView] reloadRowsAtIndexPaths:ips 
                            withRowAnimation:UITableViewRowAnimationRight]; 

	NSArray *addrs = [sender addresses];
	if([addrs count] > 0)
	{
		NSData *firstAddress = [addrs objectAtIndex:0];
		const struct sockaddr_in *addy = [firstAddress bytes];
		char *str = inet_ntoa(addy->sin_addr);
		NSLog(@"%s:%d", str, ntohs(addy->sin_port));
	}
}
// Called when services are lost 
- (void)netServiceBrowser:(NSNetServiceBrowser *)browser 
         didRemoveService:(NSNetService *)aNetService 
               moreComing:(BOOL)moreComing 
{ 
    NSLog(@"removing %@", aNetService); 
    // Take it out of the array 
    NSUInteger row = [netServices indexOfObject:aNetService]; 
    if (row == NSNotFound) { 
        NSLog(@"unable to find the service in %@", netServices); 
        return; 
    } 
    [netServices removeObjectAtIndex:row]; 
    // Update the interface 
    NSIndexPath *ip = [NSIndexPath indexPathForRow:row inSection:0]; 
    [[self tableView] deleteRowsAtIndexPaths:[NSArray arrayWithObject:ip] 
                            withRowAnimation:UITableViewRowAnimationRight]; 
} 

- (void)dealloc {
    [super dealloc];
}


@end

