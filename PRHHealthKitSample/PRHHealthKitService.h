//
//  PRHHealthKitService.h
//  PRHHealthKitSample
//
//  Created by 清 貴幸 on 2015/04/22.
//  Copyright (c) 2015年 VOYAGE GROUP. All rights reserved.
//

#import <Foundation/Foundation.h>
@import HealthKit;

typedef NS_ENUM(NSInteger, PRHUniteType) {
    PRHUniteTypeHour,
    PRHUniteTypeDate,
    PRHUniteTypeWeek,
    PRHUniteTypeMonth,
};

@interface PRHHealthKitService : NSObject

+ (instancetype)sharedService;

- (void)stepCountCollectionWithUnitType:(PRHUniteType)unitType completionHandler:(void (^)(HKStatisticsCollectionQuery *query, HKStatisticsCollection *result, NSError *error))completion;

@end
