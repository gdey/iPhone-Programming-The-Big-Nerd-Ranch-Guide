//
//  HypnosisView.m
//  Hypnosister
//
//  Created by Gautam Dey on 8/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HypnosisView.h"


@implementation HypnosisView

@synthesize xShift, yShift, stripeColor;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
        xShift = 0.0;
        yShift = 0.0;
        [self setStripeColor:[UIColor lightGrayColor]];
    }
    
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

        // What rectangle am I filling?
    CGRect bounds = [self bounds];
    
        // Where is its center?
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
        // From the center how far out to a corner?
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
        // Get the context being drawn upon
    CGContextRef context = UIGraphicsGetCurrentContext();
    
        // All lines will be drawn 10 points wide
    CGContextSetLineWidth(context, 10);
    
        // Set the stroke color to light gray
    [stripeColor setStroke];

        // Draw concentric circles from the outside in
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        center.x += xShift;
        center.y += yShift;
        CGContextAddArc(context, center.x, center.y, currentRadius, 0.0, M_PI * 2.0, YES);
        CGContextStrokePath(context);
    }
                        
          
        // Let's add some text now.
    NSString *text = @"You are getting sleepy";
    
        // Get a font to draw it in
    UIFont *font = [UIFont boldSystemFontOfSize:28];
    
        // Where am I going to draw it?
    CGRect textRect;
    textRect.size = [text sizeWithFont:font];
    textRect.origin.x = center.x - textRect.size.width / 2.0;
    textRect.origin.y = center.y - textRect.size.height / 2.0;
    
    
        // Set the fill color
    [[UIColor blackColor] setFill];
    
        // Set the shadow
    CGSize offset = CGSizeMake(4, -3);
    CGColorRef color = [[UIColor darkGrayColor] CGColor];
    CGContextSetShadowWithColor(context, offset, 2.0, color);
    
        // Draw the string
    [text drawInRect:textRect withFont:font];
    
}

- (void) setStripeColor:(UIColor *)color {
    if(stripeColor != color){
        [color retain];
        [stripeColor release];
        stripeColor = color;
        [self setNeedsDisplay];
    }
}

- (void) setRandomStripColor {
    
    float r,g,b;
    r = random() % 255 / 256.0;
    g = random() % 255 / 256.0;
    b = random() % 255 / 256.0;
    
    [self setStripeColor:[UIColor colorWithRed:r green:g blue:b alpha:1.0]];

}



- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
        // Shake is the only kind of motion for now
        // But we should (for future compatibility) check motion type
    if(motion == UIEventSubtypeMotionShake){
        NSLog(@"shake started");
        [self setRandomStripColor];
    }
}

- (BOOL) canBecomeFirstResponder {
    return YES;
}

- (void)dealloc {
    [stripeColor release];
    [super dealloc];
}


@end
