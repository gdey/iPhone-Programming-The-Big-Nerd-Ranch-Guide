//
//  MediaPlayerAppDelegate.h
//  MediaPlayer
//
//  Created by Gautam Dey on 9/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface MediaPlayerAppDelegate : NSObject <AVAudioPlayerDelegate, UIApplicationDelegate> {
    UIWindow *window;
    UIButton *audioButton;
    SystemSoundID shortSound;
    AVAudioPlayer *audioPlayer;
    
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIButton *audioButton;

- (IBAction) playAudioFile:(id)sender;
- (IBAction) playVideoFile:(id)sender;
- (IBAction) playShortSound:(id)sender;

@end

