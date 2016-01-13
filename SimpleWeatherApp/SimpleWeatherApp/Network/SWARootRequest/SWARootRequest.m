//
//  SWARootRequest.m
//  SimpleWeatherApp
//
//  Created by Alex Golub on 1/11/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

#import "SWARootRequest.h"
#import "AFHTTPRequestOperation.h"
#import "SWAWebCore.h"

@interface SWARootRequest ()

@property(nonatomic, strong) AFHTTPRequestOperation *operation;

@end

@implementation SWARootRequest

- (AFHTTPRequestOperation *)GETRequestOperation
{
    __weak SWARootRequest *weakSelf = self;
    
//    NSLog(@"url - %@", [self.url absoluteString]);
    
    self.operation = [SWAWebCore getRequestWithUrl:self.url success:^(id JSON) {
        
        [weakSelf parseResult:JSON];
    } failure:^(NSError *error) {
        
        if (weakSelf.failureBlock)
        {
            weakSelf.failureBlock(error);
        }
    }];
    
    return self.operation;
}

- (AFHTTPRequestOperation *)POSTRequestOperation
{
    __weak SWARootRequest *weakSelf = self;
    
//    NSLog(@"url - %@", [self.url absoluteString]);
    
    self.operation = [SWAWebCore postRequestWithURL:self.url parameters:self.parameters success:^(id JSON) {
        
        [weakSelf parseResult:JSON];
    } failure:^(NSError *error) {
        
        if (weakSelf.failureBlock)
        {
            weakSelf.failureBlock(error);
        }
    }];
    
    return self.operation;
}

- (AFHTTPRequestOperation *)DELETERequestOperation
{
    __weak SWARootRequest *weakSelf = self;
    
//    NSLog(@"url - %@", [self.url absoluteString]);
    
    self.operation = [SWAWebCore deleteRequestWithURL:self.url parameters:self.parameters success:^(id JSON) {
        
        [weakSelf parseResult:JSON];
    } failure:^(NSError *error) {
        
        if (weakSelf.failureBlock)
        {
            weakSelf.failureBlock(error);
        }
    }];
    
    return self.operation;
}

- (AFHTTPRequestOperation *)PATCHRequestOperation
{
    __weak SWARootRequest *weakSelf = self;
    
//    NSLog(@"url - %@", [self.url absoluteString]);
    
    self.operation = [SWAWebCore patchRequestWithURL:self.url parameters:self.parameters success:^(id JSON) {
        
        [weakSelf parseResult:JSON];
    } failure:^(NSError *error) {
        
        if (weakSelf.failureBlock)
        {
            weakSelf.failureBlock(error);
        }
    }];
    
    return self.operation;
}

- (AFHTTPRequestOperation *)GETImageRequestOperation
{
    __weak SWARootRequest *weakSelf = self;
    
    self.operation = [SWAWebCore getImageWithURLString:self.formDataURLString parameters:self.parameters success:^(UIImage *image) {
        
        [weakSelf downloadedImage:image];
    } failure:^(NSError *error) {
        
        if (weakSelf.failureBlock)
        {
            weakSelf.failureBlock(error);
        }
    }];
    
    return self.operation;
}

#pragma mark - Utils

- (void)parseResult:(id)JSON
{
    
}

- (void)downloadedImage:(UIImage *)image
{
    
}

@end
