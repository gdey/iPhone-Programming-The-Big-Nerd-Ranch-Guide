//
//  TouchDrawView.m
//  TouchTracker
//
//  Created by Gautam Dey on 9/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TouchDrawView.h"
#import "Line.h"
#import "Circle.h"

@implementation TouchDrawView

@synthesize isDrawingLines;

- (id)initWithCoder:(NSCoder *)aDecoder {
    [super initWithCoder:aDecoder];
    linesInProgress = [[NSMutableDictionary alloc] init];
    completeLines   = [[NSMutableArray alloc] init];
    circlesInProgressBegin = [[NSMutableDictionary alloc] init];
    circlesInProgressEnd = [[NSMutableDictionary alloc] init];
    completeCircles = [[NSMutableArray alloc] init];
    workingCircle = nil;
    [self setIsDrawingLines:YES];
    [self setMultipleTouchEnabled:YES];
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void) setCompleatedLines:(NSArray *)lines {
    if (lines && completeLines != lines) {
        [completeLines release];
        completeLines = [lines mutableCopy];
    }
}

- (NSArray *)compleatedLines {
    return [NSArray arrayWithArray:completeLines];
}

- (void) setCompleatedCircles:(NSArray *)circles {
    if (circles && completeCircles != circles) {
        [completeCircles release];
        completeCircles = [circles mutableCopy];
    }
}

- (NSArray *)compleatedCircles {
    return [NSArray arrayWithArray:completeCircles];
}

- (void)clearAll {
        // Clear the containers
    [linesInProgress removeAllObjects];
    [completeLines removeAllObjects];
    
    [circlesInProgressEnd removeAllObjects];
    [circlesInProgressBegin removeAllObjects];
    [completeCircles removeAllObjects];
    [workingCircle release];
    workingCircle = nil;
    
    [self setNeedsDisplay];
}

- (void) _drawline:(Line *)line withContext:(CGContextRef) c{
    CGContextMoveToPoint(c, [line begin].x, [line begin].y);
    CGContextAddLineToPoint(c, [line end].x, [line end].y);
    CGContextStrokePath(c);
}

- (void) _drawCircle:(Circle *)circle withContext:(CGContextRef) c{
    float x = 0, y = 0, width = 0, height = 0;
    
    if ([circle begin].x < [circle end].x) {
        x = [circle begin].x;
        width = [circle end].x - [circle begin].x;
    } else {
        x = [circle end].x;
        width = [circle begin].x - [circle end].x;
    }
    
    if ([circle begin].y < [circle end].y) {
        y = [circle begin].y;
        height = [circle end].y - [circle begin].y;
    } else {
        y = [circle end].y;
        height = [circle begin].y - [circle end].y;
    }
    
    CGRect cRect = CGRectMake(x, y, width, height );
        //    CGContextMoveToPoint(c, [line begin].x, [line begin].y);
    CGContextAddEllipseInRect(c, cRect);
    CGContextStrokePath(c);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    CGContextRef c = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(c, 10.0);
    CGContextSetLineCap(c, kCGLineCapRound);
    
    [[UIColor blueColor] set];
    
    for (Line *line in completeLines) {
        [self _drawline:line withContext:c];

    }
    for (Circle *circle in completeCircles) {
           [self _drawCircle:circle withContext:c];
    }

    
        // Draw lines in Progress in RED
    [[UIColor redColor] set];

    for (NSValue *v in linesInProgress) {
            Line *line = [linesInProgress objectForKey:v];
            [self _drawline:line withContext:c];
    } 
    

    NSSet *allCircles = [[NSSet setWithArray:[circlesInProgressBegin allValues]] setByAddingObjectsFromArray:[circlesInProgressEnd allValues]];
    
   for (Circle *circle in allCircles) {
       [self _drawCircle:circle withContext:c];
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
        
        if ([self isDrawingLines]) {
                // For lines:

            Line *line = [[Line alloc] init];
            [line setBegin:loc];
            [line setEnd:loc];
            
            [linesInProgress setObject:line forKey:key];
            
            [line release];
                        
        } else { 
                // For Circles
            if (workingCircle) {
                    // Add to end
                [workingCircle setEnd:loc];
                [circlesInProgressEnd setObject:workingCircle forKey:key];
                [workingCircle release];
                workingCircle = nil;
                
            } else {
                    // Add to begin
                workingCircle = [[Circle alloc] init];
                [workingCircle setBegin:loc];
                [circlesInProgressBegin setObject:workingCircle forKey:key];
                
            }

        }

        
    }
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithPointer:t];
        CGPoint loc = [t locationInView:self];
        if([self isDrawingLines]){
                // For Lines
            Line *line = (Line *)[linesInProgress objectForKey:key];
            [line setEnd:loc];
        } else {
                // for circles
            Circle  *circle = (Circle *)[circlesInProgressBegin objectForKey:key];
            if (circle) {
                    // Found it.
                [circle setBegin:loc];
            } else {
                circle = (Circle *)[circlesInProgressEnd objectForKey:key];
                if (circle) {
                    [circle setEnd:loc];
                }
            }

        }

    }
    [self setNeedsDisplay];
}


-(void) endTouches:(NSSet *)touches {

    for (UITouch *t in touches) {
        NSValue *key = [NSValue valueWithPointer:t];
        
        if([self isDrawingLines]){
                // For Lines
            Line *line = (Line *)[linesInProgress objectForKey:key];
        
            if( line ){
                
                [completeLines addObject:line];
                [linesInProgress removeObjectForKey:key];
            }
        } else {
                //for Circles
            Circle  *circle = (Circle *)[circlesInProgressBegin objectForKey:key];
            if (circle) {
                    // Found it.
                
                [circle retain];
                [circlesInProgressBegin removeObjectForKey:key];
                if (circle == workingCircle) {
                    [workingCircle release];
                    workingCircle = nil;
                } else {
                    NSArray *objKeys = [circlesInProgressEnd allKeysForObject:circle];
                    if ([objKeys count] == 0) {
                        [completeCircles addObject:circle];
                    }
                }

                [circle release];
                circle = nil;

            } else {
                circle = (Circle *)[circlesInProgressEnd objectForKey:key];
                if (circle) {

                    [circle retain];
                    [circlesInProgressEnd removeObjectForKey:key];
                    NSArray *objKeys = [circlesInProgressBegin allKeysForObject:circle];
                    if ([objKeys count] == 0) {
                        [completeCircles addObject:circle];
                    }
                    [circle release];
                    circle = nil;
                }
            }
            
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
    
    [workingCircle release];
    [completeCircles release];
    [circlesInProgressEnd release];
    [circlesInProgressBegin release];
    
    [super dealloc];
}


@end
