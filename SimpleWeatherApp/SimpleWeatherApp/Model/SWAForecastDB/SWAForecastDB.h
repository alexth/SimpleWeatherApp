//
//  SWAForecastDB.h
//  
//
//  Created by Alex Golub on 1/13/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SWACityDB;

@interface SWAForecastDB : NSManagedObject

@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSNumber *maxTemperature;
@property (nonatomic, retain) NSNumber *minTemperature;
@property (nonatomic, retain) NSDate *updateDate;
@property (nonatomic, retain) SWACityDB *city;

@end
