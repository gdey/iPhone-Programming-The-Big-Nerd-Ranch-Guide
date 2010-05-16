//
//  HypnosisView.m
//  Hypnosister
//
//  Created by Gautam Dey on 5/15/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "HypnosisView.h"


@implementation HypnosisView


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    
    CGRect bounds = [self bounds];
    
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    CGFloat maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 10);
    [[UIColor lightGrayColor] setStroke];
    
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        CGContextAddArc(context, center.x, center.y, currentRadius, 0.0, M_PI * 2.0, YES);
        CGContextStrokePath(context);
        [[UIColor colorWithRed:sin(rand()) green:sin(rand()) blue:sin(rand()) alpha:1.0] setStroke];
            //        [[UIColor colorWithWhite:sin(currentRadius) alpha:1.0] setStroke];
    }
    
        // Add some text.
    NSString *text = @"You are getting sleepy";
    UIFont *font = [UIFont boldSystemFontOfSize:28];
    
    CGRect textRect;
    textRect.size = [text sizeWithFont:font];
    textRect.origin.x = center.x - ( textRect.size.width  / 2.0 );
    textRect.origin.y = center.y - ( textRect.size.height / 2.0 );
    
        // Set the fill color
    [[UIColor blackColor] setFill];
    
        // Set the shadow
    CGSize offset = CGSizeMake(4, 3);
    CGColorRef color = [[UIColor darkGrayColor] CGColor];
    CGContextSetShadowWithColor(context, offset, 2.0, color);
    
        // Draw the string
    [text drawInRect:textRect withFont:font];
    
}


- (void)dealloc {
    [super dealloc];
}


@end
