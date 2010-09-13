//
//  HomepwnerItemCell.m
//  Homepwner
//
//  Created by Gautam Dey on 9/12/10.
//  Copyright 2010 Gautam Dey. All rights reserved.
//

#import "HomepwnerItemCell.h"
#import "Possession.h"
#import <QuartzCore/QuartzCore.h>


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
        
        [[imageView layer] setCornerRadius:5.0];
        [[imageView layer] setMasksToBounds:YES];
        [[imageView layer] setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [[imageView layer] setBorderWidth:1.0];
        
            // Glossy 
        CAGradientLayer *shineLayer = [CAGradientLayer layer];
        [shineLayer  setFrame:[[imageView layer] bounds] ];
        [shineLayer setColors: [NSArray arrayWithObjects:
                                (id)[[UIColor colorWithWhite:1.0f alpha:0.4f]  CGColor],
                                (id)[[UIColor colorWithWhite:1.0f alpha:0.2f]  CGColor],
                                (id)[[UIColor colorWithWhite:0.75f alpha:0.2f] CGColor],
                                (id)[[UIColor colorWithWhite:0.4f alpha:0.2f]  CGColor],
                                (id)[[UIColor colorWithWhite:1.0f alpha:0.4f]  CGColor],
                                nil]];
        [shineLayer setLocations: [NSArray arrayWithObjects:
                                   [NSNumber numberWithFloat:0.0f],
                                   [NSNumber numberWithFloat:0.5f],
                                   [NSNumber numberWithFloat:0.5f],
                                   [NSNumber numberWithFloat:0.8f],
                                   [NSNumber numberWithFloat:1.0f],
                                   nil]];
        [[imageView layer] addSublayer:shineLayer];        
        
        
        serialLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [[self contentView] addSubview:serialLabel];
        
        dateCreatedLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [[self contentView] addSubview:dateCreatedLabel];
        
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
    
    [serialLabel setText:[possession serialNumber]];
    
        // Create a NSDateFormatter
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    
        // Use filtered NSDate object to set dateLabel contents
    [dateCreatedLabel setText:[dateFormatter stringFromDate:[possession dateCreated]]];
    
    accessoryMode = [possession accessoryMode];
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
    float dateWidth = 60.0;
    
    CGRect innerFrame = CGRectMake(inset, inset, h, h - inset * 2.0);
    [imageView setFrame:innerFrame];
    

    innerFrame.origin.x += innerFrame.size.width + inset;
    innerFrame.size.width = w - (h + valueWidth + inset * 4);
    [nameLabel setFrame:innerFrame];
    
    float x = innerFrame.origin.x;
    
    innerFrame.origin.x += innerFrame.size.width + inset;
    innerFrame.size.width = valueWidth;
    [valueLabel setFrame:innerFrame];
    
    innerFrame.origin.x = x; // reset
    innerFrame.size.width = w - (h + dateWidth + inset * 4);
    
    [serialLabel setFrame:innerFrame];
    
    innerFrame.origin.x += innerFrame.size.width + inset;
    innerFrame.size.width = dateWidth;
    
    [dateCreatedLabel setFrame:innerFrame];
    
    if (!accessoryMode) {
        [serialLabel setHidden:YES];
        [nameLabel setHidden:NO];
        [dateCreatedLabel setHidden:YES];
        [valueLabel setHidden:NO];
    } else {
        [serialLabel setHidden:NO];
        [nameLabel setHidden:YES];
        [dateCreatedLabel setHidden:NO];
        [valueLabel setHidden:YES];   
    }

    
}

- (void)dealloc {
    [super dealloc];
    [valueLabel release];
    [nameLabel release];
    [imageView release];
}


@end
