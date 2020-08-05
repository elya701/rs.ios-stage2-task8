//
//  WelcomeController.m
//  task8
//
//  Created by Roman on 7/27/20.
//  Copyright © 2020 Roman. All rights reserved.
//

#import "WelcomeController.h"



@interface WelcomeController ()
@property (nonatomic, strong) UIImageView *imageViewLogo;
@property (nonatomic, strong) UIButton *buttonRegistration;
@property (nonatomic, strong) UIButton *buttonWithoutRegistration;
@end


@implementation WelcomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor.whiteColor initWithPatternImage:[UIImage imageNamed:@"welcomeBackground"]];
    _imageViewLogo = [self createLogoImageView];
    _buttonWithoutRegistration = [self createButtonWithoutRegistration];
    _buttonRegistration = [self createButtonRegistration];
}

-(UIImageView *)createLogoImageView {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
    [self.view addSubview:imageView];
    [self addConstraintsToLogoImageView:imageView];
    return imageView;
}

-(void)addConstraintsToLogoImageView:(UIImageView *)imageView {
    imageView.translatesAutoresizingMaskIntoConstraints = false;
    [imageView.widthAnchor constraintEqualToConstant:250].active = YES;
    [imageView.heightAnchor constraintEqualToConstant:165].active = YES;
    [imageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [imageView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:160].active = YES;
}

-(UIButton *)createButtonRegistration {
    UIButton *button = [UIButton new];
    button.layer.cornerRadius = 20;
    button.backgroundColor = [UIColor.orangeColor colorWithAlphaComponent:0.95];
    [button setTitle:@"Authorisation" forState:UIControlStateNormal];
    [self.view addSubview:button];
    [self addConstraintsToButtonRegistration:button];
    [button addTarget:self action:@selector(goWithRegistrationMethod) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

-(void)addConstraintsToButtonRegistration:(UIButton *)button {
     button.translatesAutoresizingMaskIntoConstraints = false;
       [button.widthAnchor constraintEqualToConstant:250].active = YES;
       [button.heightAnchor constraintEqualToConstant:50].active = YES;
       [button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
       [button.bottomAnchor constraintEqualToAnchor:self.buttonWithoutRegistration.topAnchor constant:-10].active = YES;
}

-(UIButton *)createButtonWithoutRegistration {
    UIButton *button = [UIButton new];
    button.layer.cornerRadius = 20;
    button.layer.borderColor = UIColor.orangeColor.CGColor;
    button.layer.borderWidth = 1;
    [button setTitle:@"I don't have API-Key" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
    button.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:button];
    [self addConstraintsToButtonWithoutRegistration:button];
    [button addTarget:self action:@selector(goWithoutRegistrationMethod)  forControlEvents:UIControlEventTouchUpInside];
    return button;
}

-(void)addConstraintsToButtonWithoutRegistration:(UIButton *)button {
    button.translatesAutoresizingMaskIntoConstraints = false;
    [button.widthAnchor constraintEqualToConstant:250].active = YES;
    [button.heightAnchor constraintEqualToConstant:50].active = YES;
    [button.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    [button.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:-130].active = YES;
}

@end
