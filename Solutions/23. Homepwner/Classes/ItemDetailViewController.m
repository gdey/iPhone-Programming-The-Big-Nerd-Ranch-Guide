//
//  ItemDetailViewController.m
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "ItemDetailViewController.h"
#import "Possession.h"
#import "FileHelpers.h"

@implementation ItemDetailViewController

- (id)init
{
	self = [super initWithNibName:@"ItemDetailViewController" bundle:nil];
	imageCache = [[NSMutableDictionary alloc] init];
	
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
- (void)chooseInheritor:(id)sender 
{ 
    // Lazily allocate a people picker object 
    if (!peoplePicker) { 
        peoplePicker = [[ABPeoplePickerNavigationController alloc] init]; 
		[peoplePicker setPeoplePickerDelegate:self];
    } 
    
    // Put that people picker on the screen 
    [self presentModalViewController:peoplePicker animated:YES]; 
} 
- (void)peoplePickerNavigationControllerDidCancel: 
    (ABPeoplePickerNavigationController *)aPeoplePicker 
{ 
    // Take people picker off the screen 
    [self dismissModalViewControllerAnimated:YES]; 
}
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)aPeoplePicker 
      shouldContinueAfterSelectingPerson:(ABRecordRef)person 
{ 
    // Get the first and last name from the selected person 
    CFStringRef firstName = ABRecordCopyValue(person, kABPersonFirstNameProperty); 
    CFStringRef lastName = ABRecordCopyValue(person, kABPersonLastNameProperty); 
    
    // Get all of the phone numbers for this selected person 
    ABMultiValueRef numbers = ABRecordCopyValue(person, kABPersonPhoneProperty); 
 
    // Make sure we have at least one phone number for this person 
    if (ABMultiValueGetCount(numbers) > 0) { 
        // Grab the first phone number we see 
        CFStringRef number = ABMultiValueCopyValueAtIndex(numbers, 0); 
        // Add that phone number to the possession object we are editing 
        [editingPossession setInheritorNumber:(NSString *)number]; 
        // Set the on screen UILabel to this phone number 
        [inheritorNumberField setText:(NSString *)number]; 
        
        // We used "Copy" to get this value, we need to manually release it 
        CFRelease(number); 
    } 
 
    // Create a string with first and last name together - full name 
    NSString *name = [NSString stringWithFormat:@"%@ %@", 
                                (NSString *)firstName, (NSString *)lastName]; 
    [editingPossession setInheritorName:name]; 
 
    // Manually release all copied objects 
    CFRelease(firstName); 
    CFRelease(lastName); 
    CFRelease(numbers); 
 
    // Update onscreen UILabel 
    [inheritorNameField setText:name]; 
 
    // Get people picker object off the screen 
    [self dismissModalViewControllerAnimated:YES]; 
    
    // Do not perform default functionality (which is go to detailed page) 
    return NO; 
} 
- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)aPeoplePicker 
      shouldContinueAfterSelectingPerson:(ABRecordRef)person 
                                property:(ABPropertyID)property 
                              identifier:(ABMultiValueIdentifier)identifier 
{ 
    // Perform default functionality (like dial phone number, send email) 
    return YES; 
} 

- (void)viewDidLoad
{
	[[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
	[self setEditingPossession:editingPossession];
}

- (void)takePicture:(id)sender
{
	// Lazily allocate image picker controller
	if (!imagePickerController) {
		imagePickerController = [[UIImagePickerController alloc] init];
		
		// If our device has a camera, we want to take a picture, otherwise, we just pick from
		// photo library
		if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
			[imagePickerController setSourceType:UIImagePickerControllerSourceTypeCamera];
		else
			[imagePickerController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
		
		// image picker needs a delegate so we can respond to its messages
		[imagePickerController setDelegate:self];
	}
	// Place image picker on the screen
	[self presentModalViewController:imagePickerController animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker 
didFinishPickingMediaWithInfo:(NSDictionary *)info
{	
	// Get picked image from info dictionary
	UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
	
	[editingPossession setThumbnailFromImage:image];
	
	// Create a CFUUID object - it knows how to create unique identifiers
	CFUUIDRef newUniqueID = CFUUIDCreate (kCFAllocatorDefault);
	
	// Create a string from unique identifier
	CFStringRef newUniqueIDString = CFUUIDCreateString (kCFAllocatorDefault, newUniqueID);
	
	// Use that unique ID to set our possessions imageKey
	[editingPossession setImageKey:(NSString *)newUniqueIDString];
	
	// We used "Create" in the functions to generate objects, we need to release them
	CFRelease(newUniqueIDString);
	CFRelease(newUniqueID);
	
	// Store image in to imageCache with this key
	[imageCache setObject:image forKey:[editingPossession imageKey]];

	// Put that image on to the screen in our image view
	[imageView setImage:image];	
	
	// Take image picker off the screen
	[self dismissModalViewControllerAnimated:YES];
	
	// Create full path for image
	NSString *imagePath = pathInDocumentDirectory([editingPossession imageKey]);
	
	// Turn image into JPEG data,
	NSData *d = UIImageJPEGRepresentation(image, 1.0);
	
	// Write it to full path
	[d writeToFile:imagePath atomically:YES];
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
	[dateFormatter setLocale:[NSLocale currentLocale]];
	
	// Use filtered NSDate object to return string to set dateLabel contents
	[dateLabel setText:
	 [dateFormatter stringFromDate:[editingPossession dateCreated]]];
	// Change the nav item to display name of possession
	[[self navigationItem] setTitle:[editingPossession possessionName]];

	NSString *imageKey = [editingPossession imageKey];
	
	// Get image for image key from image cache
	UIImage *imageToDisplay = [imageCache objectForKey:imageKey];
	
	// If image doesn't exist, load it from file
	if (!imageToDisplay) {
		
		// Create UIImage object from file
		imageToDisplay = [UIImage imageWithContentsOfFile:pathInDocumentDirectory(imageKey)];
		
		// If we found an image on the file system, place it in to the imageCache
		if (imageToDisplay)
			[imageCache setObject:imageToDisplay forKey:imageKey];
	}
	
	// Use that image to put on the screen in imageView
	[imageView setImage:imageToDisplay];
    [inheritorNameField setText:[editingPossession inheritorName]]; 
    [inheritorNumberField setText:[editingPossession inheritorNumber]]; 
    [[self navigationItem] setTitle:[editingPossession possessionName]]; 
}
- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];	
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

- (void)didReceiveMemoryWarning
{
	NSLog(@"didReceiveMemoryWarning");
	
	// Make sure to call super's implementation, it releases its view if necessary
	[super didReceiveMemoryWarning];
	
	// Get rid of all of our images in the cache - we can reload them from disk
	[imageCache removeAllObjects];
	
	// Reload the current editingPossession
	if (editingPossession)
		[self setEditingPossession:editingPossession];
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
