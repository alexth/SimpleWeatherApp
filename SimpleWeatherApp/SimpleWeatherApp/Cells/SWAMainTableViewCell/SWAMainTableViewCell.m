//
//  SWAMainTableViewCell.m
//  SimpleWeatherApp
//
//  Created by Alex Golub on 1/11/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

#import "SWAMainTableViewCell.h"

#import "SWAForecastDB.h"

@interface SWAMainTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *temperatureLabel;

@end

@implementation SWAMainTableViewCell

#pragma mark - Setup

- (void)cellWithForecast:(SWAForecastDB *)forecast
{
    self.dateLabel.text = [[SWADatabaseManager sharedInstance]dateStringFromDate:forecast.date];
    self.temperatureLabel.text = [NSString stringWithFormat:@"%@C / %@C", forecast.minTemperature, forecast.maxTemperature];
}

@end
