//
//  PRHHealthKitService.h
//  PRHHealthKitSample
//
//  Created by 清 貴幸 on 2015/04/22.
//  Copyright (c) 2015年 VOYAGE GROUP. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HKStatisticsCollection, HKStatisticsCollectionQuery, HKStatisticsCollection;

@interface PRHHealthKitService : NSObject

+ (instancetype)sharedService;

- (void)stepCountCollectionWithCompletionHandler:(void (^)(HKStatisticsCollectionQuery *query, HKStatisticsCollection *result, NSError *error))completion;

@end
