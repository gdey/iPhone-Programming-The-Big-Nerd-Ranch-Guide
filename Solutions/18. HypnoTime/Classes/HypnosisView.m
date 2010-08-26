//
//  HypnosisView.m
//  Hypnosister
//
//  Created by Alex Silverman on 7/28/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "HypnosisView.h"

@implementation HypnosisView


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        stripeColor = [[UIColor lightGrayColor] retain];
	   
		// Create the new layer object 
		boxLayer = [[CALayer alloc] init]; 
		// Give it a size 
		[boxLayer setBounds:CGRectMake(0, 0, 85, 85)]; 
		// Give it a location 
		[boxLayer setPosition:CGPointMake(160, 100)]; 
		
		UIColor *reddish = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.5];
		CGColorRef cgReddish = [reddish CGColor];
		[boxLayer setBackgroundColor:cgReddish];
			

		// Create a UIImage	
		UIImage *layerImage = [UIImage imageNamed:@"Hypno.png"]; 
		// Get the underlying CGImage 
		CGImageRef image = [layerImage CGImage]; 
		// Put the CGImage on the layer 
		[boxLayer setContents:(id)image]; 
		// Inset the image a bit on each side 
		[boxLayer setContentsRect:CGRectMake(-0.1, -0.1, 1.2, 1.2)]; 
		// Let the image resize (without changing the aspect ratio) 
		// to fill the contentRect 
		[boxLayer setContentsGravity:kCAGravityResizeAspect];

		// Make it a sublayer of the view's layer 
		[[self layer] addSublayer:boxLayer];
		[boxLayer release];
	}
    return self;
}
- (void)touchesBegan:(NSSet *)touches 
           withEvent:(UIEvent *)event 
{ 
	UITouch *t = [touches anyObject]; 
    CGPoint p = [t locationInView:self]; 
    [boxLayer setPosition:p]; 
} 
- (void)touchesMoved:(NSSet *)touches 
            withEvent:(UIEvent *)event 
{ 
    UITouch *t = [touches anyObject]; 
    CGPoint p = [t locationInView:self]; 
    [CATransaction begin]; 
    [CATransaction setValue:[NSNumber numberWithBool:YES] 
                     forKey:kCATransactionDisableActions]; 
    [boxLayer setPosition:p]; 
    [CATransaction commit]; 
} 

- (void)accelerometer:(UIAccelerometer *)meter didAccelerate:(UIAcceleration *)accel
{
	xShift = xShift * 0.8 + [accel x] * 2.0;
	yShift = yShift * 0.8 - [accel y] * 2.0;
	
	// Redraw the view
	[self setNeedsDisplay];
}

- (BOOL)canBecomeFirstResponder
{
	return YES;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
	// Shake is the only kind of motion for now,
	// but we should (for future compatibility)
	// check the motion type.
	if (motion == UIEventSubtypeMotionShake) {
		NSLog(@"shake started");
		float r, g, b;
		r = random() % 256 / 256.0;
		g = random() % 256 / 256.0;
		b = random() % 256 / 256.0;
		[stripeColor release];
		stripeColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
		[stripeColor retain];
		[self setNeedsDisplay];
	}
}
- (void)drawRect:(CGRect)rect {
    // What rectangle am I filling?
	CGRect bounds = [self bounds];
	
	// Where is its center?
	CGPoint center;
	center.x = bounds.origin.x + bounds.size.width / 2.0;
	center.y = bounds.origin.y + bounds.size.height / 2.0;
	
	// From the center how far out to a corner?
	float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
	
	// Get the context being draw upon
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// All lines will be drawn 10 points wide
	CGContextSetLineWidth(context, 10);
	
	// Set the stroke color to light gray
	[stripeColor setStroke];
	
	// Draw concentric circles
	for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
		center.x += xShift;
		center.y += yShift;
		CGContextAddArc(context, center.x, center.y, currentRadius, 0, M_PI * 2.0, YES);
		CGContextStrokePath(context);
	}
	
	// Create a string
	NSString *text = @"You are getting sleepy.";
	
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


- (void)dealloc 
{
	[stripeColor release];
    [super dealloc];
}


@end
