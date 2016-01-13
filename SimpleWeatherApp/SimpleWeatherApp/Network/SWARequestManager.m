//
//  SWARequestManager.m
//
//  Created by alex on 26.10.15.
//  Copyright © 2015 Codeveyor. All rights reserved.
//

#import "SWARequestManager.h"
#import "SynthesizeSingleton.h"
#import "AFHTTPRequestOperation.h"

#import "SWAForecastsRequest.h"

@interface SWARequestManager ()

@property (nonatomic, strong) NSMutableArray *GETForecastsArray;

@end

@implementation SWARequestManager
SYNTHESIZE_SINGLETON_FOR_CLASS(SWARequestManager)

- (instancetype)init
{
    if ([super init] == self)
    {
        _GETForecastsArray = [NSMutableArray new];
    }
    
    return self;
}

#pragma mark - GET methods

- (void)GETForecastForCity:(NSString *)city
              numberOfDays:(NSNumber *)numberOfDays
              successBlock:(RequestManagerSuccessBlock)successBlock
{
    __weak typeof(self) weakSelf = self;
    
    SWAForecastsRequest *allRequest = [[SWAForecastsRequest alloc]initRequestWithCity:city
                                                                         numberOfDays:numberOfDays];
    [self.GETForecastsArray addObject:allRequest];
    __weak SWAForecastsRequest *weakRequest = allRequest;
    allRequest.failureBlock = ^(NSError *error) {
        
        successBlock(NO, nil, error);
        [weakSelf.GETForecastsArray removeObject:weakRequest];
    };
    allRequest.successBlock = ^(NSDictionary *allDictionary) {
        
        successBlock(YES, allDictionary, nil);
        [weakSelf.GETForecastsArray removeObject:weakRequest];
    };
    
    [allRequest.GETRequestOperation start];
}

@end
