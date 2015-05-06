//
//  PRHHealthKitService.h
//  PRHHealthKitSample
//
//  Created by 清 貴幸 on 2015/04/22.
//  Copyright (c) 2015年 VOYAGE GROUP. All rights reserved.
//

#import <Foundation/Foundation.h>
@import HealthKit;

typedef NS_ENUM(NSInteger, PRHHealthKitStatisticsCollectionUniteType) {
    PRHHealthKitStatisticsCollectionUniteTypeHour,
    PRHHealthKitStatisticsCollectionUniteTypeDate,
    PRHHealthKitStatisticsCollectionUniteTypeWeek,
    PRHHealthKitStatisticsCollectionUniteTypeMonth,
    PRHHealthKitStatisticsCollectionUniteTypeYear,
};

@interface PRHHealthKitService : NSObject

+ (instancetype)sharedService;

- (void)stepCountCollectionWithUnitType:(PRHHealthKitStatisticsCollectionUniteType)unitType quantitySamplePredicate:(NSPredicate *)predicate completionHandler:(void (^)(HKStatisticsCollectionQuery *, HKStatisticsCollection *, NSError *))completion;
@end
