//
//  ViewControllerPresenter.m
//  task8
//
//  Created by Roman on 7/30/20.
//  Copyright © 2020 Roman. All rights reserved.
//

#import "ViewControllerPresenter.h"

@implementation ViewControllerPresenter

-(void)loadMoreData:(BOOL)isLoading completion:(void(^)(NSError * _Nullable error))completion {

    if (!isLoading) {
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
            sleep(3);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSError *error = nil;
                completion(error);
            });
        });
    }
}

-(NSNumber *)addElements:(NSNumber *)number {
    NSNumber *numberTmp = @(number.intValue + 10);
    return numberTmp;
}

@end
