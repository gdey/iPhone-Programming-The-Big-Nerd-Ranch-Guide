//
//  ItemsViewController.h
//  Homepwner
//
//  Created by Gautam Dey on 9/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ItemDetailViewController;

@interface ItemsViewController : UITableViewController {
    
    NSMutableArray *possessions;
    UIView *headerView;
    ItemDetailViewController *detailViewController;

}

@end
