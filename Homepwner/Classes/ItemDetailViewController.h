//
//  ItemDetailViewController.h
//  Homepwner
//
//  Created by Gautam Dey on 9/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ItemDetailViewController : UIViewController {


    IBOutlet UITextField *nameField;
    IBOutlet UITextField *serialNumberField;
    IBOutlet UITextField *valueField;
    IBOutlet UILabel     *dateLabel;

}

@end
