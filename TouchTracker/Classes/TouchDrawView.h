//
//  TouchDrawView.h
//  TouchTracker
//
//  Created by Gautam Dey on 9/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Circle;
@interface TouchDrawView : UIView {

    
    NSMutableDictionary *linesInProgress;
    NSMutableDictionary *circlesInProgressBegin;
    NSMutableDictionary *circlesInProgressEnd;
    Circle              *workingCircle;
    NSMutableArray *completeCircles;
    NSMutableArray *completeLines;
    BOOL isDrawingLines;
    
}

@property (nonatomic) BOOL isDrawingLines;
- (void) setCompleatedLines:(NSArray *)lines;
- (NSArray *)compleatedLines;

- (void) setCompleatedCircles:(NSArray *)circles;
- (NSArray *)compleatedCircles;
@end
