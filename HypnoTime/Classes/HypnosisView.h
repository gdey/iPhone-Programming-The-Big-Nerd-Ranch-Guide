//
//  HypnosisView.h
//  Hypnosister
//
//  Created by Gautam Dey on 8/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoxLayerDelegate.h"

@class CALayer;
@interface HypnosisView : UIView {

    float xShift, yShift;
    UIColor *stripeColor;
    CALayer *boxLayer;
    BoxLayerDelegate *boxLayerDelegate;
}


@property (nonatomic, assign) float xShift;
@property (nonatomic, assign) float yShift;
@property (nonatomic, retain) UIColor *stripeColor;

@end
