//
//  DetailController.m
//  task8
//
//  Created by Roman on 7/29/20.
//  Copyright © 2020 Roman. All rights reserved.
//

#import "DetailController.h"

@interface DetailController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;
@end

@implementation DetailController

-(id)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        _image = image;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    _imageView = [self createImageView];
    self.navigationItem.rightBarButtonItem = [self createBarButtonItem];
    self.navigationItem.leftBarButtonItem = [self createDismissBarButtonItem];
}

-(UIImageView *)createImageView {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:_image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    [self addConstraintsToImageView:imageView];
    return imageView;
}

//MARK: - Anchors
-(void)addConstraintsToImageView:(UIImageView *)imageView {
    imageView.translatesAutoresizingMaskIntoConstraints = false;
    [imageView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [imageView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [imageView.topAnchor constraintEqualToAnchor:self.view.topAnchor].active = YES;
    [imageView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

-(UIBarButtonItem *)createBarButtonItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveToGallery)];
    return item;
}

-(UIBarButtonItem *)createDismissBarButtonItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemClose target:self action:@selector(dismissVC)];
    return item;
}

-(void)saveToGallery {
    UIImageWriteToSavedPhotosAlbum(_image, self, @selector(imageSaved:didFinishSavingWithError:contextInfo:), nil);
}

-(void)dismissVC {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imageSaved:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(id)contextInfo {
    if (error != nil) {
        [self createAlert:@"Saving error" text:@"Image saving process was denied!"];
    } else {
        [self createAlert:@"Saving success" text:@"Image was succesfull saved!"];
    }
}

-(void)createAlert:(NSString *)title text:(NSString *)text {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
