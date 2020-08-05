//
//  LoadingCell.h
//  task8
//
//  Created by Roman on 7/28/20.
//  Copyright © 2020 Roman. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoadingCell : UICollectionViewCell
-(void)setData;
@property (nonatomic, strong) UIActivityIndicatorView *activityView;    
@end

NS_ASSUME_NONNULL_END
