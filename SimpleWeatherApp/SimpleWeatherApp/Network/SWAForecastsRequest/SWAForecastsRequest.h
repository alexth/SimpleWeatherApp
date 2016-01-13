//
//  SWADefaultRequest.h
//
//  Created by alex on 26.10.15.
//  Copyright © 2015 Codeveyor. All rights reserved.
//

#import "SWARootRequest.h"

typedef void (^GETForecastsSuccessBlock)(NSDictionary *dataDictionary);

@interface SWAForecastsRequest : SWARootRequest

@property (nonatomic, copy) GETForecastsSuccessBlock successBlock;

- (instancetype)initRequestWithCity:(NSString *)cityString
                       numberOfDays:(NSNumber *)numberOfDays;

@end
