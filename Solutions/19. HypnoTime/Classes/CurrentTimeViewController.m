//
//  CurrentTimeViewController.m
//  HypnoTime
//
//  Created by Alex Silverman on 7/28/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "CurrentTimeViewController.h"
#import <QuartzCore/QuartzCore.h> 

@implementation CurrentTimeViewController

- (id)init {
	[super initWithNibName:@"CurrentTimeViewController" bundle:nil];
	
	// Get the tab bar item
	UITabBarItem *tbi = [self tabBarItem];
	
	// Give it a label
	[tbi setTitle:@"Time"];
	UIImage *i = [UIImage imageNamed:@"Time.png"];
	[tbi setImage:i];
	
	return self;
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag 
{ 
    NSLog(@"%@ finished: %d", anim, flag); 
} 

- (IBAction)showCurrentTime:(id)sender
{
    NSDate *now = [NSDate date];
    static NSDateFormatter *formatter = nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterShortStyle];
    }
    [timeLabel setText:[formatter stringFromDate:now]];

    // Create a basic animation 
    CABasicAnimation *spin = 
                [CABasicAnimation animationWithKeyPath:@"transform.rotation"]; 
    [spin setToValue:[NSNumber numberWithFloat:M_PI * 2]]; 
    [spin setDuration:1.0]; 
   
	 // Set the timing function 
    CAMediaTimingFunction *tf =  
       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]; 
    [spin setTimingFunction:tf];    
	
    [spin setDelegate:self]; 
	
    // Make it move the layer 
    [[timeLabel layer] addAnimation:spin 
                             forKey:@"spinAnimation"]; 
return;
    // Create a key frame animation 
    CAKeyframeAnimation *bounce = [CAKeyframeAnimation animationWithKeyPath:@"transform"]; 
    // Create the values it will pass through 
    CATransform3D forward = CATransform3DMakeScale(1.3, 1.3, 1); 
    CATransform3D back = CATransform3DMakeScale(0.7, 0.7, 1); 
    CATransform3D forward2 = CATransform3DMakeScale(1.2, 1.2, 1); 
    CATransform3D back2 = CATransform3DMakeScale(0.9, 0.9, 1); 
    [bounce setValues:[NSArray arrayWithObjects: 
                                [NSValue valueWithCATransform3D:CATransform3DIdentity], 
                                [NSValue valueWithCATransform3D:forward], 
                                [NSValue valueWithCATransform3D:back], 
                                [NSValue valueWithCATransform3D:forward2], 
                                [NSValue valueWithCATransform3D:back2], 
                                [NSValue valueWithCATransform3D:CATransform3DIdentity], 
                                nil]]; 
    // Set the duration 
    [bounce setDuration:0.6]; 
    // Animate the layer 
    [[timeLabel layer] addAnimation:bounce 
                                forKey:@"bounceAnimation"]; 

}

- (void)viewWillAppear:(BOOL)animated
{
	[self showCurrentTime:nil];
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
