//
//  HomepwnerItemCell.h
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Possession;
@interface HomepwnerItemCell : UITableViewCell {
	UILabel *valueLabel;
	UILabel *nameLabel;
	UIImageView *imageView;
	
}
- (void)setPossession:(Possession *)possession;

@end
