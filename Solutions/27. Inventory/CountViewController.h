//
//  CountViewController.h
//  Inventory
//
//  Created by Aaron Hillegass on 10/22/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface CountViewController : UIViewController {
    IBOutlet UITextField *numberField;
    IBOutlet UILabel *promptField;
    NSManagedObject *asset;
    NSManagedObject *location;
    NSNumber *count;
}
- (IBAction)update:(id)sender;
- (IBAction)cancel:(id)sender;

@property (nonatomic, retain) NSManagedObject *asset;
@property (nonatomic, retain) NSManagedObject *location;
@property (nonatomic, retain) NSNumber *count;

@end
