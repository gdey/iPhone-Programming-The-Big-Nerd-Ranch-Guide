//
//  HomepwnerItemCell.h
//  Homepwner
//
//  Created by Gautam Dey on 9/12/10.
//  Copyright 2010 Gautam Dey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Possession;

@interface HomepwnerItemCell : UITableViewCell {

    UILabel *valueLabel;
    UILabel *nameLabel;
    UILabel *serialLabel;
    UILabel *dateCreatedLabel;
    UIImageView *imageView;
    BOOL accessoryMode;
   
    
}



- (void) setPossession:(Possession *)possession;

@end
