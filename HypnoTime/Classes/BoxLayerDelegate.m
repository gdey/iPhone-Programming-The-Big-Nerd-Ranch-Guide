//
//  BoxLayerDelegate.m
//  HypnoTime
//
//  Created by Gautam Dey on 9/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BoxLayerDelegate.h"


@implementation BoxLayerDelegate

- (id) init {

    if (self = [super init]) {
        layerImage = [[UIImage imageNamed:@"Hypno.png"] retain];
    }
    return self;
}

- (void)drawLayer:(CALayer *)boxLayer inContext:(CGContextRef)ctx {


   
    float y = [boxLayer position].y;
    float maxy = [[boxLayer superlayer] position].y + [[boxLayer superlayer] bounds].size.height;
    NSLog(@"Asked to draw. Y:%f -- MaxY: %f -- opc: %f",y,maxy, (y > 42)?1-y/maxy:1);
    CGRect boundingBox = CGContextGetClipBoundingBox(ctx);
    if (y > 42) {
        CGContextSetAlpha(ctx, 1 - y/maxy);
    } else {
        CGContextSetAlpha(ctx, 1);
    }
    CGContextDrawImage(ctx, boundingBox, [layerImage CGImage]);
}


- (void) dealloc {
    [layerImage release];
    [super dealloc];
}
@end
