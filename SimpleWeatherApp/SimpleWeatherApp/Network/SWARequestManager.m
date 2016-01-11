//
//  SWARequestManager.m
//
//  Created by alex on 26.10.15.
//  Copyright © 2015 Codeveyor. All rights reserved.
//

#import "SWARequestManager.h"
#import "SynthesizeSingleton.h"
#import "AFHTTPRequestOperation.h"

@interface SWARequestManager ()

@property (nonatomic, strong) NSMutableArray *GETImageRequestsArray;

@end

@implementation SWARequestManager
SYNTHESIZE_SINGLETON_FOR_CLASS(SWARequestManager)

- (instancetype)init
{
    if ([super init] == self)
    {
        _GETImageRequestsArray = [NSMutableArray new];
    }
    
    return self;
}

@end
