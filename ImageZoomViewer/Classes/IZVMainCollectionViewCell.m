//
//  IZVMainCollectionViewCell.m
//
//
//  Created by Anubhav Mathur on 20/08/15.
//  Copyright (c) 2015. All rights reserved.
//

#import "IZVMainCollectionViewCell.h"

@implementation IZVMainCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Initialization code
    self.scrollView.minimumZoomScale=1;
    self.scrollView.maximumZoomScale=3.0;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = YES;
    self.scrollView.delegate=self;
    UITapGestureRecognizer *singleTapGR, *doubleTapGR;

    doubleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myDoubleTapHandler)];
    doubleTapGR.numberOfTapsRequired = 2;
    [singleTapGR requireGestureRecognizerToFail:doubleTapGR];

    [self.scrollView addGestureRecognizer:doubleTapGR];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.clipsToBounds = YES;
    
    self.imgview.translatesAutoresizingMaskIntoConstraints = YES;
    self.imgview.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)updateCellWithViewRect:(CGRect)rect margins:(CGFloat)topBottomMargin
{
     self.scrollView.frame = CGRectMake(0, 0,rect.size.width, rect.size.height - topBottomMargin);
    [self.imgview setFrame:self.scrollView.frame];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imgview;
}

-(void)myDoubleTapHandler
{
    if(self.zoomed) {
        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{ [self.scrollView setZoomScale:1.0f animated:NO]; }
                         completion:nil];
        self.zoomed = NO;
    } else {
        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{ [self.scrollView setZoomScale:3.0f animated:NO]; }
                         completion:nil];
        self.zoomed = YES;
    }
}

@end
