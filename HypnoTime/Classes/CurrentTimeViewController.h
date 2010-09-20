//
//  CurrentTimeViewController.h
//  HypnoTime
//
//  Created by Gautam Dey on 9/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CurrentTimeViewController : UIViewController {

    
    IBOutlet UILabel *timeLabel;
    IBOutlet UIButton *getTimeButton;
    NSDateFormatter *dateFormatterShort;
}

- (IBAction)showCurrentTime:(id)sender;

@end
