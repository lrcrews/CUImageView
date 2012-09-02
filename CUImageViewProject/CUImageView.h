//
//  CUImageView.h
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

#import <UIKit/UIKit.h>


@interface CUImageView : UIImageView <NSURLConnectionDataDelegate>


@property (nonatomic, retain) NSURL * imageURL;


- (id)initWithImageURL:(NSURL *)url;

- (void)cancelDownload;  // If your view scrolls off screen, it's super view enters a reuse queue, the page it's on is being poped from the navigation controller, etc., etc., whatever case no longer requires this image to be downloaded please be kind to your user's time and data plan.  Cancel your download.


@end
