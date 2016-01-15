//
//  SWAConstants.m
//  SimpleWeatherApp
//
//  Created by alex on 11.01.16.
//  Copyright (c) 2016 alex. All rights reserved.
//

#import "SWAConstants.h"

#pragma mark - Animation Speed

const float kAnimationSpeedVeryHigh = 0.1f;
const float kAnimationSpeedHigh = 0.2f;
const float kAnimationSpeedDefault = 0.3f;
const float kAnimationSpeedLow = 0.4f;

#pragma mark - Entity Names

NSString * const kCityEntityName = @"SWACityDB";
NSString * const kForecastEntityName = @"SWAForecastDB";

#pragma mark - Web

const int kFutureForecastsCount = 6;
NSString * const kServerURLAddress = @"http://api.worldweatheronline.com/free/v2/weather.ashx?";
NSString * const kAuthKey = @"3e11ab17a696bfb1ea4714e8d4263";






