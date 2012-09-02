//
//  CUImageView.m
//  A Chip Up Original
//
//
//  An UIImageView class that encapsulates the
//  aquiring of an image from an URL.  Normal
//  UIImageView operations also exist (obviously).
//
//
//  Created by L. Ryan Crews on 9/1/12.
//  Copyright (c) 2012 ChipUp, but please use it
//      leave this, attribute something, have fun.
//
//  ... perhaps a real license should be put here?
//

#import "CUImageView.h"


#pragma mark -
#pragma mark Privateering

@interface CUImageView ()


@property (nonatomic, retain) UIActivityIndicatorView * loadingIndicator;
@property (nonatomic, retain) NSMutableData * responseData;


@end


#pragma mark -
#pragma mark Implemeering

@implementation CUImageView
{
    UIColor * originalBackgroundColor_;
    NSURLConnection * urlConnection_;
    
    BOOL requestInProgress_;
}


static UIImage * loadingBackground = nil;


+ (void)initialize
{
    if (self == [CUImageView class])
    {
        loadingBackground = [UIImage imageNamed:@"LoadingBackground.png"];  // You should likely replace this with a patterned image more befitting your app.
    }
}


- (id)initWithImageURL:(NSURL *)url;
{
    self = [super init];
    
    if (self)
    {
        [self setImageURL:url];
    }
    
    return self;
}


#pragma mark -
#pragma mark Canceleering

- (void)cancelDownload;
{
    if (urlConnection_)
    {
        [urlConnection_ cancel];
        urlConnection_ = nil;
    }
}


#pragma mark -
#pragma mark Accesseering

- (void)setFrame:(CGRect)givenFrame
{
    [super setFrame:givenFrame];
    
    [self.loadingIndicator setCenter:CGPointMake(givenFrame.size.width / 2.0f, givenFrame.size.height / 2.0f)];
    [self addSubview:[self loadingIndicator]];
}


- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    if (requestInProgress_)
    {
        originalBackgroundColor_ = backgroundColor; // loading background is being shown, will change to this on complete/fail.
    }
    else
    {
        [super setBackgroundColor:backgroundColor];
    }
}


- (void)setImageURL:(NSURL *)newImageURL
{
    if (_imageURL != newImageURL)
    {
        _imageURL = newImageURL;
        
        
        // Show the 'loading state' of the view
        
        originalBackgroundColor_ = [self backgroundColor];
        
        [self setBackgroundColor:[UIColor colorWithPatternImage:loadingBackground]];
        [self.loadingIndicator startAnimating];
        
        
        // Aquire the image
        
        requestInProgress_ = YES;
        
        [self.responseData resetBytesInRange:NSMakeRange(0, _responseData.length)];
        
        if (urlConnection_)
        {
            [urlConnection_ cancel];
            urlConnection_ = nil;
        }
        urlConnection_ = [[NSURLConnection alloc] initWithRequest:[NSURLRequest requestWithURL:_imageURL]
                                                         delegate:self];
    }
}


- (UIActivityIndicatorView *)loadingIndicator
{
    if (_loadingIndicator == nil)
    {
        // You may want to update the style based on the loading image you used.
        
        _loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [_loadingIndicator setHidesWhenStopped:YES];
    }
    
    return _loadingIndicator;
}


- (NSMutableData *)responseData
{
    if (_responseData == nil)
    {
        _responseData = [[NSMutableData alloc] init];
    }
    
    return _responseData;
}


#pragma mark -
#pragma mark NSURLConnectionDataDelegate Methods

- (void)connection:(NSURLConnection *)connection
    didReceiveData:(NSData *)data
{
    [self.responseData appendData:data];
}


- (void)connection:(NSURLConnection *)connection
  didFailWithError:(NSError *)error
{
    requestInProgress_ = NO;
    
    [self.loadingIndicator stopAnimating];
    [self setBackgroundColor:originalBackgroundColor_];
    
    // Perhaps you'd like to set a defualt image here?
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    requestInProgress_ = NO;
    
    [self.loadingIndicator stopAnimating];
    [self setBackgroundColor:originalBackgroundColor_];
    
    [self setImage:[[UIImage alloc] initWithData:[self responseData]]];
    
    
    // set the response to a cache here, if you want, if the design so desires, if the stars align in such a way that you find it hard to deny that cache rules everything around you.  ... dollar dollar bills 'yall.
}


@end
