//
//  ViewController.m
//  PRHHealthKitSample
//
//  Created by 清 貴幸 on 2015/04/22.
//  Copyright (c) 2015年 VOYAGE GROUP. All rights reserved.
//

#import "ViewController.h"
#import <NSDate+Escort.h>
@import HealthKit;

@interface ViewController ()

@property (nonatomic) HKHealthStore *healthStore;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.healthStore = [[HKHealthStore alloc] init];
    
    if ([HKHealthStore isHealthDataAvailable]) {
        NSSet *writeDataTypes = [self dataTypesToWrite];
        NSSet *readDataTypes = [self dataTypesToRead];
        
        [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
            if (!success) {
                NSLog(@"You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: %@. If you're using a simulator, try it on a device.", error);
                
                return;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // Update the user interface based on the current user's health information.
                [self updateUsersStepCountLabel];
            });
        }];
    }
}

- (void)updateUsersStepCountLabel {
    HKQuantityType *stepCountType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    NSDateComponents *oneDateComponent = [[NSDateComponents alloc] init];
    oneDateComponent.day = 1;
    HKStatisticsCollectionQuery *query = [[HKStatisticsCollectionQuery alloc] initWithQuantityType:stepCountType
                                                                            quantitySamplePredicate:nil
                                                                                            options:HKStatisticsOptionCumulativeSum
                                                                                         anchorDate:[[NSDate date] dateAtStartOfMonth]
                                                                                 intervalComponents:oneDateComponent];
    [query setInitialResultsHandler:^(HKStatisticsCollectionQuery *query, HKStatisticsCollection *collection, NSError *error) {
       [collection.statistics enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
           HKStatistics *statistics = obj;
           NSLog(@" \n start:%@ \n end:%@ \n count:%@ \n", statistics.startDate, statistics.endDate, statistics.sumQuantity);
       }];
    }];
    [self.healthStore executeQuery:query];
}

- (NSSet *)dataTypesToWrite {
    return nil;
}

// Returns the types of data that Fit wishes to read from HealthKit.
- (NSSet *)dataTypesToRead {
    HKQuantityType *stepCount = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    
    return [NSSet setWithObjects:stepCount, nil];
}

@end
