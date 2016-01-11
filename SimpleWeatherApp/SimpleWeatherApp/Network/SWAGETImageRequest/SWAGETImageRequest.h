//
//  SWAGETImageRequest.h
//
//  Created by alex on 26.10.15.
//  Copyright © 2015 Codeveyor. All rights reserved.
//

#import "BASERootRequest.h"

typedef void (^GETImageRequestSuccessBlock)(UIImage *image);

@interface SWAGETImageRequest : SWARootRequest

@property (nonatomic, copy) GETImageRequestSuccessBlock successBlock;

- (instancetype)initWithURLString:(NSString *)URLString;

@end
