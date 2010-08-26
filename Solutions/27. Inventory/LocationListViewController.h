//
//  LocationListViewController.h
//  Inventory
//
//  Created by Aaron Hillegass on 10/22/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LabelSettingViewController;

@interface LocationListViewController : UITableViewController  
{
    NSMutableArray *locationList;
    LabelSettingViewController *labelSettingViewController;
}
@end
