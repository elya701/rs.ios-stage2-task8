//
//  ViewController.m
//  task8
//
//  Created by Roman on 7/27/20.
//  Copyright © 2020 Roman. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

-(id)initWithApiKey:(NSString *)apiKey {
    self = [super init];
    if (self) {
        _apiKey = apiKey;
        _downloader = [Downloader new];
        if (!self.imageCache) {
            self.imageCache = [NSCache new];
            _uploader = [Uploader new];
             _presenter = [ViewControllerPresenter new];
            NSLog(@"Created cache");
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_apiKey != nil) {
        self.navigationItem.rightBarButtonItem = [self createBarButtonItem];
    }
    _number = [[NSNumber alloc] initWithInt:10];
    _isLoading = false;
    self.navigationController.navigationBar.topItem.title = @"TheCatApi";
    _picker = [self createPickerController];
    _collectionView = [self createCollectionView];
    _spinner = [self createActivityIndicatorController];
}

-(UIImagePickerController *)createPickerController {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    return picker;
}

-(UIBarButtonItem *)createBarButtonItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(uploadImage)];
    return item;
}


-(UICollectionView *)createCollectionView {
    UICollectionViewFlowLayout *layout=[UICollectionViewFlowLayout new];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerClass:[OneCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [collectionView registerClass:[LoadingCell class] forCellWithReuseIdentifier:@"loadingCell"];
    //[collectionView registerClass:[LoadingCell class]  forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"loadingCell"];
    collectionView.backgroundColor = [UIColor.whiteColor initWithPatternImage:[UIImage imageNamed:@"welcomeBackground"]];
    [self.view addSubview:collectionView];
    [self addConstraintsToCollectionView:collectionView];
    return collectionView;
}

-(void)addConstraintsToCollectionView:(UICollectionView *)collectionView {
    collectionView.translatesAutoresizingMaskIntoConstraints = false;
    [collectionView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor].active = YES;
    [collectionView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor].active = YES;
    [collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:30].active = YES;
    [collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor].active = YES;
}

-(UIActivityIndicatorView *)createActivityIndicatorController {
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    spinner.backgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.3];
    spinner.layer.masksToBounds = YES;
    spinner.layer.cornerRadius = 25;
    [self.view addSubview:spinner];
    spinner.translatesAutoresizingMaskIntoConstraints = false;
    [spinner.widthAnchor constraintEqualToConstant:100].active = YES;
    [spinner.heightAnchor constraintEqualToConstant:100].active = YES;
    [spinner.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor].active = YES;
    //[self createAlert:@"Uploading success" withMessage:@"Image was successfull uploaded!"];
    [spinner.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor].active = YES;
    return spinner;
}


-(void)createAlert:(NSString *)title withMessage:(NSString *)message {
        [self.spinner startAnimating];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alert addAction:okAction];
        [self.spinner stopAnimating];
        [self presentViewController:alert animated:YES completion:nil];
}

@end
