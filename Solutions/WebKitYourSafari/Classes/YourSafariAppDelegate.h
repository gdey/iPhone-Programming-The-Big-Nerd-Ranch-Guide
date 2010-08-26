//
//  YourSafariAppDelegate.h
//  YourSafari
//
//  Created by Alex Silverman on 7/28/09.
//  Copyright Big Nerd Ranch 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YourSafariAppDelegate : NSObject <UIApplicationDelegate, UITextFieldDelegate, UIWebViewDelegate> {
    IBOutlet UITextField *textField;
	IBOutlet UIWebView *webView;
	UIActivityIndicatorView *activityIndicator;
	IBOutlet UIBarButtonItem *refreshButton;
	IBOutlet UIBarButtonItem *forwardButton;
	IBOutlet UIBarButtonItem *backButton;
	IBOutlet UIBarButtonItem *stopButton;
	UIWindow *window;
}
@property (nonatomic, retain) IBOutlet UIWindow *window;

- (IBAction)refresh:(id)sender;
- (IBAction)forward:(id)sender;
- (IBAction)back:(id)sender;
- (IBAction)stop:(id)sender;

@end

