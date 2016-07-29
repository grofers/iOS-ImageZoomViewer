//
//  IZVMainCollectionViewCell.h
//
//
//  Created by Anubhav Mathur on 20/08/15.
//  Copyright (c) 2015. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IZVMainCollectionViewCell : UICollectionViewCell<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imgview;
@property (nonatomic)BOOL zoomed;


@end
