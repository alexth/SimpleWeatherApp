//
//  SWADefaultRequest.h
//
//  Created by alex on 26.10.15.
//  Copyright © 2015 Codeveyor. All rights reserved.
//

#import "SWARootRequest.h"

typedef void (^GETDefaultRequestSuccessBlock)(NSDictionary *dataDictionary);

@interface SWADefaultRequest : SWARootRequest

@property (nonatomic, copy) GETDefaultRequestSuccessBlock successBlock;

- (instancetype)initRequestWithDictionary:(NSDictionary *)credentialsDictionary;

@end
