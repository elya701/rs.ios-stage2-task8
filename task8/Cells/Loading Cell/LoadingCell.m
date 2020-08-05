//
//  LoadingCell.m
//  task8
//
//  Created by Roman on 7/28/20.
//  Copyright © 2020 Roman. All rights reserved.
//

#import "LoadingCell.h"

@implementation LoadingCell
-(void)setData {
    _activityView = [self createActivityView];
}

-(UIActivityIndicatorView *)createActivityView {
    UIActivityIndicatorView *activityView = [UIActivityIndicatorView new];
    [self.contentView addSubview:activityView];
    [self addConstraintsToActivityView:activityView];;
    return activityView;
}

//MARK: - Anchors
-(void)addConstraintsToActivityView:(UIActivityIndicatorView *)activityView {
    activityView.translatesAutoresizingMaskIntoConstraints = false;
    [activityView.widthAnchor constraintEqualToConstant:50].active = true;
    [activityView.heightAnchor constraintEqualToConstant:50].active = true;
    [activityView.centerXAnchor constraintEqualToAnchor:self.contentView.centerXAnchor].active = true;
    [activityView.centerYAnchor constraintEqualToAnchor:self.contentView.centerYAnchor].active = true;
}
@end
