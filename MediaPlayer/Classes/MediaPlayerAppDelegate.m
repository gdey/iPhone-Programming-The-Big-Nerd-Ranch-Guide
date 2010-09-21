//
//  MediaPlayerAppDelegate.m
//  MediaPlayer
//
//  Created by Gautam Dey on 9/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MediaPlayerAppDelegate.h"

@implementation MediaPlayerAppDelegate

@synthesize window, audioButton;

#pragma mark -
#pragma mark Helper Functions

- (NSString *)pathInTempDirctory:(NSString *)s {
    NSString *dir = NSTemporaryDirectory();
    return [dir stringByAppendingPathComponent:s];
}

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    

        // Get the full path to the system sound
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"Sound12" ofType:@"aif"];
    if (soundPath) {
        NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
        OSStatus err = AudioServicesCreateSystemSoundID((CFURLRef)soundURL, &shortSound);
        if (err != kAudioServicesNoError) {
            NSLog(@"Could not load %@, error code: %d",soundURL, err);
        }
    }
    
    
        // Audio Player
    NSString *musicPath =[[NSBundle mainBundle] pathForResource:@"Music" ofType:@"mp3"];
    if (musicPath) {
        NSURL *musicURL = [NSURL fileURLWithPath:musicPath];
        
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL error:nil];
        [audioPlayer setDelegate:self];
    }
    
        //Movie Player
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"Layers" ofType:@"m4v"];
    if (moviePath) {
        NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
        NSLog(@"Movie at %@",movieURL);
        moviePlayer = [[MPMoviePlayerViewController alloc] initWithContentURL:movieURL];
    }
    
    NSString *recordingPath = [self pathInTempDirctory:@"recording.ima4"];
    if (recordingPath) {
        NSURL *recordingURL = [NSURL fileURLWithPath:recordingPath];
        NSLog(@"Recording at %2",recordingURL);
        NSError *err;
        NSDictionary *settings = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithFloat: 44100.0],                 AVSampleRateKey,
                                  [NSNumber numberWithInt: kAudioFormatAppleIMA4], AVFormatIDKey,
                                  [NSNumber numberWithInt: 1],                         AVNumberOfChannelsKey,
                                  [NSNumber numberWithInt: AVAudioQualityLow],         AVEncoderAudioQualityKey,
                                  nil];
        audioRecorder = [[AVAudioRecorder alloc] initWithURL:recordingURL settings:settings error:&err];
        if (!audioRecorder) {
            NSLog(@"Got error: %@",err);
        }
        [audioRecorder prepareToRecord];
    }
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


#pragma mark -
#pragma mark Actions 

- (IBAction)playAudioFile:(id)sender {

    NSLog(@"Play Audio File");
    
    if([audioPlayer isPlaying]){
            // Stop playing the music
        [audioPlayer stop];
        [sender setTitle:@"Play Audio File" forState:UIControlStateNormal];
        
    } else {
        [audioPlayer play];
        [sender setTitle:@"Stop Audio File" forState:UIControlStateNormal];
    }

    
}

- (IBAction) playVideoFile:(id)sender {
    NSLog(@"Play video file");
        //[[moviePlayer view] setFrame:[[self window] bounds]];
        //[[self window] addSubview:[moviePlayer view]];
    [[moviePlayer moviePlayer] play];
}

- (IBAction) playShortSound:(id)sender{
    AudioServicesPlaySystemSound(shortSound);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (IBAction) recordAudio:(id)sender {
    NSLog(@"Going to record audio");
    if ([audioRecorder isRecording]) {
        [sender setTitle:@"Record Audio" forState:UIControlStateNormal];
        [audioRecorder stop];
        NSLog(@"Playing it back");
        AVAudioPlayer *ap = [[AVAudioPlayer alloc] initWithContentsOfURL:[audioRecorder url] error:nil];
        [ap play];
        [ap setDelegate:self];
    }else {
        [audioRecorder record];
        [sender setTitle:@"Stop Recording" forState:UIControlStateNormal];
    }
    

}
#pragma mark -
#pragma mark AVAudioFoundation Delegate Methods
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    if(player == audioPlayer){
        [audioButton setTitle:@"Play Audio File" forState:UIControlStateNormal];
    } else {
        [player release];
    }
}

- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player {
    [player play];
}

#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [moviePlayer release];
    [audioPlayer release];
    [audioRecorder release];
    [audioButton release];
    [window release];
    [super dealloc];
}


@end
