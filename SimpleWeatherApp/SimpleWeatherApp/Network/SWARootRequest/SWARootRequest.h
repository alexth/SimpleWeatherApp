//
//  SWARootRequest.h
//  SimpleWeatherApp
//
//  Created by Alex Golub on 1/11/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;

typedef void (^RequestFailureBlock)(NSError *error);

@interface SWARootRequest : NSObject
{
    NSURL *_url;
    NSString *_formDataURLString;
    NSDictionary *_parameters;
    UIImage *_image;
}

@property (nonatomic, strong) AFHTTPRequestOperation *GETRequestOperation;
@property (nonatomic, strong) AFHTTPRequestOperation *POSTRequestOperation;
@property (nonatomic, strong) AFHTTPRequestOperation *DELETERequestOperation;
@property (nonatomic, strong) AFHTTPRequestOperation *PATCHRequestOperation;
@property (nonatomic, strong) AFHTTPRequestOperation *GETImageRequestOperation;
@property (nonatomic, copy) RequestFailureBlock failureBlock;
@property (nonatomic, strong, readonly) NSURL *url;
@property (nonatomic, copy, readonly) NSString *formDataURLString;
@property (nonatomic, copy, readonly) NSDictionary *parameters;
@property (nonatomic, strong) UIImage *image;

@end

@interface SWARootRequest (Protected)

- (void)parseResult:(id)JSON;
- (void)downloadedImage:(UIImage *)image;

@end

