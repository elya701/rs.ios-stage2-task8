//
//  ViewController+delegates.m
//  task8
//
//  Created by Roman on 7/30/20.
//  Copyright © 2020 Roman. All rights reserved.
//

#import "ViewController+delegates.h"


@implementation ViewController (delegates)


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSURL *mediaURl = [info objectForKey:UIImagePickerControllerImageURL];
    NSArray *ar = [mediaURl.absoluteString componentsSeparatedByString:@"/"];
    NSString *filename = [ar lastObject];
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.spinner startAnimating];
    Uploader *uploader = [Uploader new];
    [uploader uploadImageToServer:chosenImage mediaUrl:mediaURl imageName:filename apiKey:self.apiKey completion:^(NSString * _Nullable str) {
        if ([str isEqualToString:@"Success"]) {
            [self createAlert:@"Uploading success" withMessage:@"Image was successfull uploaded!"];
        } else {
            [self createAlert:@"Uploading error" withMessage:str];
        }
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.number.intValue;
    } else if (section == 1) {
        return 1;
    } else {
        return 0;
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        OneCell *cell= (OneCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
        [cell setData:(int)indexPath.row cache:self.imageCache];
        cell.imageView.layer.cornerRadius = 70;
        return cell;
    } else {
        LoadingCell *cell= (LoadingCell *) [collectionView dequeueReusableCellWithReuseIdentifier:@"loadingCell" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[LoadingCell alloc] init];
        }
        [cell.activityView startAnimating];
        [cell setData];
        [self.presenter loadMoreData:self.isLoading completion:^(NSError * _Nullable error) {
            if (error == nil) {
            self.isLoading = true;
            self.number = [self.presenter addElements:self.number];
            [self.collectionView reloadData];
            self.isLoading = false;
            }
        }];
        return cell;
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DetailController *detailViewController = [[DetailController alloc] initWithImage:[self.imageCache objectForKey:[NSString stringWithFormat:@"%d", (int)indexPath.row]]];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:detailViewController];
    [self presentViewController:navController animated:YES completion:nil];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(self.view.frame.size.width - 20, self.view.frame.size.width - 20);
    } else {
        return CGSizeMake(self.view.frame.size.width - 20, 55);
    }
    
}

-(void)uploadImage {
    [self presentViewController:self.picker animated:YES completion:nil];
}



@end
