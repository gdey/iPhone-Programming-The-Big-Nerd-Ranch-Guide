//
//  TouchDrawView.m
//  TouchTracker
//
//  Created by Gautam Dey on 9/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TouchDrawView.h"
#import "Line.h"

@implementation TouchDrawView


- (id)initWithCoder:(NSCoder *)aDecoder {
    [super initWithCoder:aDecoder];
    linesInProgress = [[NSMutableDictionary alloc] init];
    completeLines   = [[NSMutableArray alloc] init];
    
    [self setMultipleTouchEnabled:YES];
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void)clearAll {
        // Clear the containers
    [linesInProgress removeAllObjects];
    [completeLines removeAllObjects];
    
    [self setNeedsDisplay];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, 10.0);
    CGContextSetLineCap(c, kCGLineCapRound);
    
    [[UIColor blueColor] set];
    for (Line *line in completeLines) {
        CGContextMoveToPoint(c, [line begin].x, [line begin].y);
        CGContextAddLineToPoint(c, [line end].x, [line end].y);
        CGContextStrokePath(c);
    }
    
        // Draw lines in Progress in RED
    [[UIColor redColor] set];
    for (NSValue *v in linesInProgress) {
        Line *line = [linesInProgress objectForKey:v];
        CGContextMoveToPoint(c, [line begin].x, [line begin].y);
        CGContextAddLineToPoint(c, [line end].x, [line end].y);
        CGContextStrokePath(c);
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for(UITouch *t in touches){
        if ([t tapCount] > 1) {
            [self clearAll];
            return;
        }
        
        NSValue *key = [NSValue valueWithPointer:t];
        
        CGPoint loc = [t locationInView:self];
        Line *line = [[Line alloc] init];
        [line setBegin:loc];
        [line setEnd:loc];
        
        [linesInProgress setObject:line forKey:key];
        
            // [line release];
    }
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithPointer:t];
        Line *line = (Line *)[linesInProgress objectForKey:key];
        [line setEnd:[t locationInView:self]];
    }
    [self setNeedsDisplay];
}


-(void) endTouches:(NSSet *)touches {

    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithPointer:t];
        Line *line = (Line *)[linesInProgress objectForKey:key];
        
        if( line ){
            [line setEnd:[t locationInView:self]];
            [completeLines addObject:line];
            [linesInProgress removeObjectForKey:key];
        }
    }
    
    [self setNeedsDisplay];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self endTouches:touches];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self endTouches:touches];
}


- (void)dealloc {
    
    [linesInProgress release];
    [completeLines release];
    
    [super dealloc];
}


@end
