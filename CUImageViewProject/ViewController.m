//
//  ViewController.m
//  CUImageViewProject
//
//  Created by Leonard Ryan Crews on 9/1/12.
//  Copyright (c) 2012 ChipUp. All rights reserved.
//

#import "ViewController.h"

#import "CUImageView.h"


#pragma mark -
#pragma mark Twain

@interface ViewController ()


@property (nonatomic, retain) IBOutlet CUImageView * topImage;
@property (nonatomic, retain) IBOutlet UILabel * referenceLabel;


@end


#pragma mark -
#pragma mark Cuban

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    
    // The top image.
    
    [self.topImage setImageURL:[NSURL URLWithString:@"http://ryancrews.com/wp-content/uploads/2011/07/blogHeader_00.png"]];
    
    
    // The bottom image.
    
    CGRect referenceFrame = [self.referenceLabel frame];
    
    CUImageView * bottomImage = [[CUImageView alloc] initWithFrame:CGRectMake(referenceFrame.origin.x, referenceFrame.origin.y + referenceFrame.size.height + 8.0f, 280.0f, 280.0f)];
    
    [bottomImage setImageURL:[NSURL URLWithString:@"http://ryancrews.com/wp-content/uploads/2010/12/objectiveC_blogLogo_01-410x332.png"]];
    [bottomImage setClipsToBounds:YES];
    [bottomImage setContentMode:UIViewContentModeScaleAspectFit];
    [bottomImage setBackgroundColor:[UIColor blackColor]];
    
    [self.view addSubview:bottomImage];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}


@end
