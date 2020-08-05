//
//  OneCell.m
//  task8
//
//  Created by Roman on 7/28/20.
//  Copyright © 2020 Roman. All rights reserved.
//

#import "OneCell.h"
#import "Cancel.h"
#import "Downloader.h"

@interface OneCell ()
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic)Cancel *cancelable;
@property (strong, nonatomic)Downloader *downloader;
@end

@implementation OneCell

-(void)prepareForReuse {
    [super prepareForReuse];
    _imageView.image = nil;
    [_cancelable cancel];
}

-(UIImageView *)createImageView {
    UIImageView *imageView = [UIImageView new];
    [self.contentView addSubview:imageView];
    [self addConstraintsToImageView:imageView];
    imageView.layer.masksToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.layer.cornerRadius = imageView.frame.size.width / 2;
    return imageView;
}

-(void)setData:(int)index cache:(NSCache *)imageCache {
    
    if (!_imageView) {
         _imageView = [self createImageView];
    }
    _imageView.image = [UIImage imageNamed:@"placeholder"];
    _downloader = [Downloader new];
    _cancelable = [_downloader getImage:index imageCache:imageCache completion:^(UIImage * _Nullable image, NSError * _Nullable error) {
        self.imageView.image = image;
    }];
}

//MARK: - Anchors
-(void)addConstraintsToImageView:(UIImageView *)imageView {
    imageView.translatesAutoresizingMaskIntoConstraints = false;
    [imageView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:15].active = true;
    [imageView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-15].active = true;
    [imageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:15].active = true;
    [imageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-15].active = true;
}

@end
