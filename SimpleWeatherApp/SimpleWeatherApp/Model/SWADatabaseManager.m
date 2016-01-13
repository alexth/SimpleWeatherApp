//
//  SWADatabaseManager.m
//  SimpleWeatherApp
//
//  Created by Alex Golub on 1/10/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

#import "SWADatabaseManager.h"
#import "SynthesizeSingleton.h"

#import "SWACityDB.h"
#import "SWAForecastDB.h"

@interface SWADatabaseManager ()

@end

static NSString * const kCityNameProperty = @"name";
static NSString * const kForecastDateProperty = @"date";

@implementation SWADatabaseManager
SYNTHESIZE_SINGLETON_FOR_CLASS(SWADatabaseManager)

@synthesize managedObjectContext = _managedObjectContext;
@synthesize backgroundManagedObjectContext = _backgroundManagedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#pragma mark - Core Data stack

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel != nil)
    {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SimpleWeatherApp" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil)
    {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SimpleWeatherApp.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
    {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext
{
    if (_managedObjectContext != nil)
    {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator)
    {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    
    return _managedObjectContext;
}

#pragma mark - Core Data Saving Support

- (void)saveContext
{
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil)
    {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

#pragma mark - CreateUpdates

- (void)createOrUpdateCityFromDictionary:(NSDictionary *)dataDictionary
{
    NSDictionary *responseDictionary = dataDictionary[@"data"];
    NSString *cityName = [self cityNameFromResponseDictionary:responseDictionary];
    NSArray *citiesArray = [self fetchCityWithName:dataDictionary[cityName]];
    if (citiesArray.count == 0)
    {
        SWACityDB *newCity = [NSEntityDescription insertNewObjectForEntityForName:kCityEntityName
                                                           inManagedObjectContext:self.managedObjectContext];
        newCity.name = cityName;
        newCity.isDisplayed = @(YES);
        newCity.isSelected = @(YES);
    }
    else if (citiesArray.count == 1)
    {
        SWACityDB *existingCity = citiesArray[0];
        existingCity.isDisplayed = @(YES);
        existingCity.isSelected = @(YES);
    }
    else
    {
#warning - track doublings of cities entities
    }
    
    [self saveContext];
}

#pragma mark - Fetches

- (NSArray *)fetchCityWithName:(NSString *)nameString
{
    NSFetchRequest *cityWithNameFetchRequest = [self cityWithNameFetchRequest:nameString];
    NSError *error = nil;
    
    return [self.managedObjectContext executeFetchRequest:cityWithNameFetchRequest error:&error];
}

#pragma mark - Fetch Requests

- (NSFetchRequest *)allCitiesFetchRequest
{
    return [self citiesFetchRequestWithPredicate:nil];
}

- (NSFetchRequest *)selectedCityFetchRequest
{
    return [self citiesFetchRequestWithPredicate:[NSPredicate predicateWithFormat:@"isSelected == %@", @(YES)]];
}

- (NSFetchRequest *)cityWithNameFetchRequest:(NSString *)nameString
{
    return [self citiesFetchRequestWithPredicate:[NSPredicate predicateWithFormat:@"name == %@", nameString]];
}

- (NSFetchRequest *)displayedCitiesFetchRequest
{
    return [self citiesFetchRequestWithPredicate:[NSPredicate predicateWithFormat:@"isDisplayed == %@", @(YES)]];
}

- (NSFetchRequest *)citiesFetchRequestWithPredicate:(NSPredicate *)predicate
{
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    [fetchRequest setEntity:[NSEntityDescription entityForName:kCityEntityName
                                        inManagedObjectContext:self.managedObjectContext]];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setSortDescriptors:@[[[NSSortDescriptor alloc]initWithKey:kCityNameProperty ascending:YES]]];
    
    return fetchRequest;
}

- (NSFetchRequest *)forecastsFetchRequestForCity:(SWACityDB *)city
{
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    [fetchRequest setEntity:[NSEntityDescription entityForName:kForecastEntityName
                                        inManagedObjectContext:self.managedObjectContext]];
    [fetchRequest setFetchLimit:kFutureForecastsCount];
    [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"city == %@", city]];
    [fetchRequest setSortDescriptors:@[[[NSSortDescriptor alloc]initWithKey:kForecastDateProperty ascending:YES]]];
    
    return fetchRequest;
}


#pragma mark - Utils

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSString *)cityNameFromResponseDictionary:(NSDictionary *)responseDictionary
{
    NSArray *cityDataArray = responseDictionary[@"request"];
    if (cityDataArray.count > 0)
    {
        NSDictionary *cityDataDictionary = cityDataArray[0];
        return cityDataDictionary[@"query"];
    }
    else
    {
        return @"Unknown City";
    }
    
    return nil;
}

@end
