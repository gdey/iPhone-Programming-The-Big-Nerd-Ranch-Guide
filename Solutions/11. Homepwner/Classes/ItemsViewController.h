//
//  ItemsViewController.h
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemsViewController : UITableViewController {
	UIView *headerView;
	NSMutableArray *possessions;
}
- (UIView *)headerView;
@end
