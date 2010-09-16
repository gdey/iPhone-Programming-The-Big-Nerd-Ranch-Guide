//
//  BoxLayerDelegate.h
//  HypnoTime
//
//  Created by Gautam Dey on 9/16/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface BoxLayerDelegate : NSObject {

    UIImage *layerImage;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx;

@end
