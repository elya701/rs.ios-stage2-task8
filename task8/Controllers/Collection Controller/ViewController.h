//
//  ViewController.h
//  task8
//
//  Created by Roman on 7/27/20.
//  Copyright © 2020 Roman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailController.h"
#import "Uploader.h"
#import "ViewControllerPresenter.h"
#import "OneCell.h"
#import "LoadingCell.h"
#import "Downloader.h"

@interface ViewController : UIViewController
-(id)initWithApiKey:(NSString *)apiKey;
@property (nonatomic, strong) NSString *apiKey;
-(void)createAlert:(NSString *)title withMessage:(NSString *)message;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIView *viewTab;
@property (nonatomic, strong) UIButton *buttonNewImage;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) LoadingCell *loadingCell;
@property (nonatomic, strong) Downloader *downloader;
@property (nonatomic, strong) NSNumber *number;
@property (strong, nonatomic) NSCache *imageCache;
@property (strong, nonatomic) UIActivityIndicatorView *spinner;
@property (strong, nonatomic) UIImagePickerController *picker;
@property (strong, nonatomic) Uploader *uploader;
@property (strong, nonatomic) ViewControllerPresenter *presenter;
@end

