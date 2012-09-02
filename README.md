CUImageView
===========

An UIImageView class that encapsulates loading an image from a URL.

Why was this made?
------------------

A friend asked me why UIImageView didn't accept an image URL, and I couldn't think of a great reason as to why it shouldn't.  From that conversation this was born, a very simple class that will take in an image URL and set its own image property to the result (assuming the load was successful).  While it's making the request it shows a loading background and activity indicator.

How's this used?
----------------

The project shows two examples, a nib file usage and a pure code usage.  The gist of the usage being you either call:
```objective-c
CUImageView * myImageView = [[CUImageView alloc] initWithImageURL:[NSURL URLWithString:@"myImageURL"]];
```


OR

```objective-c
[_myImageView setImageURL:[NSURL URLWithString:@"myImageURL"]];
```

That's it.  There's also a "cancelDownload" method present should you find yourself in a situation where you no longer desire the image view to download the image.  All other UIImageView methods and properties exist and function as expected, with a slight exception for setBackgroundColor:, which will only set the background color if the image view is not currently loading an image (otherwise it waits until the loading is complete [or fails] to update the background color).