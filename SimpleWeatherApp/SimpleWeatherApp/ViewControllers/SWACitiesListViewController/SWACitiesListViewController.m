//
//  SWACitiesListViewController.m
//  SimpleWeatherApp
//
//  Created by Alex Golub on 1/11/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

#import "SWACitiesListViewController.h"

#import "SWACitiesListTableViewCell.h"

#import "CRToast.h"

#import "SWACityDB.h"

@interface SWACitiesListViewController () <UISearchBarDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, weak) IBOutlet UISearchBar *citiesSearchBar;
@property (nonatomic, weak) IBOutlet UITableView *citiesListTableView;

@property (nonatomic, strong) NSFetchedResultsController *citiesFRC;

@end

static NSString * const kCitiesListTableViewCellIdentifier = @"citiesListTableViewCell";
static const CGFloat kCitiesListTableViewCellHeight = 50.0f;

@implementation SWACitiesListViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad
{
    self.citiesListTableView.allowsMultipleSelectionDuringEditing = NO;
    
    [super viewDidLoad];
    
    NSError *error = nil;
    BOOL performFetch = [[self citiesFRC]performFetch:&error];
    if (!performFetch)
    {
        NSLog(@"Error! %@", [error localizedFailureReason]);
    }
}

#pragma mark - FRC

- (NSFetchedResultsController *)citiesFRC
{
    if (_citiesFRC)
    {
        return _citiesFRC;
    }
    _citiesFRC = [self.databaseManager citiesFRC];
    _citiesFRC.delegate = self;
    
    return _citiesFRC;
}

#pragma mark - FRC Delegate

- (void) controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.citiesListTableView beginUpdates];
}

- (void) controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.citiesListTableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.citiesListTableView;
    
    switch (type)
    {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
        {
            SWACityDB *changedCity = [self.citiesFRC objectAtIndexPath:indexPath];
            SWACitiesListTableViewCell *cell = (SWACitiesListTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            [cell cellWithCity:changedCity];
        }
            break;
            
        case NSFetchedResultsChangeMove:
        {
            [tableView deleteRowsAtIndexPaths:@[indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
        }
    }
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
    switch (type)
    {
        case NSFetchedResultsChangeInsert:
            [self.citiesListTableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                                    withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.citiesListTableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                                    withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            break;
        case NSFetchedResultsChangeMove:
            break;
    }
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.citiesFRC sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.citiesFRC sections][section];
    
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SWACitiesListTableViewCell *cell = (SWACitiesListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kCitiesListTableViewCellIdentifier
                                                                                                     forIndexPath:indexPath];
    SWACityDB *city = [self.citiesFRC objectAtIndexPath:indexPath];
    [cell cellWithCity:city];
    
    return cell;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    SWACityDB *selectedCity = [self.citiesFRC objectAtIndexPath:indexPath];
    [self forecastsForCityWithName:selectedCity.name];
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSManagedObjectContext *managedObjectContext = [self.databaseManager managedObjectContext];
        
        [managedObjectContext deleteObject:[self.citiesFRC objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![managedObjectContext save:&error])
        {
            //TODO: handle errorr
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCitiesListTableViewCellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

#pragma mark - Search Bar Delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (searchBar.text.length > 0)
    {
        [self forecastsForCityWithName:searchBar.text];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    searchBar.text = nil;
    [searchBar resignFirstResponder];
}

#pragma mark - Actions

- (void)forecastsForCityWithName:(NSString *)cityNameString
{
    __weak typeof(self) weakSelf = self;
    [self.requestManager GETForecastForCity:[self.databaseManager cityNameFromString:cityNameString]
                               numberOfDays:@(kFutureForecastsCount)
                               successBlock:^(BOOL success, NSDictionary *dataDictionary, NSError *error) {
                                   
                                   if (!error)
                                   {
                                       SWACityDB *city = [weakSelf.databaseManager createOrUpdateCityFromDictionary:dataDictionary];
                                       [weakSelf.delegate citySelected:city];
                                       [weakSelf.navigationController popViewControllerAnimated:YES];
                                   }
                                   else
                                   {
                                       [CRToastManager showNotificationWithOptions:[weakSelf.databaseManager setupDefaultToastWithText:NSLocalizedString(@"Wrong city name!", nil)]
                                                                   completionBlock:nil];
                                   }
                               }];

}

#pragma mark - Utils

- (void)applyStyle
{
    //TODO: Design UI
}

@end
