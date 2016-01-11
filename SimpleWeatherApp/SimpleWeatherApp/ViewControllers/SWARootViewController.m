//
//  SWARootViewController.m
//  SimpleWeatherApp
//
//  Created by Alex Golub on 1/11/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

#import "SWARootViewController.h"

@interface SWARootViewController ()

@end

@implementation SWARootViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    // do not call instances before call +super in subclasses -viewDidLoad
    _databaseManager = [SWADatabaseManager sharedInstance];
    _requestManager = [SWARequestManager sharedInstance];
    
    [super viewDidLoad];
    
    [self applyStyle];
}

- (void)applyStyle
{
    // method to be redefined in subclasses
}

@end
