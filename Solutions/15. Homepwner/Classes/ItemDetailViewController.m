//
//  ItemDetailViewController.m
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "Possession.h"
#import "ImageCache.h"

@implementation ItemDetailViewController

- (id)init
{
	self = [super initWithNibName:@"ItemDetailViewController" bundle:nil];
	
	// Create a UIBarButtonItem with a camera icon, will send
	// takePicture: to our ItemDetailViewController when tapped
	UIBarButtonItem *cameraBarButtonItem = 
	[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera 
																								target:self 
																								action:@selector(takePicture:)];	
	
	// Place this image on our navigation bar when this viewcontroller
	// is on top of the navigation stack
	[[self navigationItem] setRightBarButtonItem:cameraBarButtonItem];
	
	// cameraBarButton is retained by the navigation item
	[cameraBarButtonItem release];
	
	return self;
}

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle
{
	return [self init];
}

- (void)viewDidLoad
{
	[[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
	[self setEditingPossession:editingPossession];
}

- (void)takePicture:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    // If our device has a camera, we want to take a picture, otherwise, we just 
    // pick from photo library
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    else
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    // image picker needs a delegate so we can respond to its messages
    [imagePicker setDelegate:self];
    
    // Place image picker on the screen
    [self presentModalViewController:imagePicker animated:YES];
    
    // The image picker will be retained until it has been dismissed
    [imagePicker release];    
}

- (void)imagePickerController:(UIImagePickerController *)picker 
didFinishPickingMediaWithInfo:(NSDictionary *)info
{	
    NSString *oldKey = [editingPossession imageKey];
    
    // Did the possession already have an image?
    if (oldKey) {
        
        // Delete the old image
        [[ImageCache sharedImageCache] deleteImageForKey:oldKey];
    }
	// Get picked image from info dictionary
	UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
	
	// Create a CFUUID object - it knows how to create unique identifiers
	CFUUIDRef newUniqueID = CFUUIDCreate (kCFAllocatorDefault);
	
	// Create a string from unique identifier
	CFStringRef newUniqueIDString = CFUUIDCreateString (kCFAllocatorDefault, newUniqueID);
	
	// Use that unique ID to set our possessions imageKey
	[editingPossession setImageKey:(NSString *)newUniqueIDString];
	
	// We used "Create" in the functions to generate objects, we need to release them
	CFRelease(newUniqueIDString);
	CFRelease(newUniqueID);
	
    // Store image in the ImageCache with this key
   	[[ImageCache sharedImageCache] setImage:image forKey:[editingPossession imageKey]];
    [imageView setImage:image];

	// Take image picker off the screen
	[self dismissModalViewControllerAnimated:YES];
}

- (void)setEditingPossession:(Possession *)possession
{
	// Keep a pointer to the incoming possession
	editingPossession = possession;
}
- (void)viewWillAppear:(BOOL)animated
{	
	// Use properties of incoming possession to change user interface
	[nameField setText:[editingPossession possessionName]];
	[serialNumberField setText:[editingPossession serialNumber]];
	[valueField setText:[NSString stringWithFormat:@"%d", 
											 [editingPossession valueInDollars]]];
	
	// Create a NSDateFormatter... we filter NSDate objects through this formatted
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] 
																		autorelease];
	[dateFormatter setDateStyle:NSDateFormatterMediumStyle];
	[dateFormatter setTimeStyle:NSDateFormatterNoStyle];
	
	// Use filtered NSDate object to return string to set dateLabel contents
	[dateLabel setText:
	 [dateFormatter stringFromDate:[editingPossession dateCreated]]];
	// Change the nav item to display name of possession
	[[self navigationItem] setTitle:[editingPossession possessionName]];

	NSString *imageKey = [editingPossession imageKey];
	
    if (imageKey) {
        // Get image for image key from image cache
        UIImage *imageToDisplay = [[ImageCache sharedImageCache] imageForKey:imageKey];
        
        // Use that image to put on the screen in imageView
        [imageView setImage:imageToDisplay];
    } else {
        // Clear the imageView
        [imageView setImage:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];	
    
    [nameField resignFirstResponder];
    [serialNumberField resignFirstResponder];
    [valueField resignFirstResponder];
    
	// "Save" changes to editingPossession
	[editingPossession setPossessionName:[nameField text]];
	[editingPossession setSerialNumber:[serialNumberField text]];
	[editingPossession setValueInDollars:[[valueField text] intValue]];	
}

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


- (void)dealloc {
    [super dealloc];
}


@end
