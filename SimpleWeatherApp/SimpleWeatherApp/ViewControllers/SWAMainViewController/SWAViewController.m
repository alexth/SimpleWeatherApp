//
//  ViewController.m
//  SimpleWeatherApp
//
//  Created by Alex Golub on 1/9/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

#import "SWAViewController.h"

@interface SWAViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UIButton *citiesButton;
@property (nonatomic, weak) IBOutlet UILabel *infoLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *temperatureLabel;
@property (nonatomic, weak) IBOutlet UITableView *mainTableView;

- (IBAction)citiesButtonDidPressed:(UIButton *)button;

@end

static NSString * const kLoginPopupNavigationController = @"loginPopupNavigationController";
static const CGFloat kOneSpeakerCellHeight = 120.0f;

@implementation SWAViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return [self.qvoutsArray count];
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    QVTQvoutDB *qvout = self.qvoutsArray[indexPath.row];
//    
//    QVTQvoutFeedTableViewCell *cell = nil;
//    if (qvout.qvoutSpeakers.count == 1)
//    {
//        cell = [tableView dequeueReusableCellWithIdentifier:kOneSpeakerCellIdentifier forIndexPath:indexPath];
//    }
//    else if (qvout.qvoutSpeakers.count > 1)
//    {
//        cell = [tableView dequeueReusableCellWithIdentifier:kManySpeakersCellIdentifier forIndexPath:indexPath];
//    }
//    [self configureCell:cell withQvout:qvout];
//    
//    return cell;
    
    return nil;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    self.selectedQvout = self.qvoutsArray[indexPath.row];
//    
//    [self performSegueWithIdentifier:kReviewQvoutSegue sender:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    QVTQvoutDB *qvout = self.qvoutsArray[indexPath.row];
//    
//    if ([qvout.qvoutSpeakers count] == 1)
//    {
//        return kOneSpeakerCellHeight;
//    }
//    else
//    {
//        return kManySpeakersCellHeight;
//    }
    
    return CGFLOAT_MIN;
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

@end
