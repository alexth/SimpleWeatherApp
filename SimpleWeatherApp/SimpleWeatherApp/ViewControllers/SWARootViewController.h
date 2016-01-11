//
//  SWARootViewController.h
//  SimpleWeatherApp
//
//  Created by Alex Golub on 1/11/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SWARootViewController : UIViewController

@property (nonatomic, strong) SWADatabaseManager *databaseManager;
@property (nonatomic, strong) SWARequestManager *requestManager;

@end
