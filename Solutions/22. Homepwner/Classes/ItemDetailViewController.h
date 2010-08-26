//
//  ItemDetailViewController.h
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h> 
@class Possession;

@interface ItemDetailViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, ABPeoplePickerNavigationControllerDelegate> {
	IBOutlet UITextField *nameField;
	IBOutlet UITextField *serialNumberField;
	IBOutlet UITextField *valueField;
	IBOutlet UILabel *dateLabel;
	Possession *editingPossession;
	UIImagePickerController *imagePickerController;
	IBOutlet UIImageView *imageView;
	NSMutableDictionary *imageCache;
    IBOutlet UILabel *inheritorNameField; 
    IBOutlet UILabel *inheritorNumberField; 
} 
- (IBAction)chooseInheritor:(id)sender; 

- (void)setEditingPossession:(Possession *)possession;

@end
