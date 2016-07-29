//
//  ImageZoomViewer.m
//
//
//  Created by Anubhav Mathur on 20/08/15.
//  Copyright (c) 2015. All rights reserved.
//

#import "ImageZoomViewer.h"
#import "IZVMainCollectionViewCell.h"
#import "IZVSubCollectionViewCell.h"

// Cell Identifiers
static NSString * mainCollectionCellID = @"CellIdentifier";
static NSString * subCollectionCellID = @"subCellIdentifier";

@interface ImageZoomViewer (){
    
    IBOutlet UICollectionView *  mainCollection;
    IBOutlet UICollectionView * subCollection;
    UIColor * borderColor;
    int imagesCount;
    NSInteger  selectionIndex;
    id applicationDelagate;
    UIWindow *foregroundWindow;
    UIImageView * animImageview;
    CGRect initialFrame;
    IBOutlet NSLayoutConstraint * subCollectionTopConst;
    AnimationType  animationType;

}
@end


@implementation ImageZoomViewer


- (void)awakeFromNib{

    [mainCollection registerNib:[UINib nibWithNibName:@"IZVMainCollectionViewCell" bundle:[NSBundle bundleForClass:[IZVMainCollectionViewCell class]]] forCellWithReuseIdentifier:mainCollectionCellID];
    [subCollection registerNib:[UINib nibWithNibName:@"IZVSubCollectionViewCell" bundle:[NSBundle bundleForClass:[IZVSubCollectionViewCell class]]] forCellWithReuseIdentifier:subCollectionCellID];
    
}


- (id)initWithBottomCollectionBorderColor:(UIColor *)bottomBorderColor{

    self = [[[NSBundle bundleForClass:self.class]loadNibNamed:@"ImageZoomViewer" owner:self options:nil] firstObject];
    
    if (self)
    {
        
        // Initializing
        [self initializeWindowifNotPresent];
        [self setFrame:foregroundWindow.bounds];
        
        borderColor = bottomBorderColor;
        imagesCount = 0;
        
        
    }

    return self;

}

-(void)initializeWindowifNotPresent{


    if (!foregroundWindow) {
        
        foregroundWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        foregroundWindow.backgroundColor = [UIColor whiteColor];
        foregroundWindow.windowLevel = UIWindowLevelAlert;

    }
}

- (void)moveToCurrentIndex{

    [mainCollection reloadData];
    [subCollection reloadData];
    NSIndexPath *indxPath = [NSIndexPath indexPathForRow:selectionIndex inSection:0] ;
    [mainCollection scrollToItemAtIndexPath:indxPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    [subCollection scrollToItemAtIndexPath:indxPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

- (void)showWithBounce{
    
    mainCollection.hidden = subCollection.hidden = self.closeBtn.hidden = YES;
    foregroundWindow.alpha = 0.9;
    foregroundWindow.hidden = NO;
    
    __weak typeof(self) wSelf = self;
    
    initialFrame = animImageview.frame;
    __weak UIImageView * wAnimImgView = animImageview;
    
    __block CGRect originalFrame = CGRectMake(0, mainCollection.frame.origin.y+5, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 170);
    
    __block CGRect animFrame = CGRectMake(0,mainCollection.frame.origin.y+5, [UIScreen mainScreen].bounds.size.width + 2, [UIScreen mainScreen].bounds.size.height - 170 + 2);
    
    [UIView animateWithDuration:0.20 animations:^{
        foregroundWindow.alpha = 1.0;
        wAnimImgView.frame = originalFrame;
        
    } completion:^(BOOL finished) {
        subCollection.hidden = NO;
        [UIView animateWithDuration:0.010 animations:^{
            wAnimImgView.frame = animFrame;
            
        } completion:^(BOOL finished) {
            
            subCollection.hidden = self.closeBtn.hidden = NO;
            
            [UIView animateWithDuration:0.10 animations:^{
                wAnimImgView.frame = originalFrame;
                subCollectionTopConst.constant = 10;
                [wSelf layoutIfNeeded];
                
            } completion:^(BOOL finished) {
                
                [wAnimImgView setHidden:YES];
                
                mainCollection.hidden = NO;
                
            }];
        }];
        
    }];


}

- (void)showWithEaseIn{


    mainCollection.hidden = subCollection.hidden = self.closeBtn.hidden = NO;
    subCollectionTopConst.constant = 10;
    [self layoutIfNeeded];
    foregroundWindow.alpha = 0.9;
    foregroundWindow.hidden = NO;
    __weak typeof(self) wSelf = self;
    self.alpha = 0.0;
    [UIView animateWithDuration:0.25 animations:^{
        foregroundWindow.alpha = 1.0;
        wSelf.alpha = 1.0;
      
    } completion:^(BOOL finished) {
        
    }];

}

- (void)hideWithEaseOut{
    
    __weak typeof(self) wSelf = self;
    
    [UIView animateWithDuration:0.4 animations:^{
        
        foregroundWindow.alpha = 0.0;
        wSelf.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        foregroundWindow.hidden = YES;
        [wSelf removeFromSuperview];
        foregroundWindow = nil;
        
    }];

}



-(void)showWithPageIndex:(int)pgIndex andImagesCount:(int)totalImagesCount withInitialImageView:(UIImageView *)imgView andAnimType:(AnimationType)animType{

    [self initializeWindowifNotPresent];
    
    [foregroundWindow addSubview:self];
    
    imagesCount = totalImagesCount;
    selectionIndex = pgIndex;
    
    [self moveToCurrentIndex];
    animationType = animType;
    
    
   
    if (imgView && (animType == AnimationTypePop)) {
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        animImageview = imgView;
        [self insertSubview:animImageview aboveSubview:mainCollection];
        }
    switch (animType) {
        case AnimationTypePop:
            [self showWithBounce];
            break;
        case AnimationTypeEaseIn:
            [self showWithEaseIn];
            break;
        default:
            [self showWithEaseIn];
            break;
    }

    
}



- (void)zoomOutWithBounce{


    mainCollection.hidden = self.closeBtn.hidden = YES;
    __weak UIImageView * wAnimImgView = animImageview;
    
    __block CGRect originalFrame = initialFrame;
    __block CGRect animFrame = CGRectMake(initialFrame.origin.x,initialFrame.origin.y, initialFrame.size.width -2, initialFrame.size.height - 2);
    __weak typeof(self) wSelf = self;
    [animImageview setHidden:NO];
    [UIView animateWithDuration:.20 animations:^{
        
        wAnimImgView.frame = animFrame;
        subCollectionTopConst.constant = 110;
        [wSelf layoutIfNeeded];

        
        
    } completion:^(BOOL finished) {
        subCollection.hidden = YES ;
        [UIView animateWithDuration:0.10 animations:^{
             wAnimImgView.frame = originalFrame;
            foregroundWindow.alpha = 0.0;
            
        } completion:^(BOOL finished) {
            
            [foregroundWindow setHidden:YES];
            [wSelf removeFromSuperview];
            foregroundWindow = nil;
        }];
    }];
}


-(IBAction)closeBtnClicked:(id)sender{
   
   
    switch (animationType) {
        case AnimationTypePop:
            [self zoomOutWithBounce];
            break;
        case AnimationTypeEaseIn:
            [self hideWithEaseOut];
            break;
        default:
            [self hideWithEaseOut];
            break;
    }
    
}

#pragma Mark - ScrollView Delegate Methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([mainCollection isEqual:scrollView]) {
        
        CGFloat pageWidth = mainCollection.frame.size.width;
        int currentPage = mainCollection.contentOffset.x / pageWidth;
        
        if (currentPage > imagesCount || currentPage < 0) {
            return;
        }
        else{
            selectionIndex = currentPage;
            
            NSIndexPath * indxpath = [NSIndexPath indexPathForRow:selectionIndex inSection:0];
            [subCollection reloadData];
            [subCollection scrollToItemAtIndexPath:indxpath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(imageIndexOnChange:)])
        {
            [self.delegate imageIndexOnChange:selectionIndex];
        }
        if(animImageview){
           
            NSIndexPath  * indexPath = [NSIndexPath indexPathForRow:selectionIndex inSection:0];
                IZVMainCollectionViewCell * cell = (IZVMainCollectionViewCell *)[mainCollection cellForItemAtIndexPath:indexPath];
                animImageview.image = cell.imgview.image;
        }
    }
    
}



#pragma Mark - CollectionView Delegate Methods

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return imagesCount;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([collectionView isEqual:mainCollection]) {
        
        
    
    IZVMainCollectionViewCell *cell = [collectionView
                                  dequeueReusableCellWithReuseIdentifier:mainCollectionCellID
                                  forIndexPath:indexPath];
        cell.imgview.image = nil;
        __weak UIImageView * weakImgVw = cell.imgview;
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(initializeImageviewWithImages:withIndexPath:withCollection:)])  {
            [self.delegate initializeImageviewWithImages:weakImgVw withIndexPath:indexPath withCollection:0];
        }
        [mainCollection addGestureRecognizer:cell.scrollView.pinchGestureRecognizer];
        [mainCollection addGestureRecognizer:cell.scrollView.panGestureRecognizer];
    
        cell.clipsToBounds = YES;
    
    return cell;
    }
    else{
    
        UICollectionViewCell *cell = [collectionView
                                      dequeueReusableCellWithReuseIdentifier:subCollectionCellID
                                      forIndexPath:indexPath];
        
        for (UIImageView * imgview in cell.subviews) {
            [imgview removeFromSuperview];
        }
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,80,80)];
        imgView.image = nil;
        imgView.clipsToBounds = YES;
         imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        __weak UIImageView * weakImgVw = imgView;
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(initializeImageviewWithImages:withIndexPath:withCollection:)])  {
            [self.delegate initializeImageviewWithImages:weakImgVw withIndexPath:indexPath withCollection:1];
        }
        
        if (selectionIndex == indexPath.row) {
            cell.layer.borderWidth = 0.5;
            if (borderColor) {
                cell.layer.borderColor = borderColor.CGColor;
            }
            else{
                cell.layer.borderColor = [UIColor blackColor].CGColor;
            }
        }
        else{
            cell.layer.borderWidth = 0.0;
        }
        [cell addSubview:imgView];
        
        
        
        return cell;

    
    
    
    }
}


- (void)collectionView:(UICollectionView *)collectionView
  didEndDisplayingCell:(IZVMainCollectionViewCell *)cell
    forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([collectionView isEqual:mainCollection]) {
        [cell.scrollView setZoomScale:1.0];
         cell.zoomed = NO;
        [mainCollection removeGestureRecognizer:cell.scrollView.pinchGestureRecognizer];
        [mainCollection removeGestureRecognizer:cell.scrollView.panGestureRecognizer];
    }
  
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath

{
   
    if ([collectionView isEqual:mainCollection]) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width ,[UIScreen mainScreen].bounds.size.height - 170);
    }
    else{
    return CGSizeMake(80,80);
    }
    

}

-(void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    
    if ([collectionView isEqual:subCollection]) {
        [mainCollection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        selectionIndex = indexPath.row;
        [subCollection reloadData];
        [subCollection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        
    }
   
}





@end
