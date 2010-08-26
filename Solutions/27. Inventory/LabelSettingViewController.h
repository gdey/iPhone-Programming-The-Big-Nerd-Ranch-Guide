//
//  LabelSettingViewController.h
//  Inventory
//
//  Created by Aaron Hillegass on 10/22/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabelSettingViewController : UIViewController {
    IBOutlet UITextField *textField;
    NSString *value;
}
- (IBAction)cancel:(id)sender;
- (IBAction)create:(id)sender;
- (NSString *)value;  // Will be nil after cancel
- (void)setValue:(NSString *)v;
@end