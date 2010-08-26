//
//  HypnosisView.h
//  Hypnosister
//
//  Created by Alex Silverman on 7/28/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HypnosisView : UIView 
{ 
	UIColor *stripeColor; 
    float xShift, yShift; 
} 
@property (nonatomic, assign) float xShift; 
@property (nonatomic, assign) float yShift; 
@end 
