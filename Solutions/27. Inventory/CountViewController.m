//
//  CountViewController.m
//  Inventory
//
//  Created by Aaron Hillegass on 10/22/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "CountViewController.h"


@implementation CountViewController

@synthesize asset, location, count;

- (id)init
{
    [super initWithNibName:nil bundle:nil];
    
    UIBarButtonItem *bbi;
    bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                        target:self
                                                        action:@selector(update:)];
    [[self navigationItem] setRightBarButtonItem:bbi];
    [bbi release];
    
    bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                        target:self
                                                        action:@selector(cancel:)];
    [[self navigationItem] setLeftBarButtonItem:bbi];
    [bbi release];
    
    [self setTitle:@"Update Count"];
    
    return self;
}

- (id)initWithNibName:(NSString *)n bundle:(NSBundle *)b
{
    return [self init];
}


- (void)dealloc 
{
    [numberField release];
    [promptField release];
    [count release];
    [asset release];
    [location release];
    [super dealloc];
}


- (void)updateInteface
{
    NSString *prompt = [NSString stringWithFormat:@"%@: %@", 
                        [asset valueForKey:@"label"], 
                        [location valueForKey:@"label"]];
    
    [promptField setText:prompt];
    [numberField setText:[count stringValue]];
}

#pragma mark View Controller Lifecycle

- (void)viewDidLoad 
{
    [self updateInteface];
    [numberField becomeFirstResponder];
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [numberField release];
    numberField = nil;
    [promptField release];
    promptField = nil;
}

#pragma mark Actions

- (IBAction)update:(id)sender
{
    NSString *countString = [numberField text];
    int countInt = [countString intValue];
    [self setCount:[NSNumber numberWithInt:countInt]];
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)cancel:(id)sender
{
    [self setCount:nil];
    [[self navigationController] popViewControllerAnimated:YES];
}


@end
