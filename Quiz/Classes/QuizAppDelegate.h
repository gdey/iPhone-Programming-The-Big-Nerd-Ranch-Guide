//
//  QuizAppDelegate.h
//  Quiz
//
//  Created by Gautam Dey on 8/22/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizAppDelegate : NSObject <UIApplicationDelegate> {
    
    int currentQuestionIndex;
    
        // The model objects
    NSMutableArray *questions;
    NSMutableArray *answers;
    
        // the view objects
    IBOutlet UILabel *questionField;
    IBOutlet UILabel *answerField;
    
    UIWindow *window;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UILabel *questionField;
@property (nonatomic, retain) IBOutlet UILabel *answerField;


- (IBAction)showQuestion:(id)sender;
- (IBAction)showAnswer:(id)sender;

@end

