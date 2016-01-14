//
//  SWACityDB+CoreDataProperties.h
//  
//
//  Created by Alex Golub on 1/13/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SWACityDB.h"

@class SWAForecastDB;

NS_ASSUME_NONNULL_BEGIN

@interface SWACityDB (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *isSelected;
@property (nullable, nonatomic, retain) SWAForecastDB *forecasts;

@end

@interface SWACityDB (CoreDataGeneratedAccessors)

- (void)addForecastObject:(SWAForecastDB *)value;
- (void)removeForecastObject:(SWAForecastDB *)value;
- (void)addForecasts:(NSSet<SWAForecastDB *> *)values;
- (void)removeForecasts:(NSSet<SWAForecastDB *> *)values;

@end

NS_ASSUME_NONNULL_END
