//
//  ItemDetailViewController.h
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Possession;

@interface ItemDetailViewController : UIViewController {
	IBOutlet UITextField *nameField;
	IBOutlet UITextField *serialNumberField;
	IBOutlet UITextField *valueField;
	IBOutlet UILabel *dateLabel;
	Possession *editingPossession;
}
@property (nonatomic, assign) Possession *editingPossession;
@end
