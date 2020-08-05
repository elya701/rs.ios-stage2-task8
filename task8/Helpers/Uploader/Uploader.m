//
//  Uploader.m
//  task8
//
//  Created by Roman on 7/30/20.
//  Copyright © 2020 Roman. All rights reserved.
//

#import "Uploader.h"

@implementation Uploader

-(NSData *)createHttpBody:(UIImage *)image mediaUrl:(NSURL *)mediaUrl boundary:(NSString *)boundary imageName:(NSString *)imageName {
    NSMutableData *httpBody = [NSMutableData new];
    [httpBody appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [httpBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n", imageName] dataUsingEncoding:NSUTF8StringEncoding]];
    [httpBody appendData:[[NSString stringWithFormat:@"Content-Type: image/%@\r\n\r\n", [imageName componentsSeparatedByString:@"."].lastObject] dataUsingEncoding:NSUTF8StringEncoding]];
    [httpBody appendData:UIImageJPEGRepresentation(image, 0.7)];
    [httpBody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    return [httpBody copy];
}

-(NSURLRequest *)createRequest:(UIImage *)image mediaUrl:(NSURL *)mediaUrl imageName:(NSString *)imageName apiKey:(NSString *)apiKey {
    NSString *boundary = [NSString stringWithFormat:@"Boundary-%@", NSUUID.UUID.UUIDString];
    NSDictionary *headers = @{ @"content-type": [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary],
                               @"x-api-key": apiKey };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.thecatapi.com/v1/images/upload"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"POST"];
    [request setAllHTTPHeaderFields:headers];
    [request setHTTPBody:[self createHttpBody:image mediaUrl:mediaUrl boundary:boundary imageName:imageName]];
    return request;
}

-(void)startAnimating:(UIActivityIndicatorView *)spinner {
    [spinner startAnimating];
}

-(void)stopAnimating:(UIActivityIndicatorView *)spinner {
    [spinner stopAnimating];
}

-(void)uploadImageToServer:(UIImage *)image mediaUrl:(NSURL *)mediaUrl imageName:(NSString *)imageName apiKey:(NSString *)apiKey completion:(void (^)(NSString * _Nullable str))completion {
    NSURLRequest *request = [self createRequest:image mediaUrl:mediaUrl imageName:imageName apiKey:apiKey];
    [self createSessionDataTask:request completion:completion];
}

-(void)createSessionDataTask:(NSURLRequest *)request completion:(void (^)(NSString * _Nullable str))completion {

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            NSLog(@"%@", httpResponse);

            
            if (httpResponse.statusCode >= 400) {
                

                     NSError *err = nil;
                NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&err];
                                
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion([json valueForKey:@"message"]);
                });
            } else if (httpResponse.statusCode >= 200) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(@"Success");
                });
            }
        }
    }];
    [dataTask resume];
}

@end
