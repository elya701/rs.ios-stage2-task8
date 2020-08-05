//
//  Downloader.m
//  task8
//
//  Created by Roman on 7/28/20.
//  Copyright © 2020 Roman. All rights reserved.
//

#import "Downloader.h"


@implementation Downloader

-(Cancel *)getImage:(int)index imageCache:(NSCache *)imageCache completion:(void (^)(UIImage* _Nullable image, NSError * _Nullable error))completion {
    Cancel *cancelNew = [self createCancelObject];
    NSError *errorTmp = [self createErrorTmpObject];
    __auto_type completionTemp = [self createCompletionTmp:cancelNew withCompletion:completion];
    UIImage *imageFromCache = [self fetchImageFromCache:imageCache withIndex:index];
    
    if (imageFromCache == nil) {
        NSMutableURLRequest *request = [self createRequest];
        NSURLSession *session = [self createSession];
        [self downloadImage:request withCache:imageCache completion:completionTemp errorTmp:errorTmp index:index session:session];
    }
    else {
        completionTemp([imageCache objectForKey:[NSString stringWithFormat:@"%d", index]], errorTmp);
    }
    return cancelNew;
}

-(Cancel *)createCancelObject {
    Cancel *cancelNew = [[Cancel alloc] init];
    return cancelNew;
}

-(NSError *)createErrorTmpObject {
    NSError *errorTmp = nil;
    return errorTmp;
}

-(void (^)(UIImage* _Nullable image, NSError * _Nullable error))createCompletionTmp:(Cancel *)cancelNew withCompletion:(void (^)(UIImage* _Nullable image, NSError * _Nullable error))completion {
    __auto_type completionTemp = ^void(UIImage* _Nullable image, NSError* _Nullable error){
        if (cancelNew.isCancelled) {
            NSLog(@"KEK");
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completion(image, error);
        });
        
    };
    return completionTemp;
}

-(NSMutableURLRequest *)createRequest {
    NSDictionary *headers = @{ @"x-api-key": @"DEMO-API-KEY" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.thecatapi.com/v1/images/search"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    return request;
}

-(NSURLSession *)createSession {
    NSURLSession *session = [NSURLSession sharedSession];
    return session;
}

-(void)downloadImage:(NSMutableURLRequest *)request withCache:(NSCache *)imageCache completion:(void (^)(UIImage* _Nullable image, NSError * _Nullable error))completionTemp errorTmp:(NSError *)errorTmp index:(int)index session:(NSURLSession *)session {
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    if (error) {
        NSLog(@"%@", error);
        
    } else {
        NSError *e = nil;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
        if (!jsonArray) {
            NSLog(@"Error parsing JSON: %@", e);
            
        } else {
            for(NSDictionary *item in jsonArray) {
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@", [item objectForKey:@"url"]]];
                NSData * imageData = [[NSData alloc] initWithContentsOfURL: url];
                __auto_type image = [[UIImage alloc] initWithData:imageData];
                
                if (image != nil) {
                    //NSLog(@"Index: %d", index);
                    [imageCache setObject:image forKey:[NSString stringWithFormat:@"%d", index]];
                    
                    completionTemp(image, errorTmp);
                    
                    NSLog(@"присвоено");
                }
                else {
                    completionTemp(nil, errorTmp);
                    NSLog(@"ELSE");
                }
            }
        }
    }
    }];
    
    [dataTask resume];
}

-(UIImage *)fetchImageFromCache:(NSCache *)imageCache withIndex:(int)index {
    UIImage *image = [imageCache objectForKey:[NSString stringWithFormat:@"%d", index]];
    return image;
}

@end
