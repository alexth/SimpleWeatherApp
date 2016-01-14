//
//  SWACitiesListViewController.h
//  SimpleWeatherApp
//
//  Created by Alex Golub on 1/11/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

#import "SWARootViewController.h"

@class SWACityDB;

@protocol SWACitiesListViewControllerDelegate;

@interface SWACitiesListViewController : SWARootViewController

@property (nonatomic, weak) id <SWACitiesListViewControllerDelegate> delegate;

@end

@protocol SWACitiesListViewControllerDelegate <NSObject>
- (void)citySelected:(SWACityDB *)city;
@end
