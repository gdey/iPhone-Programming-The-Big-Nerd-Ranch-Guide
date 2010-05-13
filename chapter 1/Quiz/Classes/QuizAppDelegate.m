//
//  QuizAppDelegate.m
//  Quiz
//
//  Created by Gautam Dey on 5/12/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "QuizAppDelegate.h"

@implementation QuizAppDelegate

@synthesize window;
@synthesize questionField;
@synthesize answerField;

- (id) init {
  // Call the init method implemented by the superclass
  [super init];

  // Create two arrays and make the pointers point to them.
  // Add questions and answers to the array
  questions = [[NSMutableArray alloc] initWithObjects:
               @"What is 7 + 7?",
               @"What is the capitol of Vermont?",
               @"From what is cognac made?",
               nil
               ];
  answers  = [[NSMutableArray alloc] initWithObjects:
               @"14",
               @"Montpelier",
               @"grapes",
               nil
               ];
  return self;


}

- (IBAction)showQuestion:(id)sender
{
  // Step to the next question
  currentQuestionIndex++;

  // Am I past the last question?
  if( currentQuestionIndex == [questions count] ){
     // Go back to the first question
     currentQuestionIndex = 0;
  }

  // Get the string at that index in the questions array
  NSString *question = [questions objectAtIndex:currentQuestionIndex];

  // Log the string to the console
  NSLog(@"displaying question: %@", question);

  // Display the string in the question field
  [questionField setText:question];

  // Clear the answer field
  [answerField setText:@"???"];

}

- (IBAction) showAnswer: (id) sender {
        // What is the answer to the current question?
    NSString *answer = [answers objectAtIndex:currentQuestionIndex];
    
        // Display the answer in the answer field.
    [answerField setText:answer];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [answers release];
    [questions release];
    [answerField release];
    [questionField release];
    [window release];
    [super dealloc];
}


@end
