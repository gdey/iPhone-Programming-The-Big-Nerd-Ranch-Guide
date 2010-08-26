//
//  NayberzAppDelegate.m
//  Nayberz
//
//  Created by Joe Conway on 7/27/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import "NayberzAppDelegate.h"
#import "TableController.h"

@implementation NayberzAppDelegate

@synthesize window;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Create an instance of NSNetService 
    netService = [[NSNetService alloc] initWithDomain:@"" 
                                                 type:@"_nayberz._tcp." 
                                                 name:[[UIDevice currentDevice] name] 
                                                 port:9090]; 
    // As the delegate, you will know if the publish is successful 
    [netService setDelegate:self]; 
        
	// Get the shared instance of NSUserDefaults 
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults]; 
    
    // Ask for the message string 
    NSString *messageString = [ud stringForKey:@"BNRMessagePrefKey"]; 


    // Pack the string into an NSData 
    NSData *d = [messageString dataUsingEncoding:NSUTF8StringEncoding]; 
    // Put the data in a dictionary 
    NSDictionary *txtDict = [NSDictionary dictionaryWithObject:d forKey:@"message"]; 
    // Pack the dictionary into an NSData 
    NSData *txtData = [NSNetService dataFromTXTRecordDictionary:txtDict]; 
    // Put that data into the net service 
    [netService setTXTRecordData:txtData]; 
  
    // Try to publish it 
    [netService publish]; 

    tableController = [[TableController alloc] init]; 
    UIView *v = [tableController view]; 
    [v setFrame:[window bounds]]; 
    [window addSubview:v]; 
    [application setStatusBarHidden:YES]; 


    [window makeKeyAndVisible];
	return YES;
}
+ (void)initialize
{
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *pListPath = [path 
                stringByAppendingPathComponent:@"Settings.bundle/Root.plist"];
        
    NSDictionary *pList = [NSDictionary dictionaryWithContentsOfFile:pListPath];
	
    NSMutableArray *prefsArray = [pList objectForKey:@"PreferenceSpecifiers"];
    NSMutableDictionary *regDictionary = [NSMutableDictionary dictionary];
    for (NSDictionary *dict in prefsArray) {
        NSString *key = [dict objectForKey:@"Key"];
        if (key) {
            id value = [dict objectForKey:@"DefaultValue"];
            [regDictionary setObject:value forKey:key];
        }
    }
    [[NSUserDefaults standardUserDefaults] registerDefaults:regDictionary];
}
- (void)netServiceDidPublish:(NSNetService *)sender 
{ 
    NSLog(@"published: %@", sender); 
} 
- (void)netService:(NSNetService *)sender didNotPublish:(NSDictionary *)errorDict 
{ 
    NSLog(@"not published: %@ -> %@", sender, errorDict); 
} 
- (void)applicationWillTerminate:(UIApplication *)application 
{ 
    [netService stop]; 
} 


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
