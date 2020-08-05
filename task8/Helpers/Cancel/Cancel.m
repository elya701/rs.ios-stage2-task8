//
//  Cancel.m
//  task8
//
//  Created by Roman on 7/28/20.
//  Copyright © 2020 Roman. All rights reserved.
//

#import "Cancel.h"

@implementation Cancel

-(id)init {
    self = [super init];
    if (self) {
        _isCancelled = false;
    }
    return self;
}

-(void)cancel {
    _isCancelled = true;
}

@end
