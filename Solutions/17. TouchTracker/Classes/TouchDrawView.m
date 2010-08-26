//
//  TouchDrawView.m
//  TouchTracker
//
//  Created by Alex Silverman on 7/28/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "TouchDrawView.h"
#import "Line.h"

@implementation TouchDrawView


- (id)initWithCoder:(NSCoder *)aDecoder
{
	[super initWithCoder:aDecoder]; 
	linesInProcess = [[NSMutableDictionary alloc] init];
	completeLines = [[NSMutableArray alloc] init];
	[self setMultipleTouchEnabled:YES];
	return self;
}


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetLineWidth(context, 10.0);
	CGContextSetLineCap(context, kCGLineCapRound);
	
	// Draw complete lines in black
	[[UIColor blackColor] set];
	for (Line *line in completeLines) {
		CGContextMoveToPoint(context, [line begin].x, [line begin].y);
		CGContextAddLineToPoint(context, [line end].x, [line end].y);
		CGContextStrokePath(context);
	}

	// Draw lines in process in red
	[[UIColor redColor] set];
	for (NSValue *v in linesInProcess) {
		Line *line = [linesInProcess objectForKey:v];
		CGContextMoveToPoint(context, [line begin].x, [line begin].y);
		CGContextAddLineToPoint(context, [line end].x, [line end].y);
		CGContextStrokePath(context);
	}
}

- (void)clearAll 
{
	[linesInProcess removeAllObjects];
	[completeLines removeAllObjects];
	
	// Redraw
	[self setNeedsDisplay];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	for (UITouch *t in touches) {
		// Is this a double-tap?
		if ([t tapCount] > 1) {
			[self clearAll];
			return;
		}
		
		// Use the touch object (packed in an NSValue) as the key
		NSValue *key = [NSValue valueWithPointer:t];
	
		// Create a line for the value
		CGPoint loc = [t locationInView:self];
		Line *newLine = [[Line alloc] init]; 
		[newLine setBegin:loc];
		[newLine setEnd:loc];
	
		// Put pair in dictionary
		[linesInProcess setObject:newLine forKey:key];
		[newLine release];
	}
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	// Update currentLocations
	for (UITouch *t in touches) {
		NSValue *key = [NSValue valueWithPointer:t];
		
		// Find the line for this touch
		Line *line = [linesInProcess objectForKey:key];

		// Update the line
		CGPoint loc = [t locationInView:self];
		[line setEnd:loc];
	}
	
	// Redraw
	[self setNeedsDisplay];
}

- (void)endTouches:(NSSet *)touches
{
	// Remove ending touches from dictionary
	for (UITouch *t in touches) {
		NSValue *key = [NSValue valueWithPointer:t];
		Line *line = [linesInProcess objectForKey:key];
		
		// If this is a double-tap, 'line' will be nil
		if (line) {
			[completeLines addObject:line];
			[linesInProcess removeObjectForKey:key];
		}		
	}
	
	// Redraw
	[self setNeedsDisplay];
}
	
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self endTouches:touches];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self endTouches:touches];
}

- (void)dealloc {
	[linesInProcess release];
	[completeLines release];
    [super dealloc];
}


@end
