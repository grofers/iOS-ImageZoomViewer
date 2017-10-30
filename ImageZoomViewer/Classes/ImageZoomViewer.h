//
//  ImageZoomViewer.h
//  
//
//  Created by Anubhav Mathur on 20/08/15.
//  Copyright (c) 2015. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IZVMainCollectionViewCell.h"

typedef NS_ENUM(NSUInteger,AnimationType){
    
    AnimationTypeEaseIn,
    AnimationTypePop
    
};

@class ImageZoomViewer;
@protocol ImageZoomViewerDelegate <NSObject>

@required
// For every indexpath like collection this will get call apply images on these UIImageview
-(void)initializeImageviewWithImages:(UIImageView *)imageview withIndexPath:(NSIndexPath *)indexPath withCollection:(int)collectionReference;

@optional
// When image swiped it will return the current image index
- (void)imageIndexOnChange:(NSInteger)index;

@end

@interface ImageZoomViewer : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>

// Delegate property
@property (nonatomic, weak) id<ImageZoomViewerDelegate> delegate;

// Close Button (Modify close button as per view needed by default it will be a close text)
@property (nonatomic, weak) IBOutlet UIButton *closeBtn;

/*
 initializeMethod
 *******
 bottomBorderColor
 : border color for bottom collection cell for the selected cell;
 *******
 */
-(id)initWithBottomCollectionBorderColor:(UIColor *)bottomBorderColor;

/*
 Show method
 ********
 pdIndex
 : index for showing particular index image
 ********
 
 ********
 totalImagesCount
 : Number images need to be shown
 ********
 
 ********
 imgView
 : If you are using AnimationTypePop send a UIImageview object with image set to it that will animate initially
 ********
 
 ********
 AnimationType
 : There are two type of animation AnimationTypePop and AnimationTypeEaseIn (Note. if you are using AnimationTypeEase In send imgView as nil only)
 ********
 */
- (void)showWithPageIndex:(NSInteger)pgIndex andImagesCount:(NSInteger)totalImagesCount withInitialImageView:(UIImageView *)imgView andAnimType:(AnimationType)animType;

/*
 Close method
 ********
 (Can also be close via NSNotification "CLOSE_IMAGE_ZOOM_VIEWER")
 ********
 */
- (void)closeZoomViewer;

@end
