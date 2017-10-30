# ImageZoomViewer

[![Version](https://img.shields.io/cocoapods/v/ImageZoomViewer.svg?style=flat)](http://cocoapods.org/pods/ImageZoomViewer)
[![License](https://img.shields.io/cocoapods/l/ImageZoomViewer.svg?style=flat)](http://cocoapods.org/pods/ImageZoomViewer)
[![Platform](https://img.shields.io/cocoapods/p/ImageZoomViewer.svg?style=flat)](http://cocoapods.org/pods/ImageZoomViewer)

## Overview

ImageZoomViewer is a simple to use Objective C framework that allows the capability of viewing images with zoom-in zoom-out functionality. Framework also provides different types of animations. Currently, supporting only portrait mode. 

## Screenshot

![Example](https://media.giphy.com/media/l4EoSdcwlQVuQF2uY/giphy.gif)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.


## Installation

### CocoaPods

ImageZoomViewer is available through [CocoaPods](https://cocoapods.org/pods/ImageZoomViewer). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ImageZoomViewer'
```

### Manual

The source is contained inside the ```Pod/ImageZoomViewer``` folder. Simply drag these classes into your project's directory.

## Usage

### Initialization

    ImageZoomViewer * imageZoomViewer = [[ImageZoomViewer alloc]initWithBottomCollectionBorderColor:[UIColor blackColor]];
    zoomImageView.delegate = self;

### ImageZoomViewerDelegate

Your source view controllers need to implement this protocol to facilitate the transition. The protocol is as follows:

    required 
    -(void)initializeImageviewWithImages:(UIImageView *)imageview withIndexPath:(NSIndexPath *)indexPath withCollection:(int)collectionReference;

    optional 
    - (void)imageIndexOnChange:(NSInteger)index;

### AnimationType

```AnimationTypeEaseIn```
    
    [zoomImageView showWithPageIndex:0 andImagesCount:(int)images.count withInitialImageView:nil andAnimType:AnimationTypeEaseIn];
    
```AnimationTypePop```
    
    CGRect animFrame = CGRectMake(100, 100, 100, 100);
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:animFrame];
    [imgView setImage:image];
    [imageZoomViewer showWithPageIndex:imageIndex andImagesCount:(int)[images count] withInitialImageView:imgView andAnimType:AnimationTypePop];
    
### Dismiss
     [zoomImageView closeZoomViewer];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"CLOSE_IMAGE_ZOOM_VIEWER" object:nil];


## Requirements

- iOS 7.0 or higher


## Author

Anubhav Mathur, anubhav.mathur@grofers.com

## License

ImageZoomViewer is available under the MIT license. See the LICENSE file for more info.
