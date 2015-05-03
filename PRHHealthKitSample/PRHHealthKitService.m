//
//  PRHHealthKitService.m
//  PRHHealthKitSample
//
//  Created by 清 貴幸 on 2015/04/22.
//  Copyright (c) 2015年 VOYAGE GROUP. All rights reserved.
//

#import "PRHHealthKitService.h"
#import <NSDate+Escort.h>

static PRHHealthKitService *sharedService;

@interface PRHHealthKitService ()
@property (nonatomic) HKHealthStore *healthStore;
@end

@implementation PRHHealthKitService

+ (instancetype)sharedService {
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedService = [[self alloc] init];
    });

    return sharedService;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.healthStore = [[HKHealthStore alloc] init];

        if ([HKHealthStore isHealthDataAvailable]) {
            NSSet *writeDataTypes = [self dataTypesToWrite];
            NSSet *readDataTypes = [self dataTypesToRead];

            [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
                if (!success) {
                    NSLog(@"You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: %@. If you're using a simulator, try it on a device.", error);
                    
                    return;
                }
            }];
        }
    }
    return self;
}

- (NSSet *)dataTypesToWrite {
    return nil;
}

// Returns the types of data that Fit wishes to read from HealthKit.
- (NSSet *)dataTypesToRead {
    HKQuantityType *stepCount = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];

    return [NSSet setWithObjects:stepCount, nil];
}

#pragma mark - Statistic methods

- (void)stepCountCollectionFromTodayWithSubstructingMonth:(NSInteger)substructingMonth UnitType:(PRHUniteType)unitType completionHandler:(void (^)(HKStatisticsCollectionQuery *, HKStatisticsCollection *, NSError *))completion {
    NSDateComponents *oneDateComponent = [[NSDateComponents alloc] init];
    oneDateComponent.day = 1;
    [self stepCountCollectionWithDateConponents:oneDateComponent
                              completionHandler:completion];
}

- (void)stepCountCollectionWithDateConponents:(NSDateComponents *)components completionHandler:(void (^)(HKStatisticsCollectionQuery *, HKStatisticsCollection *, NSError *))completion {
    HKQuantityType *stepCountType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKStatisticsCollectionQuery *query = [[HKStatisticsCollectionQuery alloc] initWithQuantityType:stepCountType
                                                                           quantitySamplePredicate:nil
                                                                                           options:HKStatisticsOptionCumulativeSum
                                                                                        anchorDate:[[NSDate date] dateAtStartOfMonth]
                                                                                intervalComponents:components];
    [query setInitialResultsHandler:completion];

    [self.healthStore executeQuery:query];
}
@end
