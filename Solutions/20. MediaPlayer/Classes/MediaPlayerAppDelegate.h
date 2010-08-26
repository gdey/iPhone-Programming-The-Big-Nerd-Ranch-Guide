//
//  MediaPlayerAppDelegate.h
//  MediaPlayer
//
//  Created by Joe Conway on 7/27/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h> 
#import <AVFoundation/AVFoundation.h> 
#import <MediaPlayer/MediaPlayer.h> 

@interface MediaPlayerAppDelegate : NSObject 
    <UIApplicationDelegate, AVAudioPlayerDelegate> 
{
	AVAudioPlayer *audioPlayer; 
	MPMoviePlayerController *moviePlayer; 
	SystemSoundID shortSound; 

	IBOutlet UIButton *audioButton; 
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
- (IBAction)playAudioFile:(id)sender; 
- (IBAction)playVideoFile:(id)sender; 
- (IBAction)playShortSound:(id)sender; 

@end

