//
//  SWACitiesListViewController.m
//  SimpleWeatherApp
//
//  Created by Alex Golub on 1/11/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

#import "SWACitiesListViewController.h"

#import "SWACitiesListTableViewCell.h"

#import "SWACityDB.h"

@interface SWACitiesListViewController () <UISearchBarDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, weak) IBOutlet UISearchBar *citiesSearchBar;
@property (nonatomic, weak) IBOutlet UITableView *citiesListTableView;

@property (nonatomic, weak) NSFetchedResultsController *citiesFRC;

@end

static NSString * const kCitiesListTableViewCellIdentifier = @"citiesListTableViewCell";
static const CGFloat kCitiesListTableViewCellHeight = 50.0f;

@implementation SWACitiesListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSError *error = nil;
    BOOL performFetch = [[self citiesFRC] performFetch:&error];
    if (!performFetch)
    {
        NSLog(@"Error! %@", [error localizedFailureReason]);
        NSAssert(performFetch == NO, @"Instance of the FDProfile can not be created");
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

- (void)searchBar:(UISearchBar *)searchBar
    textDidChange:(NSString *)searchText
{
    if ([searchText length] == 0)
    {
        
    }
    else
    {
        
    }
    [self.citiesListTableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (searchBar.text.length > 0)
    {
        __weak typeof(self) weakSelf = self;
        [self.requestManager GETForecastForCity:searchBar.text
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
                                           //TODO: Handle error
                                       }
                                   }];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}

#pragma mark - Utils

- (void)applyStyle
{
    //TODO: Design UI
}

@end
