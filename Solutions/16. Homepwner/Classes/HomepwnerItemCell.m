//
//  HomepwnerItemCell.m
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "HomepwnerItemCell.h"
#import "Possession.h"
#import <QuartzCore/QuartzCore.h>



@implementation HomepwnerItemCell

- (id)initWithStyle:(UITableViewCellStyle)style 
    reuseIdentifier:(NSString *)reuseIdentifier 
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) 
    {
        // Create a subview - don't need to specify its position/size
        valueLabel = [[UILabel alloc] initWithFrame:CGRectZero];

        // Put it on the content view of the cell
        [[self contentView] addSubview:valueLabel];

        // It is being retained by its superview
        [valueLabel release];

        // Same thing with the name 
        nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [[self contentView] addSubview:nameLabel];
        [nameLabel release];

        // Same thing with the image view
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [[self contentView] addSubview:imageView];

        // Tell the imageview to resize its image to fit inside its frame
        [imageView setContentMode:UIViewContentModeScaleAspectFit];
		[imageView release];      
    }
    return self;
}

- (void)layoutSubviews
{
	// We always call this, the table view cell needs to do its own work first
	[super layoutSubviews];
	
	float inset = 5;
	CGRect bounds = [[self contentView] bounds];
	float h = bounds.size.height;
	float w = bounds.size.width;
	float valueWidth = 40;
	
	// Make a rectangle that is inset and square (hence height for both w, h)
	CGRect innerFrame = CGRectMake(inset, inset, h, h - inset * 2.0);
	[imageView setFrame:innerFrame];
	
	// Move that rectangle over and resize the width for the nameLabel
	innerFrame.origin.x += innerFrame.size.width + inset;
	innerFrame.size.width = w - (h + valueWidth + inset * 4);
	[nameLabel setFrame:innerFrame];
	
	// Move that rectangle over again and resize the width for valueLabel
	innerFrame.origin.x += innerFrame.size.width + inset;
	innerFrame.size.width = valueWidth;
	[valueLabel setFrame:innerFrame];
}

- (void)setPossession:(Possession *)possession
{
	// Using a Possession instance, we can set the values of the subviews
	[valueLabel setText:[NSString stringWithFormat:@"$%d", [possession valueInDollars]]];
	[nameLabel setText:[possession possessionName]];
	[imageView setImage:[possession thumbnail]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc 
{
	[super dealloc];
}


@end
