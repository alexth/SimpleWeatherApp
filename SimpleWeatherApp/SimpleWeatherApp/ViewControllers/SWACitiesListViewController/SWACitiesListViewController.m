//
//  SWACitiesListViewController.m
//  SimpleWeatherApp
//
//  Created by Alex Golub on 1/11/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

#import "SWACitiesListViewController.h"

#import "SWACitiesListTableViewCell.h"

@interface SWACitiesListViewController ()

@property (nonatomic, weak) IBOutlet UITableView *citiesListTableView;

@end

static NSString * const kCitiesListTableViewCellIdentifier = @"citiesListTableViewCell";
static const NSUInteger kCitiesListTableViewSectionsCount = 1;
static const CGFloat kCitiesListTableViewCellHeight = 50.0f;

@implementation SWACitiesListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return kCitiesListTableViewSectionsCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWACitiesListTableViewCell *cell = (SWACitiesListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kCitiesListTableViewCellIdentifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCitiesListTableViewCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

#pragma mark - Utils

- (void)applyStyle
{
    
}

@end
