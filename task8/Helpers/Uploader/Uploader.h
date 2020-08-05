//
//  Uploader.h
//  task8
//
//  Created by Roman on 7/30/20.
//  Copyright © 2020 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Uploader : NSObject
-(void)uploadImageToServer:(UIImage *)image mediaUrl:(NSURL *)mediaUrl imageName:(NSString *)imageName apiKey:(NSString *)apiKey completion:(void (^)(NSString * _Nullable str))completion;
@end

NS_ASSUME_NONNULL_END
