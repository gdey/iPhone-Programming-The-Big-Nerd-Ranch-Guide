//
//  QuizAppDelegate.h
//  Quiz
//
//  Created by Gautam Dey on 5/12/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizAppDelegate : NSObject <UIApplicationDelegate> {

    // Holds the current index
    NSInteger currentQuestionIndex;

    // The model objects
    NSMutableArray *answers;
    NSMutableArray *questions;
    
    // View objects
    UILabel *questionField;
    UILabel *answerField;

    UIWindow *window;


    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UILabel *questionField;
@property (nonatomic, retain) IBOutlet UILabel *answerField;

// Actions

- (IBAction) showQuestion:(id)sender;
- (IBAction) showAnswer:(id)sender;

@end

