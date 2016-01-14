//
//  SWACityDB.h
//  
//
//  Created by Alex Golub on 1/13/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SWAForecastDB;

@interface SWACityDB : NSManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *isSelected;
@property (nonatomic, retain) NSSet *forecasts;

@end

@interface SWACityDB (CoreDataGeneratedAccessors)

- (void)addForecastObject:(SWAForecastDB *)value;
- (void)removeForecastObject:(SWAForecastDB *)value;
- (void)addForecasts:(NSSet *)values;
- (void)removeForecasts:(NSSet *)values;

@end

