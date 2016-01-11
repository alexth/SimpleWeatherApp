//
//  SWAMainViewController.m
//  SimpleWeatherApp
//
//  Created by Alex Golub on 1/9/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

#import "SWAMainViewController.h"

#import "SWAMainTableViewCell.h"

@interface SWAMainViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UIBarButtonItem *citiesButton;
@property (nonatomic, weak) IBOutlet UILabel *infoLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *temperatureLabel;
@property (nonatomic, weak) IBOutlet UITableView *mainTableView;

- (IBAction)citiesButtonDidPressed:(UIButton *)button;

@end

static NSString * const kMainTableViewCellIdentifier = @"mainTableViewCell";
static const NSUInteger kMainTableViewSectionsCount = 1;
static const CGFloat kMainTableViewCellHeight = 50.0f;

@implementation SWAMainViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self refreshData];
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return kMainTableViewSectionsCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    SWAMainTableViewCell *cell = (SWAMainTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kMainTableViewCellIdentifier forIndexPath:indexPath];
    
    return cell;
}

#pragma mark - TableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kMainTableViewCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

#pragma mark - Actions

- (IBAction)citiesButtonDidPressed:(UIButton *)button
{
    
}

#pragma mark - Utils

- (void)applyStyle
{
    
}

- (void)refreshData
{
    
}

@end
