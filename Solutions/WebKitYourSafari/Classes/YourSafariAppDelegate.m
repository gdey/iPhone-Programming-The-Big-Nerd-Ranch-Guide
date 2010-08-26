//
//  YourSafariAppDelegate.m
//  YourSafari
//
//  Created by Alex Silverman on 7/28/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import "YourSafariAppDelegate.h"

@implementation YourSafariAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	activityIndicator = [[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray] autorelease];
	[textField setLeftView:activityIndicator];
	[textField setLeftViewMode:UITextFieldViewModeAlways];
	
    [window makeKeyAndVisible];
}

- (BOOL)textFieldShouldReturn:(UITextField*)aTextField
{
	[aTextField resignFirstResponder];
	[webView loadRequest:[NSURLRequest requestWithURL: [NSURL URLWithString:[aTextField text]]]];
	return YES;
}

- (IBAction)refresh:(id)sender
{
	[webView reload];
}

- (IBAction)forward:(id)sender
{
	[webView goForward];
}

- (IBAction)back:(id)sender
{
	[webView goBack];
}

- (IBAction)stop:(id)sender
{
	[webView stopLoading];
}

- (void)webViewDidStartLoad:(UIWebView *)aWebView
{
	[activityIndicator startAnimating];
	[stopButton setEnabled:YES];
	[refreshButton setEnabled:YES];
	if ([webView canGoBack])
		[backButton setEnabled:YES];
	if ([webView canGoForward])
		[forwardButton setEnabled:YES];
}

- (void)webViewDidFinishLoad:(UIWebView*)aWebView
{
	[activityIndicator stopAnimating];
	[stopButton setEnabled:NO];
	[refreshButton setEnabled:YES];
	if ([webView canGoBack])
		[backButton setEnabled:YES];
	if ([webView canGoForward])
		[forwardButton setEnabled:YES];
}

- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
