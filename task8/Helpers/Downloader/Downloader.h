//
//  Downloader.h
//  task8
//
//  Created by Roman on 7/28/20.
//  Copyright © 2020 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cancel.h"
#import "OneCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface Downloader : NSObject
-(Cancel *)getImage:(int)index imageCache:(NSCache *)imageCache completion:(void (^)(UIImage* _Nullable image, NSError * _Nullable error))completion;
@end

NS_ASSUME_NONNULL_END
