//
//  SWADatabaseManager.h
//  SimpleWeatherApp
//
//  Created by Alex Golub on 1/10/16.
//  Copyright © 2016 Alex Golub. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SWACityDB;

@interface SWADatabaseManager : NSObject

+ (SWADatabaseManager *)sharedInstance;

/// Core Data Stack
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectContext *backgroundManagedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

// CreateUpdates
- (SWACityDB *)createOrUpdateCityFromDictionary:(NSDictionary *)dataDictionary;

// Utils
- (NSString *)dateStringFromDate:(NSDate *)date;

@end
