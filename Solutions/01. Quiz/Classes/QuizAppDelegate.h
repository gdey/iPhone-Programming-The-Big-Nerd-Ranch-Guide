#import <UIKit/UIKit.h>

@interface QuizAppDelegate : NSObject <UIApplicationDelegate> 
{
	int currentQuestionIndex;
	
	// The model objects
	NSMutableArray *questions;
	NSMutableArray *answers;
	
	// The view objects
	IBOutlet UILabel *questionField;
	IBOutlet UILabel *answerField;
	UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (IBAction)showQuestion:(id)sender;
- (IBAction)showAnswer:(id)sender;

@end

