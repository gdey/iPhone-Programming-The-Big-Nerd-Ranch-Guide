//
//  HomepwnerItemCell.m
//  Homepwner
//
//  Created by bhardy on 7/30/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "HomepwnerItemCell.h"
#import "Possession.h"

@implementation HomepwnerItemCell

- (id)initWithStyle:(UITableViewCellStyle)style 
    reuseIdentifier:(NSString *)reuseIdentifier 
{
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		
		// Create our subviews - we don't need to specify their position/size
		valueLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
		nameLabel = [[[UILabel alloc] initWithFrame:CGRectZero] autorelease];
		imageView = [[[UIImageView alloc] initWithFrame:CGRectZero] autorelease];
		
		// Tell the imageview to resize its image to fit inside its frame
		[imageView setContentMode:UIViewContentModeScaleAspectFit];
		
		// Place these subviews in the content view
		[[self contentView] addSubview:valueLabel];
		[[self contentView] addSubview:nameLabel];
		[[self contentView] addSubview:imageView];
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
	[nameLabel setFrame:CGRectMake(inset * 2 + h, inset, w - (h + valueWidth + inset * 4), 30)];
	
	// Move that rectangle over again and resize the width for valueLabel
	innerFrame.origin.x += innerFrame.size.width + inset;
	innerFrame.size.width = valueWidth;
	[valueLabel setFrame:innerFrame];
}

- (void)setPossession:(Possession *)possession
{
	// Using a Possession instance, we can set the values of the subviews
	
	NSString *currencySymbol = [[NSLocale currentLocale] objectForKey:NSLocaleCurrencySymbol];
	[valueLabel setText:[NSString stringWithFormat:@"%@%d", 
					currencySymbol,
					[possession valueInDollars]]];
					
	[nameLabel setText:[possession possessionName]];
	[imageView setImage:[possession thumbnail]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
