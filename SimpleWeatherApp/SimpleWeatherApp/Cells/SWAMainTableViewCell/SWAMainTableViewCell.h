//
//  SWAMainTableViewCell.h
//  SimpleWeatherApp
//
//  Created by Alex Golub on 1/11/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWAForecastDB;

@interface SWAMainTableViewCell : UITableViewCell

- (void)cellWithForecast:(SWAForecastDB *)forecast;

@end
