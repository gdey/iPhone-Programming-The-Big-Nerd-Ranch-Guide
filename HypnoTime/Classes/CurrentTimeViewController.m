//
//  CurrentTimeViewController.m
//  HypnoTime
//
//  Created by Gautam Dey on 9/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CurrentTimeViewController.h"
#import <QuartzCore/QuartzCore.h>


@implementation CurrentTimeViewController

- (id) init {
        // Call the superclass's designated initializer
    [super initWithNibName:@"CurrentTimeViewController" bundle:nil];
    dateFormatterShort = nil;
    
        // Get the tab bar item
    UITabBarItem *tbi = [self tabBarItem];
        // Get it a label
    [tbi setTitle:@"Time"];

    UIImage *i = [UIImage imageNamed:@"Time.png"];
    [tbi setImage:i];

    return self;
}

    // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    /*    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
     // Custom initialization
     }
     return self;
     */
    return [self init];
}


/*
    // Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {

    
    
    [super loadView];
    [[self view] setBackgroundColor:[UIColor redColor]];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"%@ finished: %d", anim, flag);
}

- (IBAction) showCurrentTime:(id)sender {
    NSDate *now = [NSDate date];
    
    if (!dateFormatterShort){
        dateFormatterShort = [[NSDateFormatter alloc] init];
        [dateFormatterShort setTimeStyle:NSDateFormatterShortStyle];
    }
    [timeLabel setText:[dateFormatterShort stringFromDate:now]];
    
        // Create a basic animation
    
    /*
     * Create a spin animation
     *
    CABasicAnimation *spin = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    
    [spin setToValue:[NSNumber numberWithFloat:(2.0 * M_PI)]];
    [spin setDuration:1.0];
    CAMediaTimingFunction *tf = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [spin setTimingFunction:tf];
    [spin setDelegate:self];
    [[timeLabel layer] addAnimation:spin forKey:@"spinAnimation"];
    */
    
    /* 
     * create a bounce animation
     */
    CAKeyframeAnimation *bounce = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    CAKeyframeAnimation *opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];  
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    
    [opacityAnimation setValues:[NSArray arrayWithObjects:
                                 [NSNumber numberWithFloat:1],
                                 [NSNumber numberWithFloat:0.5],
                                 [NSNumber numberWithFloat:0.3],
                                 [NSNumber numberWithFloat:0.5],
                                 [NSNumber numberWithFloat:0.3],
                                 [NSNumber numberWithFloat:1],
                                 nil]];
     
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
     
     [group setAnimations:[NSArray arrayWithObjects:
                           opacityAnimation,
                           bounce,
                           nil]];
     // st the duration
     //[bounce setDuration:0.6];
     [group setDuration:0.6];
     
     //     [[timeLabel layer] addAnimation:bounce
     //                         forKey:@"bounceAnimation"];
     [[timeLabel layer] addAnimation:group forKey:@"opacity_and_bounce"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super  viewWillAppear:animated];
    [self showCurrentTime:nil];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    NSLog(@"Must have received a low-memory warning. Releasing timeLabel");
    [timeLabel release];
    timeLabel = nil;
}


- (void)dealloc {
    [dateFormatterShort release];
    [timeLabel release];
    [super dealloc];
}


@end
