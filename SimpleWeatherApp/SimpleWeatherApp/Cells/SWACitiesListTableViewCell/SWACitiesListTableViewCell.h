//
//  SWACitiesListTableViewCell.h
//  SimpleWeatherApp
//
//  Created by Alex Golub on 1/11/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SWACityDB;

@interface SWACitiesListTableViewCell : UITableViewCell

- (void)cellWithCity:(SWACityDB *)city;

@end
