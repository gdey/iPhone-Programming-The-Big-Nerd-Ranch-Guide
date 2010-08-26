//
//  QuizAppDelegate.m
//  Quiz
//
//  Created by Alex Silverman on 7/28/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import "QuizAppDelegate.h"

@implementation QuizAppDelegate

@synthesize window;

- (id)init
{
	// Call the init method implemented by the
	[super init];
	
	// Create two arrays and make the pointers
	questions = [[NSMutableArray alloc] init];
	answers = [[NSMutableArray alloc] init];
	
	// Add questions and answers to the arrays
	[questions addObject:@"What is 7 + 7?"];
	[answers addObject:@"14"];
	
	[questions addObject:@"What is the capital of Vermont?"];
	[answers addObject:@"Montpelier"];
	
	[questions addObject:@"From what is cognac made?"];
	[answers addObject:@"Grapes"];
	
	// Return the address of the new object
	return self;
}

- (IBAction)showQuestion:(id)sender
{	
	// Step to the next question - just to keep things simple
	// to focus on the iOS elements of the programming,
	// we will start with the "second" question in the list.
	currentQuestionIndex++;
	
	// Am I past the last question?
	if (currentQuestionIndex == [questions count]) {
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

- (IBAction)showAnswer:(id)sender
{
	// What is the answer to the current question?
	NSString *answer = [answers objectAtIndex:currentQuestionIndex];
	
	// Display it in the answer field
	[answerField setText:answer];
}


- (BOOL)application:(UIApplication *)application 
	didFinishLaunchingWithOptions:(NSDictionary *)launchOptions  
{
    [window makeKeyAndVisible];
	return YES;
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
