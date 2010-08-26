//
//  AssetListViewController.h
//  Inventory
//
//  Created by Aaron Hillegass on 10/22/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class LabelSettingViewController;
@class CountViewController;

@interface AssetListViewController : UITableViewController {
    NSManagedObject *location;
    NSMutableArray *assetList;
    LabelSettingViewController *labelSettingViewController;
    CountViewController *countViewController;
}
- (NSManagedObject *)inventoryForAsset:(NSManagedObject *)asset;
- (void)setLocation:(NSManagedObject *)loc;

@end
