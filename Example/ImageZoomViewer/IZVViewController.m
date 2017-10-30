//
//  IZVViewController.m
//  ImageZoomViewer
//
//  Created by Anubhav Mathur on 06/16/2016.
//  Copyright (c) 2016 Anubhav Mathur. All rights reserved.
//

#import "IZVViewController.h"


#import "UIImageView+WebCache.h"
#import "IZVAppDelegate.h"

@interface IZVViewController ()
{
    __weak IBOutlet UIImageView *thumbImageView;
    NSMutableArray *images;
    NSInteger currentIndex;
}
@end


@implementation IZVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    images = [[NSMutableArray alloc]init];
    [images addObject:@"https://pixabay.com/static/uploads/photo/2015/04/16/10/19/wolf-725380_960_720.jpg"];
    [images addObject:@"https://pixabay.com/static/uploads/photo/2014/08/22/14/09/bear-424383_960_720.jpg"];
    [images addObject:@"https://pixabay.com/static/uploads/photo/2015/03/02/00/17/panda-655491_960_720.jpg"];
    thumbImageView.layer.borderWidth = 1.0;
    [thumbImageView.layer setBorderColor:[UIColor orangeColor].CGColor];
    currentIndex = 0;
    [thumbImageView sd_setImageWithURL:[NSURL URLWithString:[images firstObject]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)thumbImageClicked:(id)sender
{
    ImageZoomViewer *zoomImageView = [[ImageZoomViewer alloc]initWithBottomCollectionBorderColor:[UIColor orangeColor]];
    [ zoomImageView.closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    zoomImageView.delegate = self;
    IZVAppDelegate *appDelegate = (IZVAppDelegate *)[[UIApplication sharedApplication] delegate];
    CGPoint point = [self.view convertPoint:thumbImageView.frame.origin toView:appDelegate.window];
    CGRect animFrame = CGRectMake(point.x, point.y, thumbImageView.frame.size.width, thumbImageView.frame.size.height);
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:animFrame];
    [imgView sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:currentIndex]]];
    [zoomImageView showWithPageIndex:currentIndex andImagesCount:images.count withInitialImageView:imgView andAnimType:AnimationTypePop];
}

- (IBAction)showGallery:(id)sender
{
    ImageZoomViewer *zoomImageView = [[ImageZoomViewer alloc]initWithBottomCollectionBorderColor:[UIColor blackColor]];
    [zoomImageView.closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    zoomImageView.delegate = self;
    [zoomImageView showWithPageIndex:0 andImagesCount:(int)images.count withInitialImageView:nil andAnimType:AnimationTypeEaseIn];
}

# pragma Mark - ImageZoomViewer Delegates

- (void)initializeImageviewWithImages:(UIImageView *)imageview withIndexPath:(NSIndexPath *)indexPath withCollection:(int)collectionReference
{
    NSString *urlString = [images objectAtIndex:indexPath.row];
    [imageview sd_setImageWithURL:[NSURL URLWithString:urlString]];
}

- (void)imageIndexOnChange:(NSInteger)index
{
    currentIndex = index;
    [thumbImageView sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:currentIndex]]];
}

@end
