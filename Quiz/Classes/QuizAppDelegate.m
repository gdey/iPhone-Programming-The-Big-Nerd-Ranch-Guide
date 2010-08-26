//
//  QuizAppDelegate.m
//  Quiz
//
//  Created by Gautam Dey on 8/22/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "QuizAppDelegate.h"

@implementation QuizAppDelegate

@synthesize window;
@synthesize questionField;
@synthesize answerField;

#pragma mark -
#pragma mark Application lifecycle

- (id) init {
    [super init];
    questions = [[NSMutableArray alloc] initWithCapacity:3];
    answers   = [[NSMutableArray alloc] initWithCapacity:3];
    
        // Add questions and answers
    [questions addObjectsFromArray:[NSArray arrayWithObjects:@"What is 7 + 7?", @"What is the capitol of Vermont?",@"From what is cognac made?", nil]];
    [answers addObjectsFromArray:[NSArray arrayWithObjects:@"14",@"Montpelier",@"Grapes",nil]];
    
    return self;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	
        
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}

- (IBAction) showQuestion:(id)sender {
        // Step to the 
    currentQuestionIndex++;
    if (currentQuestionIndex == [questions count]) {
        currentQuestionIndex = 0;
    }
    
    NSString *question = [questions objectAtIndex:currentQuestionIndex];
    
    NSLog(@"displaying question %@",question);
    [questionField setText:question];
    [answerField setText:@"???"];
    
    
    
}

- (IBAction) showAnswer:(id)sender {
    
    NSString *answer = [answers objectAtIndex:currentQuestionIndex];
    [answerField setText:answer];
    
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [questions release];
    [answers release];
    [super dealloc];
}


@end
