//
//  OneCell.h
//  task8
//
//  Created by Roman on 7/28/20.
//  Copyright © 2020 Roman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cancel.h"

NS_ASSUME_NONNULL_BEGIN

@interface OneCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *imageView;
-(void)setData:(int)index cache:(NSCache *)imageCache;
@end

NS_ASSUME_NONNULL_END
