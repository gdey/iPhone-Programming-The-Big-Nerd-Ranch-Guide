//
//  MediaPlayerAppDelegate.m
//  MediaPlayer
//
//  Created by Joe Conway on 7/27/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import "MediaPlayerAppDelegate.h"

@implementation MediaPlayerAppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	NSString *soundPath = [[NSBundle mainBundle] pathForResource:@"Sound12"
                                                          ofType:@"aif"];
    // If this file is actually in the bundle...
    if(soundPath)
    {
        // Create a file URL with this path
        NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
    
        // Register sound file located at that URL as a system sound
        OSStatus err = AudioServicesCreateSystemSoundID((CFURLRef)soundURL, &shortSound);
		if(err != kAudioServicesNoError) 
			NSLog(@"Could not load %@, error code: %d", soundURL, err);
	}

    // Obtain full path in NSURL format to Music.mp3 
    NSString *moviePath = [[NSBundle mainBundle] pathForResource:@"Layers" 
                                                          ofType:@"m4v"];
    if(moviePath) {
        NSURL *movieURL = [NSURL fileURLWithPath:moviePath];
        moviePlayer = [[MPMoviePlayerController alloc] 
                                initWithContentURL:movieURL];
    }
	
	NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"Music"
                                                          ofType:@"mp3"];
    if(musicPath)
    {
        NSURL *musicURL = [NSURL fileURLWithPath:musicPath];	
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL 
                                                         error:nil];
		[audioPlayer setDelegate:self];
    }	
	
	[window makeKeyAndVisible];
	return YES;
}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player 
                       successfully:(BOOL)flag 
{ 
    [audioButton setTitle:@"Play Audio File" 
                 forState:UIControlStateNormal]; 
} 
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player 
{ 
    [audioPlayer play]; 
} 

- (void)dealloc 
{
	[audioPlayer release];
	[moviePlayer release];
	AudioServicesDisposeSystemSoundID(shortSound);
	[audioButton release];
    [window release];
    [super dealloc];
}
- (IBAction)playAudioFile:(id)sender 
{ 
    if ([audioPlayer isPlaying]) { 
        // Stop playing audio and change text of button 
        [audioPlayer stop]; 
        [sender setTitle:@"Play Audio File" 
                forState:UIControlStateNormal]; 
    } 
    else { 
        // Start playing audio and change text of button so user can tap to stop playback 
        [audioPlayer play]; 
        [sender setTitle:@"Stop Audio File" 
                forState:UIControlStateNormal]; 
    } 
} 

- (IBAction)playVideoFile:(id)sender 
{ 
    [moviePlayer play]; 
} 

- (IBAction)playShortSound:(id)sender 
{ 
    AudioServicesPlaySystemSound(shortSound); 
} 

- (void)applicationWillTerminate:(UIApplication*)app 
{ 
    AudioServicesDisposeSystemSoundID(shortSound); 
} 


@end
