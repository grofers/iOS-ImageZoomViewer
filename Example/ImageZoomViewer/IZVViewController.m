//
//  IZVViewController.m
//  ImageZoomViewer
//
//  Created by Anubhav Mathur on 06/16/2016.
//  Copyright (c) 2016 Anubhav Mathur. All rights reserved.
//

#import "IZVViewController.h"


#import "UIImageView+WebCache.h"

@interface IZVViewController ()
{

    NSMutableArray * images;
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
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)showGallery:(id)sender{

    ImageZoomViewer * zoomImageView = [[ImageZoomViewer alloc]initWithBottomCollectionBorderColor:[UIColor blackColor]];
   
    [ zoomImageView.closeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    zoomImageView.delegate = self;

    [zoomImageView showWithPageIndex:0 andImagesCount:(int)images.count withInitialImageView:nil andAnimType:AnimationTypeEaseIn];


}

# pragma Mark - ImageZoomViewer Delegates


-(void)initializeImageviewWithImages:(UIImageView *)imageview withIndexPath:(NSIndexPath *)indexPath withCollection:(int)collectionReference{

    NSString * urlString = [images objectAtIndex:indexPath.row];
    [imageview sd_setImageWithURL:[NSURL URLWithString:urlString]];


}
@end
