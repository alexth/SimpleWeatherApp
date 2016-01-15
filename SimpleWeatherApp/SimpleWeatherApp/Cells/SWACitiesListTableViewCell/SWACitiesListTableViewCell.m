//
//  SWACitiesListTableViewCell.m
//  SimpleWeatherApp
//
//  Created by Alex Golub on 1/11/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

#import "SWACitiesListTableViewCell.h"

#import "SWACityDB.h"

@interface SWACitiesListTableViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *cityNameLabel;

@end

@implementation SWACitiesListTableViewCell

#pragma mark - Setup

- (void)cellWithCity:(SWACityDB *)city
{
    self.cityNameLabel.text = city.name;
}

@end
