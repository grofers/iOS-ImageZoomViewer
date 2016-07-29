//
//  IZVMainCollectionViewCell.m
//
//
//  Created by Anubhav Mathur on 20/08/15.
//  Copyright (c) 2015. All rights reserved.
//

#import "IZVMainCollectionViewCell.h"

@implementation IZVMainCollectionViewCell

//- (id)initWithStyle:(UIcollectionviewcells)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}



- (void)awakeFromNib {
    // Initialization code

    self.scrollView.minimumZoomScale=1;
    self.scrollView.maximumZoomScale=3.0;
    self.scrollView.translatesAutoresizingMaskIntoConstraints = YES;
    self.scrollView.delegate=self;
    self.scrollView.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 170);
    
    UITapGestureRecognizer *singleTapGR, *doubleTapGR;

    doubleTapGR = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                          action:@selector(myDoubleTapHandler)];
    doubleTapGR.numberOfTapsRequired = 2;
    [singleTapGR requireGestureRecognizerToFail:doubleTapGR];

    [self.scrollView addGestureRecognizer:doubleTapGR];
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
   

    self.scrollView.clipsToBounds = YES;
    self.imgview.translatesAutoresizingMaskIntoConstraints = YES;
    self.imgview.contentMode = UIViewContentModeScaleAspectFit;
    self.imgview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 170);
  
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imgview;
}
-(void)myDoubleTapHandler{

    if(self.zoomed){

        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{ [self.scrollView setZoomScale:1.0f animated:NO]; }
                         completion:nil];
        
        self.zoomed = NO;
    }
    else{
        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{ [self.scrollView setZoomScale:3.0f animated:NO]; }
                         completion:nil];

        self.zoomed = YES;
    
    }

}


@end
