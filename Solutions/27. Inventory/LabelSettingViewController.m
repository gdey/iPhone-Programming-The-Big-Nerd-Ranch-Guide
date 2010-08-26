//
//  LabelSettingViewController.m
//  Inventory
//
//  Created by Aaron Hillegass on 10/22/09.
//  Copyright 2009 Big Nerd Ranch. All rights reserved.
//

#import "LabelSettingViewController.h"


@implementation LabelSettingViewController

- (id)init 
{
    [super initWithNibName:nil bundle:nil];
    
    [self setTitle:@"New Record"];
    
    UIBarButtonItem *bbi;
    bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                        target:self
                                                        action:@selector(create:)];
    [[self navigationItem] setRightBarButtonItem:bbi];
    [bbi release];
    
    bbi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                        target:self
                                                        action:@selector(cancel:)];
    [[self navigationItem] setLeftBarButtonItem:bbi];
    [bbi release];
    
    return self;
}

// Override the superclass's designated initializer
- (id)initWithNibName:(NSString *)n bundle:(NSBundle *)b
{
    return [self init];
}


- (void)dealloc {
    [textField release];
    [value release];
    [super dealloc];
}


- (void)viewDidLoad
{
    [textField setAutocorrectionType:UITextAutocorrectionTypeNo];
}
- (void)viewWillAppear:(BOOL)animated
{
    [textField setText:value];
}
- (void)viewDidAppear:(BOOL)animated
{
    [textField becomeFirstResponder];
}

- (IBAction)cancel:(id)sender
{
    [self setValue:nil];
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)create:(id)sender
{
    [self setValue:[textField text]];
    [[self navigationController] popViewControllerAnimated:YES];
}

- (NSString *)value
{
    return value;
}
- (void)setValue:(NSString *)v
{
    v = [v copy];
    [value release];
    value = v;
    if (textField) {
        [textField setText:value];
    }
}

- (void)viewDidUnload 
{
    [textField release];
    textField = nil;
}


@end
