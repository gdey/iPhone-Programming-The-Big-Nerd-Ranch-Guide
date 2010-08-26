//
//  TouchDrawView.h
//  TouchTracker
//
//  Created by Alex Silverman on 7/28/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TouchDrawView : UIView {
	NSMutableDictionary *linesInProcess;
	NSMutableArray *completeLines;
} 
- (void)endTouches:(NSSet *)touches; 

@end
