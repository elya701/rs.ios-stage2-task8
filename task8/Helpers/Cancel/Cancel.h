//
//  Cancel.h
//  task8
//
//  Created by Roman on 7/28/20.
//  Copyright © 2020 Roman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Cancel : NSObject
@property (nonatomic, assign) BOOL isCancelled;
-(void)cancel;
@end

NS_ASSUME_NONNULL_END
