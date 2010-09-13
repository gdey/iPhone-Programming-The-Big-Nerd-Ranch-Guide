//
//  HomepwnerItemCell.m
//  Homepwner
//
//  Created by Gautam Dey on 9/12/10.
//  Copyright 2010 Gautam Dey. All rights reserved.
//

#import "HomepwnerItemCell.h"
#import "Possession.h"


@implementation HomepwnerItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        // Initialization code
        valueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [[self contentView] addSubview:valueLabel];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [[self contentView] addSubview:nameLabel];
        
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [[self contentView] addSubview:imageView];
        
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -
#pragma mark Data Methods
- (void) setPossession:(Possession *)possession {
    [valueLabel setText:[NSString stringWithFormat:@"$%d",[possession valueInDollars]]];
    [nameLabel setText:[possession possessionName]];
    [imageView setImage:[possession thumbnail]];
}

#pragma mark -
#pragma mark View Methods
- (void)layoutSubviews {
    [super layoutSubviews];
    
    float inset = 5.0;
    CGRect bounds = [[self contentView] bounds];
    float h = bounds.size.height;
    float w = bounds.size.width;
    float valueWidth = 40.0;
    
    CGRect innerFrame = CGRectMake(inset, inset, h, h - inset * 2.0);
    [imageView setFrame:innerFrame];
    
    innerFrame.origin.x += innerFrame.size.width + inset;
    innerFrame.size.width = w - (h + valueWidth + inset * 4);
    [nameLabel setFrame:innerFrame];
    
    innerFrame.origin.x += innerFrame.size.width + inset;
    innerFrame.size.width = valueWidth;
    [valueLabel setFrame:innerFrame];
}

- (void)dealloc {
    [super dealloc];
    [valueLabel release];
    [nameLabel release];
    [imageView release];
}


@end
