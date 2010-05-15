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
    }
}


- (void)dealloc {
    [super dealloc];
}


@end
