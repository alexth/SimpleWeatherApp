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

NS_ASSUME_NONNULL_BEGIN

@interface SWACityDB (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *displayed;
@property (nullable, nonatomic, retain) NSManagedObject *forecasts;

@end

NS_ASSUME_NONNULL_END
