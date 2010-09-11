//
//  ItemDetailViewController.h
//  Homepwner
//
//  Created by Gautam Dey on 9/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class Possession;

@interface ItemDetailViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate> {


    IBOutlet UITextField *nameField;
    IBOutlet UITextField *serialNumberField;
    IBOutlet UITextField *valueField;
    IBOutlet UILabel     *dateLabel;
    IBOutlet UIImageView *imageView;
    IBOutlet UIButton    *clearImageButton;
    
    Possession *editingPossession;

}

@property (nonatomic, assign) Possession *editingPossession;

- (IBAction) clearImage:(id)sender;

@end
