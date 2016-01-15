//
//  SWAMainViewController.m
//  SimpleWeatherApp
//
//  Created by Alex Golub on 1/9/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

#import "SWAMainViewController.h"
#import "SWACitiesListViewController.h"

#import "SWAMainTableViewCell.h"

#import "SWACityDB.h"
#import "SWAForecastDB.h"

@interface SWAMainViewController () <UITableViewDataSource, UITableViewDelegate, SWACitiesListViewControllerDelegate>

@property (nonatomic, weak) IBOutlet UIBarButtonItem *citiesButton;
@property (nonatomic, weak) IBOutlet UILabel *cityNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *temperatureLabel;
@property (nonatomic, weak) IBOutlet UITableView *mainTableView;

@property (nonatomic, strong) SWACityDB *selectedCity;
@property (nonatomic, strong) NSArray *forecastsArray;

- (IBAction)citiesButtonDidPressed:(UIButton *)button;

@end

static NSString * const kMainTableViewCellIdentifier = @"mainTableViewCell";
static NSString * const kToCitiesListSegue = @"toCitiesList";
static const NSUInteger kMainTableViewSectionsCount = 1;
static const CGFloat kMainTableViewCellHeight = 50.0f;

@implementation SWAMainViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refreshData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kToCitiesListSegue])
    {
        SWACitiesListViewController *slvc = segue.destinationViewController;
        slvc.delegate = self;
    }
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return kMainTableViewSectionsCount;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.selectedCity.forecasts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    SWAMainTableViewCell *cell = (SWAMainTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kMainTableViewCellIdentifier forIndexPath:indexPath];
    SWAForecastDB *forecast = self.forecastsArray[indexPath.row];
    [cell cellWithForecast:forecast];
    
    return cell;
}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kMainTableViewCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

#pragma mark - CitiesList ViewController Delegate

- (void)citySelected:(SWACityDB *)city
{
    self.selectedCity = city;
    [self refreshData];
}

#pragma mark - Actions

- (IBAction)citiesButtonDidPressed:(UIButton *)button
{
    
}

#pragma mark - Utils

- (void)applyStyle
{
    //TODO: Design UI
}

- (void)refreshData
{
    self.forecastsArray = [self.selectedCity.forecasts allObjects];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    self.forecastsArray = [self.forecastsArray sortedArrayUsingDescriptors:@[sortDescriptor]];
    
    SWAForecastDB *currentForecast = self.forecastsArray[0];
    self.temperatureLabel.text = [NSString stringWithFormat:@"%@C / %@C", currentForecast.minTemperature, currentForecast.maxTemperature];
    
    self.cityNameLabel.text = self.selectedCity.name;
    self.dateLabel.text = [self.databaseManager dateStringFromDate:[NSDate date]];
    [self.mainTableView reloadData];
}

@end
