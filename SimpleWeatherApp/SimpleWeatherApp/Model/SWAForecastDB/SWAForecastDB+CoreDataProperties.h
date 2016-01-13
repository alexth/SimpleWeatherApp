//
//  SWAForecastDB+CoreDataProperties.h
//  
//
//  Created by Alex Golub on 1/13/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SWAForecastDB.h"

NS_ASSUME_NONNULL_BEGIN

@interface SWAForecastDB (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *date;
@property (nullable, nonatomic, retain) NSNumber *temperature;
@property (nullable, nonatomic, retain) NSDate *updateDate;
@property (nullable, nonatomic, retain) SWACityDB *city;

@end

NS_ASSUME_NONNULL_END
