//
//  ViewControllerPresenter.h
//  task8
//
//  Created by Roman on 7/30/20.
//  Copyright © 2020 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface ViewControllerPresenter : NSObject
-(void)loadMoreData:(BOOL)isLoading completion:(void(^)(NSError * _Nullable error))completion;
-(NSNumber *)addElements:(NSNumber *)number;
@end

NS_ASSUME_NONNULL_END
