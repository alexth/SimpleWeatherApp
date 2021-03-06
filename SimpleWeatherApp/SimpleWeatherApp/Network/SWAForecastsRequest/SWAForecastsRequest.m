//
//  SWADefaultRequest.m
//
//  Created by alex on 26.10.15.
//  Copyright © 2015 Codeveyor. All rights reserved.
//

#import "SWAForecastsRequest.h"

@implementation SWAForecastsRequest

- (instancetype)initRequestWithCity:(NSString *)cityString
                       numberOfDays:(NSNumber *)numberOfDays
{
    if (self = [super init])
    {
        NSString *urlString = [NSString stringWithFormat:@"%@%@%@%@%@",
                               kServerURLAddress,
                               [NSString stringWithFormat:@"q=%@", cityString],
                               [NSString stringWithFormat:@"&format=json"],
                               [NSString stringWithFormat:@"&num_of_days=%@", numberOfDays],
                               [NSString stringWithFormat:@"&key=%@", kAuthKey]
                               ];
        _url = [[NSURL alloc] initWithString:urlString];
    }
    
    return self;
}

#pragma mark - Utils

- (void)parseResult:(id)JSON
{
    __weak typeof(self) weakSelf = self;
    if ((JSON == nil) || ([JSON isKindOfClass:[NSDictionary class]] == NO))
    {
        if (weakSelf.failureBlock)
        {
            weakSelf.failureBlock(nil);
            return;
        }
    }
    
    NSDictionary *dataDictionary = (NSDictionary *)JSON;
    if (weakSelf.successBlock)
    {
        weakSelf.successBlock(dataDictionary);
    }
}

@end
